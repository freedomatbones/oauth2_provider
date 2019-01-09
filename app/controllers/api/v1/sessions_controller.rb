class Api::V1::SessionsController < Devise::SessionsController
  protect_from_forgery :except => [:destroy]
  respond_to :json

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    if signed_out
      render :json => {success: true}
    else
      render :json => {success: false}
    end
  end
end
