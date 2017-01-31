class StaticPagesController < ApplicationController
  def index
    @upload_file = UploadFile.new
  end
end
