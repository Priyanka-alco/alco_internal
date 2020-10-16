class AuthenticationController < ApplicationController
  # skip_before_action :authenticate_request
  # before_action :authenticate_user!
  def authenticate
    check_user = User.where("email='#{params['email']}'")
    @res = {}
    # debugger
    if check_user[0]
      if check_user[0].password_digest == params['password']
        @res['success'] = true


        case check_user[0].category
          when 1
            page = "/search_customer"
          when 2
            page = "/all_orders"
        when 3
          page = "/pending_order"
          else
            page = "/search_customer"
        end
        @res['page'] =  "#{page}?status=200"
        session[:current_user_id] = check_user[0].id
        session[:category] = check_user[0].category
        session[:email] = params['email']
        session[:admin] = true if  params['email'] == "admin@gmail.com"
        session[:name] = "#{check_user[0].first_name} #{check_user[0].last_name}"
        session[:email_id] = check_user[0].email
        # puts "**************session***#{session[:current_user_id]}"
        @res['message'] = "Loggedin Successfully"
      else
        @res['success'] = false
        @res['page'] = '/caller_login?status=400'
        @res['message'] = "Please enter correct password"
      end
      @res['status'] = 200
    else
      @res['success'] = false
      @res['page'] =  "/caller_login?status=300"
      @res['message'] = "Please enter correct email id"
      @res['status'] = 400
    end
    redirect_to @res['page']
  end

  def logout
    reset_session
    redirect_to '/caller_login'
  end
end