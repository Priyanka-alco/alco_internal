class ErrorsController < ApplicationController

  def error_show
    mime =[:jpg,:jpeg,:png,:gif,:webp]
    @exception = request.env["action_dispatch.exception"]
    if mime.include?(request.format.symbol)
      return render json: {status: request.path[1..-1] , error: @exception.message}
    else
      respond_to do |format|
        format.html { render action: request.path[1..-1],status: request.path[1..-1],layout: "errors"}
        format.json { render json: {status: request.path[1..-1] , error: @exception.message} }
      end
    end
  end

end
