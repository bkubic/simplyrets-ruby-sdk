#!/usr/bin/env ruby

%w(rubygems simplyrets).each {|lib| require lib}
%w(rubygems simplyrets).each {|models| require models}

require 'simplyrets'

p "SimplyRets Ruby SDK"

SimplyRetsClient.configure do |config|
  config.username = 'simplyrets'
  config.password = 'simplyrets'
  #config.debugging = true
end

# specify a set of latitude/longitude coordinates
points = [ "29.723837146389066,-95.69778442382812", "29.938275329718987,-95.69778442382812", "29.938275329718987,-95.32974243164061", "29.723837146389066,-95.32974243164061" ]

# Properties

# instantiate a new api client
api = SimplyRetsClient::DefaultApi.new

# call GET /properties
listings = api.properties_get({:minbeds => 2, :limit => 50, :type => ["Residential", "Rental"]})
listings.each do |l|
  p l.property.type
  p l.property
  p l.property.bedrooms
  p l.office.brokerid
end

# Single Listing

# call GET /properties/{mlsId}
prop = api.properties_mls_id_get(1005221)
p prop
p prop.geo.lat
