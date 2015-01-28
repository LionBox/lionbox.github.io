###
# Compass
###

# Change Compass configuration
compass_config do |config|
  # Require any additional compass plugins here.
  # Bootstrap
  config.add_import_path "bower_components/bootstrap-sass-official/assets"

  # Set this to the root of your project when deployed:
  config.http_path = "/"
  config.css_dir = "assets/stylesheets"
  config.sass_dir = "assets/stylesheets"
  config.fonts_dir = "assets/fonts"
  config.images_dir = "assets/images"
  config.javascripts_dir = "assets/javascripts"
end

###
# Blog settings
###

Time.zone = "Europe/London"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

set :casper, {
  blog: {
    url: 'http://www.lionbox.github.io',
    name: 'LionBox',
    description: 'This website is under construction',
    date_format: '%d %B %Y',
    logo: nil # Optional
  },
  author: {
    name: 'LionBox',
    bio: 'LionBox is a company! ' \
         '',
    location: nil, # Optional
    website: nil, # Optional
    gravatar_email: nil # Optional
  }
}

page '/feed.xml', layout: false
page '/sitemap.xml', layout: false

ignore '/partials/*'

ready do
  blog.tags.each do |tag, articles|
    proxy "/tag/#{tag.downcase.parameterize}/feed.xml", '/feed.xml', layout: false do
      @tagname = tag
      @articles = articles[0..5]
    end
  end

  proxy "/author/#{blog_author.name.parameterize}.html", '/author.html', ignore: true
end


# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end


###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Pretty URLs - http://middlemanapp.com/basics/pretty-urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: true

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'assets/stylesheets'

set :js_dir, 'assets/javascripts'

set :images_dir, 'assets/images'

set :partials_dir, 'layouts/partials'

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
  # set :http_prefix, "/Content/images/"
end

# github deploy
 activate :deploy do |deploy|
   deploy.method = :git
   deploy.build_before = true
   deploy.branch   = "master"
   deploy.remote   = "https://github.com/LionBox/lionbox.github.io.git"
end

