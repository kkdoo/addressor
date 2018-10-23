REDIS_DB_NAME = ['addressor', Rails.env].join('-')
#TODO: use ConnectionPool
$redis = Redis.new(db: REDIS_DB_NAME)
