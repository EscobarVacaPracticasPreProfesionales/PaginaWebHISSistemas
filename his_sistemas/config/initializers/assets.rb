# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( preview_images.js )
Rails.application.config.assets.precompile += %w( autoc.js )
Rails.application.config.assets.precompile += %w( class_adder.js )
Rails.application.config.assets.precompile += %w( header_footer.css )
Rails.application.config.assets.precompile += %w( registration.css )
Rails.application.config.assets.precompile += %w( references.css )
Rails.application.config.assets.precompile += %w( services.css)
Rails.application.config.assets.precompile += %w( contactus.css )
Rails.application.config.assets.precompile += %w( index.css )
Rails.application.config.assets.precompile += %w( news.css )
Rails.application.config.assets.precompile += %w( search.css )
Rails.application.config.assets.precompile += %w( us.css )
Rails.application.config.assets.precompile += %w( newsTemplate.css )
Rails.application.config.assets.precompile += %w( summernote-init.js )
Rails.application.config.assets.precompile += %w( summernote-es-ES.js )
Rails.application.config.assets.precompile += %w( w3.js )
Rails.application.config.assets.precompile += %w( intlTelInput.js )
Rails.application.config.assets.precompile += %w( utils.js )
Rails.application.config.assets.precompile += %w( initTel.js )
