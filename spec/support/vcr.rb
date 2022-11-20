VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into(:webmock)
  config.configure_rspec_metadata!
  config.default_cassette_options = {allow_playback_repeats: true, match_requests_on: [:body]}
end
