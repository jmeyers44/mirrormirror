class Worker
  include Sidekiq::Worker
  def perform(current_user_id)
    ParseLibrary.new().add_library_to_db(current_user_id)
  end
end