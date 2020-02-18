class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  # GET /posts/new
  def new
    if params[:back]
      @post = current_user.posts.build(post_params)
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
    unless current_user.id == @post.user_id
      flash[:notice] = "他のユーザーの投稿は編集できません"
      redirect_to posts_path and return
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      PostMailer.post_mail(@post).deliver
      redirect_to posts_path
    else
      render :new
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
    unless current_user.id == @post.user_id
      flash[:notice] = "他のユーザーの投稿は編集できません"
      redirect_to posts_path and return
    end
    if @post.destroy
      redirect_to posts_path, notice: "投稿の削除が完了しました"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :image, :image_cache, :user_id)
    end
end
