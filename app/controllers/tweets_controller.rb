class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, except: [:index, :show, :like]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
    session[:id] = true
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        if session[:id]
          session[:id] = false
          format.html { redirect_to tweet_path(@tweet), notice: 'Tweet was successfully created.' }
        else
          format.html { redirect_back fallback_location: root_path, notice: 'Tweet was successfully created.' }
        end
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @tweet.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  def unlike
    @tweet.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  def profile
    @user = User.find_by(username: params[:id])
    @followings = Following.where(user_id: current_user.id).pluck('following')
    @tweets = @user.tweets.order("created_at DESC")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet)
    end
end
