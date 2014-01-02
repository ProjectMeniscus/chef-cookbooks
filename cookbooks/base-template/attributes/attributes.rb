licenses = Chef::DataBagItem.load(node.chef_environment, "licenses")

# Cloud Passage Licenses
normal[:cloudpassage][:license_key] = licenses["cloudpassage"]

# New Relic Licenses
normal[:newrelic][:server_monitoring]['license'] = licenses["newrelic"]
normal[:newrelic][:application_monitoring]['license'] = licenses["newrelic"]