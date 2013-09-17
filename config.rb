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

class Episode < Struct.new(:title, :synopsis, :cover_image_url, :url, :free)
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

  def episodes
    [
      Episode.new("Episode 001: Introduction and Installing Elixir",
                  "A quick introduction to the screencast, followed by an Erlang / Elixir installation walkthrough.",
                  "001_Introduction_and_Installing_Elixir_Cover_Image_600x338.png",
                 "/episodes/001_introduction_and_installing_elixir.html",
                 true),
      Episode.new("Episode 002: Basic Elixir",
                  "A quick overview of some of the basic types in Elixir: Atoms, Numbers, Lists, Tuples, Regexes, and Booleans...",
                  "002_Basic_Elixir_Cover_Image_600x338.png",
                  "/episodes/002_basic_elixir.html",
                  false),
      Episode.new("Episode 003: Pattern Matching",
                  "A discussion of pattern matching in Elixir.",
                  "003_Pattern_Matching_Screenshot_600x338.png",
                  "/episodes/003_pattern_matching.html",
                  false),
      Episode.new("Episode 004: Functions",
                  "An overview of functions in Elixir: Defining them, calling them, and using them as first-class types.",
                  "004_Functions_Screenshot_600x338.png",
                  "/episodes/004_functions.html",
                  false),
      Episode.new("Episode 005: Mix and Modules",
                  "Using Mix to generate an app, and defining modules and functions.",
                  "005_Modules_Screenshot_600x338.png",
                  "/episodes/005_modules.html",
                  false),
      Episode.new("Episode 006: Unit Testing",
                  "Test Driving a module into existence in Elixir.",
                  "006_Testing_Screenshot_600x338.png",
                  "/episodes/006_testing.html",
                  false),
      Episode.new("Episode 007: Dynamo, Part 1",
                  "The first part to an introduction to building a web application in Elixir using Dynamo.",
                  "007_Dynamo_Part_1_Screenshot_600x338.png",
                  "/episodes/007_dynamo_part_1.html",
                  true),
      Episode.new("Episode 008: Dynamo, Part 2",
                  "An introduction to Amnesia for persistence, and a brief pointer to Ecto.",
                  "008_Dynamo_Part_2_Screenshot_600x338.png",
                  "/episodes/008_dynamo_part_2.html",
                  false),
      Episode.new("Episode 009: Dynamo, Part 3",
                  "Integrating Amnesia and Dynamo to create a web app with a persistence layer.",
                  "009_Dynamo_Part_3_Screenshot_600x338.png",
                  "/episodes/009_dynamo_part_3.html",
                  false),
      Episode.new("Episode 010: List Comprehensions",
                  "An overview of list comprehensions in Elixir, or: buildings lists from lists (of lists?)",
                  "010_List_Comprehensions_Screenshot_600x338.png",
                  "/episodes/010_list_comprehensions.html",
                  false)
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
