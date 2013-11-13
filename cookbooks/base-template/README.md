# base-template cookbook

This cookbook performs base provisioning for any node in a meniscus environment.  It populates the authorized_keys file, installs NewRelic monitoring agents, installs CloudPassage for IPTables management, and sets up ntpupdate to sync with Rackspace time servers.

# Requirements

cookbook 'authorized_keys'
cokbook'newrelic'
cookbook 'cloudpassage'
cookbook'ntp'

Author:: Steven Gonzales (<steven.gonzales@rackspace.com>)
