require_relative './elixir_sips'
require 'csv'
require 'fastimage_resize'

module ElixirSips
  module Utilities
    # Download a given url, turn it into our sizes, and place it in the local directory
    def self.generate_images(episode_csv)
      screenshot_url = episode_csv["Screenshot"]
      screenshot_prefix = CSVHelpers.screenshot_prefix(episode_csv)
      FastImage.resize(screenshot_url, 600, 338, outfile: "./source/images/#{screenshot_prefix}_600x338.png")
      FastImage.resize(screenshot_url, 300, 169, outfile: "./source/images/#{screenshot_prefix}_300x169.png")
    end

    def self.generate_html_file(episode_csv)
      episode = episode_from_csv(episode_csv)
      File.open("./source#{CSVHelpers.html_file_name(episode_csv)}.haml", "w") do |f|
        f.write <<-eos
---
title: "Episode #{episode.title} | Elixir Sips"
---
- episode = episodes[#{episode_csv["Identifier"].to_i-1}]

= partial 'episodes/paid_episode', locals: { episode: episode }
eos
      end
    end

    def self.episode_from_csv(episode_csv)
      Episode.new(CSVHelpers.title(episode_csv),
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
      episodes_csv.sort_by{|e| e["Identifier"] }
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
      episode["Screenshot"].split("/")[-1].split(".")[0]
    end

    def self.title(episode)
      "#{episode["Identifier"]}: #{episode["Title"]}"
    end

    def self.html_file_name(episode)
      screenshot_prefix = screenshot_prefix(episode)
      html_prefix = screenshot_prefix.gsub(/_Screenshot/, "").downcase
      "/episodes/#{html_prefix}.html"
    end

    def self.free_episode?(episode)
      #episode["Free"] == "true"
      false # For now, because we don't have wistia for newer free episodes, they're free on DD
    end
  end

end
