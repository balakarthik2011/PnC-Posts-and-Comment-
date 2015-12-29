class PostsController < ApplicationController



  before_action :set_post, only: [:show, :edit, :update, :destroy,:update_post]

  load_and_authorize_resource :except => [:user,:rating,:date_filter]

  skip_before_action :authenticate_user! ,only: [:user]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice =>" Hey "+ exception.message
  end


  # GET /posts
  # GET /posts.json
  def index

    if  params[:from_date].present?
     from=params[:from_date]
     to=params[:to_date]

    else
      from =Date.yesterday
      to =Date.today
    end
	if (params[:topic_id]).present?
    @topic = Topic.find(params[:topic_id])
	  @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    @tags = Tag.all
    @post = @topic.posts.new
	else
	  #@posts = Post.eager_load(:topic,:user).paginate(page: params[:page], per_page: 10)
    @posts=Post.t(from).f(to).eager_load(:topic,:user).paginate(page: params[:page], per_page: 10)

  end
  end

  def user
    authenticate_or_request_with_http_basic do |username, password|
      @person = User.find_by_email(username)
      if @person.valid_password?(password)
        render json: @person
      else
        render json:{error: "access denied"}
      end
    end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments

  end

  def update_post
      @post.users<<(current_user)
  end

  # GET /posts/new
  def new
      @topic = Topic.find(params[:topic_id])
      @tags=Tag.all
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @tags=Tag.all
  end

  # POST /posts
  # POST /posts.json
  def create

	  @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.new(post_params)
    @posts.update(:user_id => current_user.id)


    respond_to do |format|

        format.html { redirect_to topic_posts_path(@topic) }
        format.json { render :show, status: :created, location: @posts }
        format.js

    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_posts_path(@post.topic), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def rating
   puts "hello"
    @post=Post.find(params[:id])
    @post.ratings.create(:star =>params[:rate])
   puts "hiiii"
    respond_to do |format|
    format.html { redirect_to post_path(@post), notice: 'Thanks for your rating...!' }
      end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image,:name, :email, :message, :topic_id, { tag_ids:[] }, :rate,:user_id,:from_date,:to_date)
    end

end
