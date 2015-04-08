class UserController < ApplicationController
  def signup
    user = User.new(username: params[:username],
                    password: params[:password])
    if not(user.valid?)
      return render json: {"error_code" => user.error_code}
    end

    user.login_count = 1
    user.save
    render json: {"user_name" => user.username,
                  "login_count" => user.login_count}
  end

  def login
    user = User.find_by(username: params[:username],
                        password: params[:password])
    if user.nil?
      return render json: {"error_code": -4}
    end

    user.increment! :login_count

    return render json: {"user_name" => user.username,
                         "login_count" => user.login_count}
  end
end
