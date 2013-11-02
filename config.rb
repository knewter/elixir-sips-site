###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

class Episode < Struct.new(:title, :synopsis, :cover_image_url, :url, :free, :length)
  def title_with_subscriber_tag
    [].tap do |parts|
      parts << title
      parts << "[Subscribers Only]" unless free?
    end.join(" ")
  end

  def free?
    free
  end

  def paid?
    !free?
  end
end

helpers do
  def nav_active_class(page)
    page_classes === page ? 'active' : ''
  end

  def latest_episode
    episodes.last
  end

  def hours_and_minutes(total_seconds)
    total_minutes = total_seconds / 60
    hours = total_minutes / 60
    minutes = total_minutes - (hours * 60)
    seconds = total_seconds - (minutes * 60) - (hours * 60 * 60)
    pretty_minutes = minutes.to_s.rjust(2, "0")
    pretty_seconds = seconds.to_s.rjust(2, "0")
    "#{hours}:#{pretty_minutes}:#{pretty_seconds}"
  end

  def total_time
    episodes.map(&:length).inject(:+)
  end

  def episodes
    [
      Episode.new("Episode 001: Introduction and Installing Elixir",
                  "A quick introduction to the screencast, followed by an Erlang / Elixir installation walkthrough.",
                  "001_Introduction_and_Installing_Elixir_Cover_Image_600x338.png",
                 "/episodes/001_introduction_and_installing_elixir.html",
                 true,
                 346),
      Episode.new("Episode 002: Basic Elixir",
                  "A quick overview of some of the basic types in Elixir: Atoms, Numbers, Lists, Tuples, Regexes, and Booleans...",
                  "002_Basic_Elixir_Cover_Image_600x338.png",
                  "/episodes/002_basic_elixir.html",
                  false,
                  336),
      Episode.new("Episode 003: Pattern Matching",
                  "A discussion of pattern matching in Elixir.",
                  "003_Pattern_Matching_Screenshot_600x338.png",
                  "/episodes/003_pattern_matching.html",
                  false,
                  348),
      Episode.new("Episode 004: Functions",
                  "An overview of functions in Elixir: Defining them, calling them, and using them as first-class types.",
                  "004_Functions_Screenshot_600x338.png",
                  "/episodes/004_functions.html",
                  false,
                  330),
      Episode.new("Episode 005: Mix and Modules",
                  "Using Mix to generate an app, and defining modules and functions.",
                  "005_Modules_Screenshot_600x338.png",
                  "/episodes/005_modules.html",
                  false,
                  417),
      Episode.new("Episode 006: Unit Testing",
                  "Test Driving a module into existence in Elixir.",
                  "006_Testing_Screenshot_600x338.png",
                  "/episodes/006_testing.html",
                  false,
                  1313),
      Episode.new("Episode 007: Dynamo, Part 1",
                  "The first part to an introduction to building a web application in Elixir using Dynamo.",
                  "007_Dynamo_Part_1_Screenshot_600x338.png",
                  "/episodes/007_dynamo_part_1.html",
                  true,
                  458),
      Episode.new("Episode 008: Dynamo, Part 2",
                  "An introduction to Amnesia for persistence, and a brief pointer to Ecto.",
                  "008_Dynamo_Part_2_Screenshot_600x338.png",
                  "/episodes/008_dynamo_part_2.html",
                  false,
                  685),
      Episode.new("Episode 009: Dynamo, Part 3",
                  "Integrating Amnesia and Dynamo to create a web app with a persistence layer.",
                  "009_Dynamo_Part_3_Screenshot_600x338.png",
                  "/episodes/009_dynamo_part_3.html",
                  false,
                  406),
      Episode.new("Episode 010: List Comprehensions",
                  "An overview of list comprehensions in Elixir, or: buildings lists from lists (of lists?).",
                  "010_List_Comprehensions_Screenshot_600x338.png",
                  "/episodes/010_list_comprehensions.html",
                  false,
                  299),
      Episode.new("Episode 011: Records",
                  "An overview of records in Elixir; what they are, how they're used.",
                  "011_Records_Screenshot_600x338.png",
                  "/episodes/011_records.html",
                  false,
                  234),
      Episode.new("Episode 012: Processes",
                  "A discussion of processes in Elixir, and general concurrent programming with messaging.",
                  "012_Processes_Screenshot_600x338.png",
                  "/episodes/012_processes.html",
                  false,
                  589),
      Episode.new("Episode 013: Processes, Part 2",
                  "Modeling a Bank Account in Elixir using processes: encapsulating state, CQRS, and Event Sourcing.",
                  "013_Processes_Part_2_Screenshot_600x338.png",
                  "/episodes/013_processes_part_2.html",
                  false,
                  624),
      Episode.new("Episode 014: OTP Part 1 - Servers",
                  "Introduction to OTP, and building and testing a module that implements GenServer.Behaviour.",
                  "014_OTP_Part_1_Servers_Screenshot_600x338.png",
                  "/episodes/014_otp_part_1_servers.html",
                  false,
                  555),
      Episode.new("Episode 015: OTP Part 2 - Finite State Machines",
                  "An overview of what Finite State Machines are good for, and implementing GenFSM.Behaviour to build an acceptor state machine.",
                  "015_OTP_Part_2_Finite_State_Machines_Screenshot_600x338.png",
                  "/episodes/015_otp_part_2_finite_state_machines.html",
                  false,
                  775),
      Episode.new("Episode 016: Pipe Operator",
                  "An introduction to the pipe operator, and an example app mimicking a unix pipeline.",
                  "016_Pipe_Operator_Screenshot_600x338.png",
                  "/episodes/016_pipe_operator.html",
                  false,
                  802),
      Episode.new("Episode 017: Enum, Part 1",
                  "A brief overview of the first portion of the Enum module from the standard library",
                  "017_Enum_Part_1_Screenshot_600x338.png",
                  "/episodes/017_enum_part_1.html",
                  false,
                  303),
      Episode.new("Episode 018: Enum, Part 2",
                  "A brief overview of the second portion of the Enum module from the standard library",
                  "018_Enum_Part_2_Screenshot_600x338.png",
                  "/episodes/018_enum_part_2.html",
                  false,
                  323),
      Episode.new("Episode 019: Enum, Part 3",
                  "Wrapping up the Enum module",
                  "019_Enum_Part_3_Screenshot_600x338.png",
                  "/episodes/019_enum_part_3.html",
                  false,
                  459),
      Episode.new("Episode 020: OTP, Part 3 - GenEvent",
                  "Getting started with the GenEvent Behaviour",
                  "020_OTP_Part_3_GenEvent_Screenshot_600x338.png",
                  "/episodes/020_otp_part_3_gen_event.html",
                  false,
                  642),
      Episode.new("Episode 021: ZeldaCat, Part 2",
                  "More practice with GenEvent",
                  "021_ZeldaCat_Part_2_Screenshot_600x338.png",
                  "/episodes/021_zeldacat_part_2.html",
                  false,
                  434),
      Episode.new("Episode 022: OTP, Part 4 - Supervisors",
                  "How supervisors can help you 'let it crash.'",
                  "022_OTP_Part_4_Supervisors_Screenshot_600x338.png",
                  "/episodes/022_otp_part_4_supervisors.html",
                  false,
                  596)
    ]
  end
end

set :haml, format: :html5

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
