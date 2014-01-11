class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    begin
      @user = User.authenticate(params[:username], params[:password])
      session[:user] = @user
      if logged_in?
        logger.info("Valid Login:" +
                    "\n   Username=>'#{params[:username]}'")
        redirect_back_or_default(root_path)
      else
        logger.info("Failed Login:" +
                    "\n   Username=>'#{params[:username]}'" +
                    "\n   Password=>'#{params[:password]}'")
        flash[:error] = "Login Error"
        redirect_to :action=> :new
      end
    rescue RuntimeError=> e
      flash[:error] = "Login Error: " + e.to_s
      redirect_to :action=> :new
    end
  end
  
  def logout
    @current_user = nil
    cookies.delete :auth_token
    reset_session
    flash[:success] = "Logout Successful"
    redirect_to :action=> :new
  end
end