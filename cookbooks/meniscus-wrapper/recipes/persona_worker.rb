Chef::Log.error("running meniscus-wrapper::persona_worker")

node.set[:cloudpassage][:server_tag] = "#{node.environment}-worker"

include_recipe 'meniscus-wrapper'
include_recipe 'meniscus::persona_worker'
include_recipe 'meniscus::search_discovery'
include_recipe 'meniscus'