class ApplicationController < ActionController::API

  def render_model(head, data, serializer = nil, status = 200)
    render json: data, each_serializer: serializer, root: head, adapter: :json,  status: status
  end

  def current_user
    
  end

end
