# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # GET /users/home
  def home
    # Just redirect the user to the home url
    redirect_to home_page_url
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  # POST /users/create
  # POST /users/create.json
  def create
    params[:user][:role] ='user'
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        # Associate the temporary board to the new user
        if session["temporary_board_id"]
          @board = get_temporary_boards.first # Defined in SessionHelper
          #params = session["temporary_board"][:board]
          #params[:user_id] = @user.id
          #@board = Board.new params
          @board.user_id = @user.id
          @board.save
          session["temporary_board_id"] = nil
        end
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to request.referer, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # GET /users/account
  def profile
    render json: current_user
  end

  # POST /users/send-store-invitation
  def send_store_invitation
     
    respond_to do |format|
      if UsersMailer::send_store_invitation(current_user, params[:email].to_s)
        format.json { render :json => {:email => "Mail envoyé avec succès"} }
      else
        format.json { render :json => {:email => "Erreur lors de l'envoi du mail"}, :status => 422}
      end
    end
  end
  
  # POST /users/recommend
  def recommend
    UsersMailer::recommend(current_user, params)
    respond_to do |format|
      format.json { render :json => {:email => "Recommendation envoyée !"}}
    end
  end


  # GET /users/wordpress
  #This action for connect for wordpress.com
  def wordpress
    wpc = WordpressCom.new(WORDPRESS_OAUTH_KEY, WORDPRESS_OAUTH_SECRET)
    redirect_uri = "#{BASE_URL2}users/wordpress_callback"
    url = wpc.authorize_url(redirect_uri)
    redirect_to url
  end

  #GET /users/wordpress_callback
  #This action for callback for wordpress action. here we store wordpress authentication.
  def wordpress_callback
    if params[:code].present?
      wpc = WordpressCom.new(WORDPRESS_OAUTH_KEY, WORDPRESS_OAUTH_SECRET)
      redirect_uri = "#{BASE_URL2}users/wordpress_callback"
      wpc.get_token(params[:code], redirect_uri)
      wordpress_auth = wpc.serialize
      user_connect = Connection.where(:user_id => current_user.id, :provider => "wordpress").first
      if user_connect.present?
        user_connect.update_attributes({
            :uid => wordpress_auth[0],
            :token => wordpress_auth[2][:access_token],
            :secret => wordpress_auth[1],
            :token_type => wordpress_auth[2]["token_type"],
            :blog_id => wordpress_auth[2]["blog_id"],
            :blog_url => wordpress_auth[2]["blog_url"],
            :scope => wordpress_auth[2]["scope"]
          })
      else
        user_connect = Connection.new(
          :provider   => "wordpress",
          :uid => wordpress_auth[0],
          :token => wordpress_auth[2][:access_token],
          :secret => wordpress_auth[1],
          :token_type => wordpress_auth[2]["token_type"],
          :blog_id => wordpress_auth[2]["blog_id"],
          :blog_url => wordpress_auth[2]["blog_url"],
          :scope => wordpress_auth[2]["scope"],
          :user_id => current_user.id
        )
        user_connect.save(:validate => false)
      end
      redirect_to edit_user_registration_path
    else
      redirect_to root_path
    end
  end

  def blogger
    
  end

  def  blogger_callback
    if (params[:blogger_user_id].present? and params[:blogger_user_name].present? and params[:blogger_user_password].present?)
      user_connect = Connection.where(:user_id => current_user.id, :provider => "blogger").first
      if user_connect.present?
        user_connect.update_attributes({
            :blogger_user_id => params[:blogger_user_id],
            :blogger_user_name => params[:blogger_user_name],
            :blogger_user_password => params[:blogger_user_password]
          })
      else
        user_connect = Connection.new(
          :provider   => "blogger",
          :user_id => current_user.id,
          :blogger_user_id => params[:blogger_user_id],
          :blogger_user_name => params[:blogger_user_name],
          :blogger_user_password => params[:blogger_user_password]
        )
        user_connect.save(:validate => false)
      end
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Please provide blogger user id, blogger user name and blogger user password"
      render :action => "blogger"
    end
  end

end
