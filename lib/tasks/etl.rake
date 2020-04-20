require 'aws-sdk-s3'

module ETL
  AWS_S3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'], access_key_id: ENV['AWS_KEY'], secret_access_key: ENV['AWS_SECRET'])
  S3_BUCKET = AWS_S3.bucket('ukt-source-data')
end

def download_from_source_s3(filename)
  ETL::S3_BUCKET.object(filename).get(response_target: "data/#{filename}")
end

task :etl => [
  'etl:source_orgs',
  'etl:af_venues'
]
