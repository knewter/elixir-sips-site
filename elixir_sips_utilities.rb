require_relative './elixir_sips'
require 'csv'
require 'fastimage_resize'

module ElixirSips
  module Utilities
    # Download a given url, turn it into our sizes, and place it in the local directory
    def self.generate_images(episode_csv)
      screenshot_url = episode_csv["Screenshot"]
      screenshot_prefix = CSVHelpers.screenshot_prefix(episode_csv)
      if screenshot_prefix
        FastImage.resize(screenshot_url, 600, 338, outfile: "./source/images/#{screenshot_prefix}_600x338.png")
        FastImage.resize(screenshot_url, 300, 169, outfile: "./source/images/#{screenshot_prefix}_300x169.png")
      end
    end

    def self.generate_html_file(episode_csv)
      episode = episode_from_csv(episode_csv)
      File.open("./source#{CSVHelpers.html_file_name(episode_csv)}.haml", "w") do |f|
        f.write <<-eos
---
title: "Episode #{episode.title} | Elixir Sips"
---
- episode = episode_by_title("#{CSVHelpers.title(episode_csv)}")

= partial 'episodes/paid_episode', locals: { episode: episode }
eos
      end
    end

    def self.episode_from_csv(episode_csv)
      Episode.new(CSVHelpers.identifier(episode_csv),
                  CSVHelpers.title(episode_csv),
                  episode_csv["Teaser"],
                  CSVHelpers.screenshot_prefix(episode_csv),
                  CSVHelpers.html_file_name(episode_csv),
                  CSVHelpers.free_episode?(episode_csv),
                  episode_csv["Video length"].to_i)
    end

    def self.filename
      "episodes_since_209.csv"
    end

    def self.episodes_csv
      CSV.read(filename, headers: true)
        .select{|e| e["Identifier"].to_i >= 209}
    end

    def self.sorted_episodes_csv
      episodes_csv
        .select{|e| e["Screenshot"] != nil}
        .sort_by{|e| e["Identifier"] }
    end

    def self.episodes_since_209
      mapped_episodes =
        sorted_episodes_csv.map do |episode|
          episode_from_csv(episode)
        end
    end
  end

  module CSVHelpers
    def self.screenshot_prefix(episode)
      filename = episode["Screenshot"]
      if filename != nil
        filename.split("/")[-1].split(".")[0]
      else
        puts "Episode #{episode["Identifier"]} has no screenshot!"
        nil
      end
    end

    def self.title(episode)
      "#{identifier(episode)}: #{episode["Title"]}"
    end

    def self.identifier(episode)
      episode["Identifier"]
    end

    def self.html_file_name(episode)
      screenshot_prefix = screenshot_prefix(episode)
      html_prefix = screenshot_prefix.gsub(/_Screenshot/, "").downcase
      html_prefix = html_prefix.split("_")[1..-1].join("_")
      html_prefix = "#{identifier(episode)}_#{html_prefix}"
      "/episodes/#{html_prefix}.html"
    end

    def self.free_episode?(episode)
      #episode["Free"] == "true"
      false # For now, because we don't have wistia for newer free episodes, they're free on DD
    end
  end

end
