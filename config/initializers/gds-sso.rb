GDS::SSO.config do |config|
  config.user_model   = "User"
  config.oauth_id     = ENV['CONTENT_PLANNER_OAUTH_ID'] || "dd6543edfgy654esdf564"
  config.oauth_secret = ENV['CONTENT_PLANNER_OAUTH_SECRET'] || "hgfre5678iujhgf"
  config.oauth_root_url = Plek.current.find("signon")
end
