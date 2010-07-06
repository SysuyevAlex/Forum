# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_forum_session',
  :secret      => 'd9dc0107aca1028436d9407d1ff83e124f56bb34ae73a4e656c835cc3332091e6a10447be4c9ed43ea74ca0044acaebfa6a47e35af94b6f01aa983915b2b4d70'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
