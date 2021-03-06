# Facebook config
exports.facebook =
	appId: null # appID is number
	secretKey: null #secretKey is string

# Meetup config
exports.meetup = null # API key as string

#Eventbrite config
exports.eventbrite =
	appKey: null

exports.elasticsearch =
	host: 'localhost:9200'
	log: 'error'
	apiVersion: '1.5'

exports.geo =
	center: # Insert lat and lon coordinates for your area of interest
		lat: 0.0
		lon: 0.0
	maxDistKilometers: 100 # Use something you feel is sensible
