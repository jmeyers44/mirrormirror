class Worker
  include Sidekiq::Worker
  def perform(params, current_user_id)
    ParseLibrary.new().add_library_to_db(params, current_user_id)
  end
end