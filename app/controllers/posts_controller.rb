class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def new
        @new_post = Post.new
    end

    def create
        @new_post = Post.new params.require(:post).permit(:title, :body)
        if @new_post.save
            flash[:notice]
            redirect_to posts_path
        else
            render new_post_path
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update params.require(:post).permit(:title, :body)
            redirect_to post_path(@post)
        else
            render edit_post_path
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
end
