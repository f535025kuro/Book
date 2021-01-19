class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  before_action :set_q, only: [:index, :result]
 
  def index
    @results = @q.result
    @posts = Post.all.order(created_at: :desc)
  end

  def result #検索結果画面のアクション
    @results = @q.result
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    new_browse = @post.browse_histories.new
    new_browse.user_id = @current_user.id
    new_browse.post_id = @post.id
    new_browse.post_title = @post.title
    new_browse.post_author = @post.author
    if @current_user.browse_histories.exists?(post_id: "#{params[:id]}")
       old_browse = @current_user.browse_histories.find_by(post_id: "#{params[:id]}")
       old_browse.destroy
    end

    new_browse.save

    browse_stock_limit = 5
    newerlist = @current_user.browse_histories.all
    if newerlist.count > browse_stock_limit
      newerlist[0].destroy
    end

  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      title: params[:title],
      author: params[:author],
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      new_regist = @post.regist_histories.new
      new_regist.user_id = @current_user.id
      new_regist.post_id = @post.id
      new_regist.post_title = @post.title
      new_regist.post_author = @post.author

      new_regist.save

      regist_stock_limit = 5
      newerregist = @current_user.regist_histories.all
      if newerregist.count > regist_stock_limit
        newerregist[0].destroy
      end
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.title = params[:title]
    @post.author = params[:author]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  
  def set_q
    @q = Post.ransack(params[:q])
  end

end
