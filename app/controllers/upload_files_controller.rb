class UploadFilesController < ApplicationController
  def create
    upload_file_to_s3(params[:upload_file][:filename])
    redirect_to root_url
  end

  private
  def s3_bucket
    s3 = AwsResource.for(Aws::S3, region: Rails.application.secrets.s3_region)
    s3.bucket(Rails.application.secrets.s3_bucket)
  end

  def upload_file_to_s3(upload_file)
    attachment_info = {
      filename: upload_file.original_filename,
      filepath: "upload_files/#{upload_file.original_filename}",
      filesize: upload_file.size
    }
    decode_filedata = upload_file.read
    upload(attachment_info[:filepath], decode_filedata)
  end

  def upload(filepath, decode_filedata)
    obj = s3_bucket.object(filepath)
    file_data = {
      body: decode_filedata,
      server_side_encryption: 'AES256',
      expires: Time.zone.now.since(15.minute),
      content_type: 'application/octet-stream',
      acl: 'public-read'
    }
    obj.put(file_data)
  end
end
