# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    # result = check_key
    # if result == true
     super
    # end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def configure_sign_up_params
      @user = devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :name, :phone])
    end
    
    def signkey
      @signkey = Signkeys.find(1).key
    end
    
    def user_key
      @user_key = devise_parameter_sanitizer.permit(:sign_up, keys: [:signkey])
    end
    
    def check_key
      if @user_key != @signkey
        render(
          html: "<script>alert('가입코드를 다시 한 번 확인해주세요!')</script>".html_safe,
          layout: 'devise/registrations/new'
        )
        return false
      end
      return true
    end
end
