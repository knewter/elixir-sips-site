require 'extensions/sitemap'

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

activate :sitemap_generator

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

class Episode < Struct.new(:title, :synopsis, :cover_image_base, :url, :free, :length)
  def title_with_subscriber_tag
    [].tap do |parts|
      parts << title
      parts << "[Subscribers Only]" unless free?
    end.join(" ")
  end

  def cover_image_url
    cover_image_base + "_600x338.png"
  end

  def small_cover_image_url
    cover_image_base + "_300x169.png"
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

  def raw_hours_and_minutes(total_seconds)
    total_minutes = total_seconds / 60
    hours = total_minutes / 60
    minutes = total_minutes - (hours * 60)
    seconds = total_seconds - (minutes * 60) - (hours * 60 * 60)
    [hours, minutes, seconds]
  end

  def hours_and_minutes(total_seconds)
    hours, minutes, seconds = raw_hours_and_minutes(total_seconds)
    pretty_minutes = minutes.to_s.rjust(2, "0")
    pretty_seconds = seconds.to_s.rjust(2, "0")
    "#{hours}:#{pretty_minutes}:#{pretty_seconds}"
  end

  def schema_duration(total_seconds)
    hours, minutes, seconds = raw_hours_and_minutes(total_seconds)
    "T#{minutes}M#{seconds}S"
  end

  def total_time
    episodes.map(&:length).inject(:+)
  end

  def free_episodes
    episodes.select do |episode|
      episode.free?
    end
  end

  def url(path)
    "http://elixirsips.com/#{path}"
  end

  def episodes
    [
      Episode.new("001: Introduction and Installing Elixir",
                  "A quick introduction to the screencast, followed by an Erlang / Elixir installation walkthrough.",
                  "001_Introduction_and_Installing_Elixir_Cover_Image",
                 "/episodes/001_introduction_and_installing_elixir.html",
                 true,
                 346),
      Episode.new("002: Basic Elixir",
                  "A quick overview of some of the basic types in Elixir: Atoms, Numbers, Lists, Tuples, Regexes, and Booleans...",
                  "002_Basic_Elixir_Cover_Image",
                  "/episodes/002_basic_elixir.html",
                  false,
                  336),
      Episode.new("003: Pattern Matching",
                  "A discussion of pattern matching in Elixir.",
                  "003_Pattern_Matching_Screenshot",
                  "/episodes/003_pattern_matching.html",
                  false,
                  348),
      Episode.new("004: Functions",
                  "An overview of functions in Elixir: Defining them, calling them, and using them as first-class types.",
                  "004_Functions_Screenshot",
                  "/episodes/004_functions.html",
                  false,
                  330),
      Episode.new("005: Mix and Modules",
                  "Using Mix to generate an app, and defining modules and functions.",
                  "005_Modules_Screenshot",
                  "/episodes/005_modules.html",
                  false,
                  417),
      Episode.new("006: Unit Testing",
                  "Test Driving a module into existence in Elixir.",
                  "006_Testing_Screenshot",
                  "/episodes/006_testing.html",
                  false,
                  1313),
      Episode.new("007: Dynamo, Part 1",
                  "The first part to an introduction to building a web application in Elixir using Dynamo.",
                  "007_Dynamo_Part_1_Screenshot",
                  "/episodes/007_dynamo_part_1.html",
                  true,
                  458),
      Episode.new("008: Dynamo, Part 2",
                  "An introduction to Amnesia for persistence, and a brief pointer to Ecto.",
                  "008_Dynamo_Part_2_Screenshot",
                  "/episodes/008_dynamo_part_2.html",
                  false,
                  685),
      Episode.new("009: Dynamo, Part 3",
                  "Integrating Amnesia and Dynamo to create a web app with a persistence layer.",
                  "009_Dynamo_Part_3_Screenshot",
                  "/episodes/009_dynamo_part_3.html",
                  false,
                  406),
      Episode.new("010: List Comprehensions",
                  "An overview of list comprehensions in Elixir, or: buildings lists from lists (of lists?).",
                  "010_List_Comprehensions_Screenshot",
                  "/episodes/010_list_comprehensions.html",
                  false,
                  299),
      Episode.new("011: Records",
                  "An overview of records in Elixir; what they are, how they're used.",
                  "011_Records_Screenshot",
                  "/episodes/011_records.html",
                  false,
                  234),
      Episode.new("012: Processes",
                  "A discussion of processes in Elixir, and general concurrent programming with messaging.",
                  "012_Processes_Screenshot",
                  "/episodes/012_processes.html",
                  false,
                  589),
      Episode.new("013: Processes, Part 2",
                  "Modeling a Bank Account in Elixir using processes: encapsulating state, CQRS, and Event Sourcing.",
                  "013_Processes_Part_2_Screenshot",
                  "/episodes/013_processes_part_2.html",
                  false,
                  624),
      Episode.new("014: OTP Part 1 - Servers",
                  "Introduction to OTP, and building and testing a module that implements GenServer.Behaviour.",
                  "014_OTP_Part_1_Servers_Screenshot",
                  "/episodes/014_otp_part_1_servers.html",
                  false,
                  555),
      Episode.new("015: OTP Part 2 - Finite State Machines",
                  "An overview of what Finite State Machines are good for, and implementing GenFSM.Behaviour to build an acceptor state machine.",
                  "015_OTP_Part_2_Finite_State_Machines_Screenshot",
                  "/episodes/015_otp_part_2_finite_state_machines.html",
                  false,
                  775),
      Episode.new("016: Pipe Operator",
                  "An introduction to the pipe operator, and an example app mimicking a unix pipeline.",
                  "016_Pipe_Operator_Screenshot",
                  "/episodes/016_pipe_operator.html",
                  false,
                  802),
      Episode.new("017: Enum, Part 1",
                  "A brief overview of the first portion of the Enum module from the standard library",
                  "017_Enum_Part_1_Screenshot",
                  "/episodes/017_enum_part_1.html",
                  false,
                  303),
      Episode.new("018: Enum, Part 2",
                  "A brief overview of the second portion of the Enum module from the standard library",
                  "018_Enum_Part_2_Screenshot",
                  "/episodes/018_enum_part_2.html",
                  false,
                  323),
      Episode.new("019: Enum, Part 3",
                  "Wrapping up the Enum module",
                  "019_Enum_Part_3_Screenshot",
                  "/episodes/019_enum_part_3.html",
                  false,
                  459),
      Episode.new("020: OTP, Part 3 - GenEvent",
                  "Getting started with the GenEvent Behaviour",
                  "020_OTP_Part_3_GenEvent_Screenshot",
                  "/episodes/020_otp_part_3_gen_event.html",
                  false,
                  642),
      Episode.new("021: ZeldaCat, Part 2",
                  "More practice with GenEvent",
                  "021_ZeldaCat_Part_2_Screenshot",
                  "/episodes/021_zeldacat_part_2.html",
                  false,
                  434),
      Episode.new("022: OTP, Part 4 - Supervisors",
                  "How supervisors can help you 'let it crash.'",
                  "022_OTP_Part_4_Supervisors_Screenshot",
                  "/episodes/022_otp_part_4_supervisors.html",
                  false,
                  596),
      Episode.new("023: OTP, Part 5 - Supervisors and Persistent State",
                  "Making a supervised process's state live through a crash.",
                  "023_OTP_Part_5_Supervisors_and_Persistent_State_Screenshot",
                  "/episodes/023_otp_part_5_supervisors_and_persistent_state.html",
                  false,
                  711),
      Episode.new("024: Ecto, Part 1",
                  "An introduction to using Ecto and Postgres for persistence.",
                  "024_Ecto_Part_1_Screenshot",
                  "/episodes/024_ecto_part_1.html",
                  true,
                  525),
      Episode.new("025: Ecto, Part 2 - Dwitter",
                  "Overhauling our Dynamo webapp to use Ecto for its persistence layer.",
                  "025_Ecto_Part_2_Dwitter_Screenshot",
                  "/episodes/025_ecto_part_2_dynamo.html",
                  false,
                  580),
      Episode.new("026: Dict, Part 1",
                  "A brief overview of the first portion of the Dict module.",
                  "026_Dict_Part_1_Screenshot",
                  "/episodes/026_dict_part_1.html",
                  false,
                  389),
      Episode.new("027: Dict, Part 2",
                  "A brief overview of the second portion of the Dict module.",
                  "027_Dict_Part_2_Screenshot",
                  "/episodes/027_dict_part_2.html",
                  false,
                  291),
      Episode.new("028: Parsing XML",
                  "A glimpse into XML parsing in Elixir, by way of interoperating with an Erlang module.",
                  "028_Parsing_XML_Screenshot",
                  "/episodes/028_parsing_xml.html",
                  true,
                  560),
      Episode.new("029: HTTP Clients",
                  "A survey of the HTTP Client landscape.",
                  "029_HTTP_Clients_Screenshot",
                  "/episodes/029_http_clients.html",
                  false,
                  457),
      Episode.new("030: ExActor",
                  "Simplified generation of generic servers.",
                  "030_ExActor_Screenshot",
                  "/episodes/030_exactor.html",
                  false,
                  336),
      Episode.new("031: TCP Servers",
                  "Building network servers in Elixir using Erlang's `:gen_tcp` module.",
                  "031_TCP_Servers_Screenshot",
                  "/episodes/031_tcp_servers.html",
                  false,
                  219),
      Episode.new("032: Command Line Scripts",
                  "Basic Introduction to writing Elixir scripts that can be invoked and passed arguments from the command line.",
                  "032_Command_Line_Scripts_Screenshot",
                  "/episodes/032_command_line_scripts.html",
                  false,
                  394),
      Episode.new("033: Pry",
                  "Using IEx.pry to inspect and debug a running process.",
                  "033_Pry_Screenshot",
                  "/episodes/033_pry.html",
                  false,
                  98),
      Episode.new("034: Elixiak",
                  "An ActiveRecord-like wrapper for Riak in Elixir",
                  "034_Elixiak_Screenshot",
                  "/episodes/034_elixiak.html",
                  false,
                  98),
      Episode.new("035: Weber",
                  "Building a basic web app with the Weber MVC framework.",
                  "035_Weber_Screenshot",
                  "/episodes/035_weber.html",
                  false,
                  775),
      Episode.new("036: Weber, Part 2 - Performance",
                  "Building a simple cache, and a performance comparison with node.js and ruby.",
                  "036_Weber_Part_2_Screenshot",
                  "/episodes/036_weber_part_2.html",
                  false,
                  1072),
      Episode.new("037: ExLager",
                  "Fantastic logging for your application.",
                  "037_ExLager_Screenshot",
                  "/episodes/037_exlager.html",
                  false,
                  314),
      Episode.new("038: Binaries - Deconstructing and Constructing",
                  "Deconstructing and Constructing lists of bits in Elixir.",
                  "038_Binaries_Deconstructing_and_Constructing_Screenshot",
                  "/episodes/038_binaries_deconstructing_and_constructing.html",
                  false,
                  188),
      Episode.new("039: Binaries - Deconstructing an IP Packet",
                  "Deconstructing an IP Packet in Elixir.",
                  "039_Binaries_Deconstructing_an_IP_Packet_Screenshot",
                  "/episodes/039_binaries_deconstructing_an_ip_packet.html",
                  false,
                  407),
      Episode.new("040: Bitwise",
                  "Manipulating bits; typically useful for wire protocols.",
                  "040_Bitwise_Screenshot",
                  "/episodes/040_bitwise.html",
                  false,
                  195),
      Episode.new("041: File, Part 1",
                  "A brief overview of the first portion of the File module from the standard library.",
                  "041_File_Part_1_Screenshot",
                  "/episodes/041_file_part_1.html",
                  false,
                  195),
      Episode.new("042: File, Part 2",
                  "An overview of the second half of the File module from the standard library.",
                  "042_File_Part_2_Screenshot",
                  "/episodes/042_file_part_2.html",
                  false,
                  234)
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
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  #activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
