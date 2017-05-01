class ReposController < ApplicationController
  def new
    @repo = Repo.new
  end

  def create
    @repo = Repo.new(repo_params)

    if @repo.save
      Webhook.new(@repo)
      redirect_to :index
    else
      render :new
    end
  end

  def edit
    @repo = Repo.find(params[:id])
  end

  def update
    if @repo.update(repo_params)
      redirect_to :index
    else
      render :edit
    end
  end

  def show
    @repo = Repo.find(params[:id])
  end

  def index
    @repos = Repo.where(user: current_user)
  end

  def assign
    repo = Repo.find(params[:id])
    Assign.new(repo).call
    redirect_to :back
  end

  private

  def index_url
    repos_path
  end

  def repo_params
    params.require(:repo).permit(:token, :name, :author).merge(user_id: current_user.id)
  end
end
