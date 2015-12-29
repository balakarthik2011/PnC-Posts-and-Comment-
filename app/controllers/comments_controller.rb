class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:rate,:rating]
  # GET /comments
  # GET /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comment = @post.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new

  end

  # GET /comments/1/edit
  def edit
	@comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
  	@comment = @post.comments.build(comment_params)
    @comment.update(:name => current_user.email)
    @comment.update(:user_id => current_user.id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_url(@post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js # render comments/create.js.erb
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def rate
    @comment=Comment.find(params[:id])
  end

  def rating
    @comment=Comment.find(params[:id])
    ucr=UserCommentRating.new(:rating => params[:rate_comment])
    ucr.save
    @comment.user_comment_ratings<<ucr
    current_user.user_comment_ratings<<ucr
    respond_to do |format|
      format.html {redirect_to rate_path(@comment)}
    end
  end
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
	@comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_url(@comment.post_id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
	@comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_url(@comment.post_id), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :comment, :post,:user_id,:rate_comment)
    end
end
