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
                  234),
      Episode.new("043: Releases With Relex",
                  "Making your Elixir application redistributable using Erlang releases.",
                  "043_Releases_With_Relex_Screenshot",
                  "/episodes/043_releases_with_relex.html",
                  true,
                  252),
      Episode.new("044: Distribution",
                  "Sending messages from one Elixir node to another.",
                  "044_Distribution_Screenshot",
                  "/episodes/044_distribution.html",
                  false,
                  120),
      Episode.new("045: Distribution, Part 2",
                  "Sending messages to remote machines, and Joe Armstrong's favorite program.",
                  "045_Distribution_Part_2_Screenshot",
                  "/episodes/045_distribution_part_2.html",
                  false,
                  190),
      Episode.new("046: Markdown Server, Part 1",
                  "Building an HTTP Server to render Markdown files, using the Phoenix web framework.",
                  "046_Markdown_Server_Part_1_Screenshot",
                  "/episodes/046_markdown_server_part_1.html",
                  false,
                  408),
      Episode.new("047: Markdown Server, Part 2",
                  "Writing an integration test suite and dealing with macros for the first time.",
                  "047_Markdown_Server_Part_2_Screenshot",
                  "/episodes/047_markdown_server_part_2.html",
                  false,
                  560),
      Episode.new("048: Markdown Server, Part 3",
                  "Using Eml for markup, and bringing in Compass and Zurb Foundation for styles.",
                  "048_Markdown_Server_Part_3_Screenshot",
                  "/episodes/048_markdown_server_part_3.html",
                  false,
                  525),
      Episode.new("049: Markdown Server, Part 4",
                  "Building a poor man's livereload system using inotify and websockets.",
                  "049_Markdown_Server_Part_4_Screenshot",
                  "/episodes/049_markdown_server_part_4.html",
                  false,
                  471),
      Episode.new("050: Markdown Server, Part 5",
                  "Accepting environment variables for configuration and filtering out files we don't want. Plus, a call to action to build BEAM Toolbox.",
                  "050_Markdown_Server_Part_5_Screenshot",
                  "/episodes/050_markdown_server_part_5.html",
                  false,
                  255),
      Episode.new("051: BEAM Toolbox, Part 1",
                  "Introducing BEAM Toolbox and starting work on the data layer.",
                  "051_BEAM_Toolbox_Part_1_Screenshot",
                  "/episodes/051_beam_toolbox_part_1.html",
                  false,
                  478),
      Episode.new("052: BEAM Toolbox, Part 2",
                  "Further work on the data layer, and  introducing defoverridable.",
                  "052_BEAM_Toolbox_Part_2_Screenshot",
                  "/episodes/052_beam_toolbox_part_2.html",
                  false,
                  599),
      Episode.new("053: BEAM Toolbox, Part 3",
                  "Adding an integration testing layer that drives a browser using Hound, extracting a Controller helper, and adding Project pages.",
                  "053_BEAM_Toolbox_Part_3_Screenshot",
                  "/episodes/053_beam_toolbox_part_3.html",
                  false,
                  460),
      Episode.new("054: Maps, Part 1",
                  "An introduction to maps, a new feature in Erlang R17 and Elixir 0.13",
                  "054_Maps_Part_1_Screenshot",
                  "/episodes/054_maps_part_1.html",
                  true,
                  171),
      Episode.new("055: Maps, Part 2 - Structs",
                  "Introducing structs and demonstrating how they can take the place of public Records.",
                  "055_Maps_Part_2_Screenshot",
                  "/episodes/055_maps_part_2.html",
                  true,
                  143),
      Episode.new("056: Migrating Records to Maps",
                  "Converting a production use of Records to use maps instead.",
                  "056_Migrating_Records_To_Maps_Screenshot",
                  "/episodes/056_migrating_records_to_maps.html",
                  false,
                  179),
      Episode.new("057: BEAM Toolbox, Part 4",
                  "Moving our ad-hoc, tuple-based data layer to one powered by maps/structs.",
                  "057_BEAM_Toolbox_Part_4_Screenshot",
                  "/episodes/057_beam_toolbox_part_4.html",
                  false,
                  514),
      Episode.new("058: BEAM Toolbox, Part 5",
                  "Building a module that caches our GitHub data for a given project.",
                  "058_BEAM_Toolbox_Part_5_Screenshot",
                  "/episodes/058_beam_toolbox_part_5.html",
                  false,
                  319),
      Episode.new("059: Custom Mix Tasks",
                  "Looking at building a basic mix task, and how you can go about testing it.",
                  "059_Custom_Mix_Tasks_Screenshot",
                  "/episodes/059_custom_mix_tasks.html",
                  false,
                  177),
      Episode.new("060: New Style Comprehensions",
                  "An overview of the revamped comprehensions in Elixir v0.13",
                  "060_New_Style_Comprehensions_Screenshot",
                  "/episodes/060_new_style_comprehensions.html",
                  false,
                  158),
      Episode.new("061: Plug",
                  "Exploring Elixir's library for building composable web application modules.",
                  "061_Plug_Screenshot",
                  "/episodes/061_plug.html",
                  false,
                  367),
      Episode.new("062: Quickie Synth",
                  "Using processes, gs, and shelling out to `sox` to build an Elixir-based synthesizer module.",
                  "062_Quickie_Synth_Screenshot",
                  "/episodes/062_quickie_synth.html",
                  true,
                  584),
      Episode.new("063: Tracing",
                  "A quick tour of the `dbg` module from Erlang, and its tracing features.",
                  "063_Tracing_Screenshot",
                  "/episodes/063_tracing.html",
                  false,
                  233),
      Episode.new("064: Digraph",
                  "A look at using the `digraph`module from the Erlang standard library to implement pathfinding on a map.",
                  "064_Digraphs_Screenshot",
                  "/episodes/064_digraph.html",
                  false,
                  657),
      Episode.new("065: SSH",
                  "Using Erlang's `ssh` module to provide ssh access to a shell running your Elixir code.",
                  "065_SSH_Screenshot",
                  "/episodes/065_ssh.html",
                  false,
                  126),
      Episode.new("066: Plug.Static",
                  "Serving static files without an opaque and complicated-looking cowboy handler.",
                  "066_Plug_Static_Screenshot",
                  "/episodes/066_plug_static.html",
                  false,
                  120),
      Episode.new("067: Deploying to Heroku",
                  "Using HashNuke's Elixir buildpack for Heroku to deploy BEAM Toolbox.  Also, a brief intro to ExConf.",
                  "067_Deploying_to_Heroku_Screenshot",
                  "/episodes/067_deploying_to_heroku.html",
                  false,
                  383),
      Episode.new("068: Port",
                  "Interacting with external programs as if they were simple processes.",
                  "068_Port_Screenshot",
                  "/episodes/068_port.html",
                  false,
                  238),
      Episode.new("069: Observer",
                  "A graphical tool for inspection of a running Erlang/Elixir system and its processes.",
                  "069_Observer_Screenshot",
                  "/episodes/069_observer.html",
                  false,
                  238),
      Episode.new("070: Hex",
                  "Elixir's new package manager.",
                  "070_Hex_Screenshot",
                  "/episodes/070_hex.html",
                  false,
                  178),
      Episode.new("071: Wx",
                  "Building a GUI calculator using Erlang's native wx bindings.",
                  "071_Wx_Screenshot",
                  "/episodes/071_wx.html",
                  false,
                  496),
      Episode.new("072: WxCalc, Part 2",
                  "Implementing our calculator's logic and wiring it up to wx events.",
                  "072_WxCalc_Part_2_Screenshot",
                  "/episodes/072_wxcalc_part_2.html",
                  false,
                  1126),
      Episode.new("073: Process Dictionaries",
                  "Process-local state that you likely should never use :)",
                  "073_Process_Dictionaries_Screenshot",
                  "/episodes/073_process_dictionaries.html",
                  false,
                  140),
      Episode.new("074: ETS",
                  "Erlang term storage - a queryable database for your processes to store terms in.",
                  "074_ETS_Screenshot",
                  "/episodes/074_ets.html",
                  false,
                  498),
      Episode.new("075: DETS",
                  "A disk-based version of ETS with a few restrictions.",
                  "075_DETS_Screenshot",
                  "/episodes/075_dets.html",
                  false,
                  269),
      Episode.new("076: Streams",
                  "A brief overview of Elixir's 'lazy, composable Enumerables'",
                  "076_Streams_Screenshot",
                  "/episodes/076_streams.html",
                  false,
                  188),
      Episode.new("077: Exceptions and Errors",
                  "Manually raising exceptions, handling them, defining your own, and using them idiomatically.",
                  "077_Exceptions_and_Errors_Screenshot",
                  "/episodes/077_exceptions_and_errors.html",
                  false,
                  137),
      Episode.new("078: Agents",
                  "A simple abstraction around state",
                  "078_Agents_Screenshot",
                  "/episodes/078_agents.html",
                  false,
                  344),
      Episode.new("079: Tasks",
                  "An abstraction for computing a value in the background and receiving the value later.",
                  "079_Tasks_Screenshot",
                  "/episodes/079_tasks.html",
                  false,
                  311),
      Episode.new("080: erlubi",
                  "A client for the Ubigraph visualization server, and an easy way to view a BEAM application's supervision tree in 3D.",
                  "080_erlubi_Screenshot",
                  "/episodes/080_erlubi.html",
                  false,
                  303),
      Episode.new("081: EEx",
                  "Elixir's built-in templating language, useful for embedding Elixir code inside of a string.",
                  "081_EEx_Screenshot",
                  "/episodes/081_eex.html",
                  true,
                  216),
      Episode.new("082: Protocols",
                  "A fantastic method for polymorphism in Elixir.  Pairs well with structs.  Slight oaky flavor.",
                  "082_Protocols_Screenshot",
                  "/episodes/082_protocols.html",
                  false,
                  238),
      Episode.new("083: pg2",
                  "A replacement for the `pg` module that has some better semantics for distribution.",
                  "083_pg2_Screenshot",
                  "/episodes/083_pg2.html",
                  false,
                  332),
      Episode.new("084: PCM Audio",
                  "Generating PCM Audio and making some noise",
                  "084_PCM_Audio_Screenshot",
                  "/episodes/084_pcm_audio.html",
                  true,
                  307),
      Episode.new("085: Apex",
                  "Awesome Print for Elixir.  An easy way to get insight into unfamiliar data structures.",
                  "085_Apex_Screenshot",
                  "/episodes/085_apex.html",
                  false,
                  110),
      Episode.new("086: put_in and get_in",
                  "(and friends) Easy access to deeply nested data structures.",
                  "086_put_in_and_get_in_Screenshot",
                  "/episodes/086_put_in_and_get_in.html",
                  false,
                  412),
      Episode.new("087: WordCloud",
                  "Using Elixir to do a word frequency count on a corpus of text and generate input for a WordCloud generator.",
                  "087_WordCloud_Screenshot",
                  "/episodes/087_word_cloud.html",
                  false,
                  656),
      Episode.new("088: Porcelain",
                  "External Process interaction like the Port module but both simpler and more powerful.",
                  "088_Porcelain_Screenshot",
                  "/episodes/088_porcelain.html",
                  false,
                  603),
      Episode.new("089: Protocol Buffers",
                  "Easy cross-language serialization and deserialization of data structures using Google's Protocol Buffers and exprotobuf.",
                  "089_Protocol_Buffers_Screenshot",
                  "/episodes/089_protocol_buffers.html",
                  false,
                  240)
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
