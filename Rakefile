require 'middleman-gh-pages'
require 'sitemap_generator/tasks'
require 'sitemap_generator'

namespace :sitemap do
  desc "Ping search engines re: sitemap"
  task :ping do
    SitemapGenerator::Sitemap.ping_search_engines
  end
end

desc "publish and ping re: sitemap"
task :default => [:publish, 'sitemap:ping']
