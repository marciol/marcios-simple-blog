require 'acts-as-taggable-on'

ActiveRecord::Base.send :include, ActiveRecord::Acts::TaggableOn
ActiveRecord::Base.send :include, ActiveRecord::Acts::Tagger
ActionController::Base.send :helper, TagsHelper 

RAILS_DEFAULT_LOGGER.info "** acts_as_taggable_on: initialized properly."
