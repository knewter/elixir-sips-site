# Elixir Sips Site

This is the repo where I will work on the Elixir Sips website.

## Deployment

To deploy the site:

```
rake
```

This will both publish the site and ping google and bing re: the sitemap...if
you just run publish, it won't ping search engines.

## Development

To develop with the site, you need to install the required gems:

```
bundle
```

That will install the gems from the Gemfile.

While developing the site:

```
middleman server
```
