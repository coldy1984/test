class Assign
  def initialize(repo)
    @repo = repo
  end

  def call
    set_assignee last_pr, random_contributor
  end

  # private

  def client
    @client ||= Octokit::Client.new(access_token: @repo.token)
  end

  def random_contributor
    available_users.sample
  end

  def available_users
    client.repository_assignees(@repo.full_name)
  end

  def last_pr
    open_prs.last
  end

  def open_prs
    client.pull_requests(@repo.full_name, :state => 'open')
  end

  def set_assignee(pr, assignee)
    client.update_issue(@repo.full_name, pr.number, {assignee: assignee.login})
  end
end
