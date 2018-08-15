class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :categories, only: [:index, :show, :notice, :homework, :lecture]
  before_action :notice_widget, only: [:index]
  before_action :mainimg, only: [:index]
  before_action :authenticate_user!, except: [:index, :show, :notice, :homework, :lecture]
  before_action :log_impression, :only=> [:show]
  load_and_authorize_resource
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)
    # 카테고리 아래로 옮김
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    isMember = check_user
    puts isMember
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
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
    check_user
    @post.destroy #and return
    redirect_to '/'
    # respond_to do |format|
    #   format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end
  
  def notice
    @post = Post.where(:category => '공지사항')
    @posts = @post.order("created_at DESC").page(params[:page]).per(5)
  
    authorize! :notice, @posts
  end
  
  def list
    @posts = Post.all
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    @search = Post.search do
        fulltext params[:search]
        paginate :page => params[:page], :per_page => 10
    end
    #@posts = @search.results
    authorize! :list, @posts
  end
  
  
  
  def homework
    @post = Post.where(:category => '과제')
    @posts = @post.order("created_at DESC").page(params[:page]).per(5)
    authorize! :homework, @posts
  end
  
  def lecture
    @post = Post.where(:category => '수업자료')
    @posts = @post.order("created_at DESC").page(params[:page]).per(5)
    authorize! :lecture, @posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    def categories
      @categories_10 = Array.new # 배열을 하나 새로 만든다.
      count = 0 # 카운트 변수를 0으로 초기화 (10개를 추출할거니깐 숫자 증가시킴)
      categories = Post.all.order("created_at DESC") # 최신 포스트를 모두 가져온 다음
      categories.each do |x| # each로 하나씩
        if count == 5 # 만약 카운트가 10이면 우리가 원하는 최신 포스트 10개를 다 순회했으므로
          break; # each 메서드 종료
        end
      @categories_10.push(x) # 만약 10번 안돌았으면 새로 만ㄷ
      count += 1
      end
    end
    
    def notice_widget
      @notice_1 = Array.new # 배열을 하나 새로 만든다.
      notice_widget = Post.all.order("created_at DESC") # 최신 포스트를 모두 가져온 다음
      notice_widget.each do |x| # each로 하나씩 x로
        if x.category === "공지사항"
       # 만약 x의 카테고리가 "공지사항" 이고 
          @notice_1.push(x) # notice_1에서 x를 push하면
          break; # each 메서드 종료
        end
      end
    end
    
    def mainimg
      @mainimg_1 = Array.new # 배열을 하나 새로 만든다.
      mainimg = Post.all.order("created_at DESC") # 최신 포스트를 모두 가져온 다음
      mainimg.each do |m| # each로 하나씩 x로
        if m.category === "대문"
       # 만약 x의 카테고리가 "공지사항" 이고 
          @mainimg_1.push(m) # notice_1에서 x를 push하면
          break; # each 메서드 종료
        end
      end
    end
    
    def check_user
      if @post.user_id != current_user.id
        return false
      elsif current_user.has_role? 'member'
        return true  
      else 
        return false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :category, :limit)
    end
    
    def log_impression
      @hit_post = Post.find(params[:id])
      # this assumes you have a current_user method in your authentication system
      @hit_post.impressions.create(ip_address: request.remote_ip)
    end
    
    # 검색 메소드
    # def search
    #   @posts = Post.search do
    #     keywords params[:query]
    #   end.results
        
    #     respond_to do |format|
    #       format.html { render :action => "index" }
    #       format.xml  { render :xml => @posts }
    #     end
    
end
