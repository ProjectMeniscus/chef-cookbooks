Chef::Log.info("Processing meniscus-wrapper::persona_coordinator")

node.set[:cloudpassage][:server_tag] = "#{node.environment}-coordinator"

include_recipe 'meniscus-wrapper'
include_recipe 'meniscus::persona_coordinator'
include_recipe 'meniscus::search_discovery'
include_recipe 'meniscus'