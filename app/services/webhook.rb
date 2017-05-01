class Webhook
  def initialize(repo)
    @repo = repo
  end

  def call
    client.create_hook(@repo.full_name, hook_name, config, options)
  end

  def url_options
    {host: "localhost", port: 3000, protocol: :https}
  end

  def options
    {
      :events => ['pull_request'],
      :active => true
    }
  end

  def hook_name
    'web'
  end

  def config
    {
      :url => Rails.application.routes.url_helpers.assign_repo_url(@repo, url_options),
      :content_type => 'json'
    }
  end

  def client
    @client ||= Octokit::Client.new(access_token: @repo.token)
  end
end
