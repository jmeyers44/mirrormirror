class Worker
  include Sidekiq::Worker
  def perform(file, current_user_id)
    ParseLibrary.new().add_library_to_db(file, current_user_id)
  end
end