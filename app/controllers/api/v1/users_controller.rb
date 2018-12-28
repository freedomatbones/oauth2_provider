class Api::V1::UsersController < Api::V1::ApiController
  before_action :doorkeeper_authorize!
  respond_to :json
end
