# From https://github.com/rails/actionpack-page_caching

# Page caching is an approach to caching where the entire action output is stored as a HTML file that the web server can serve without going through Action Pack. This is the fastest way to cache your content as opposed to going dynamically through the process of generating the content. Unfortunately, this incredible speed-up is only available to stateless pages where all visitors are treated the same. Content management systems -- including weblogs and wikis -- have many pages that are a great fit for this approach, but account-based systems where people log in and manipulate their own data are often less likely candidates.

# First you need to set page_cache_directory in your configuration file:

Rails.application.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"


# Specifying which actions to cache is done through the caches_page class method:
#
# class WeblogController < ActionController::Base
#   caches_page :show, :new
# end

# Expiration of the cache is handled by deleting the cached file, which results in a lazy regeneration approach where the cache is not restored before another hit is made against it. The API for doing so mimics the options from url_for and friends:

# class WeblogController < ActionController::Base
#   def update
#     List.update(params[:list][:id], params[:list])
#     expire_page action: 'show', id: params[:list][:id]
#     redirect_to action: 'show', id: params[:list][:id]
#   end
# end
# Additionally, you can expire caches using Sweepers that act on changes in the model to determine when a cache is supposed to be expired.