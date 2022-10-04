ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"



class ActiveSupport::TestCase
  fixtures :all
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def fill_in_trix_editor(id, with:)
    find(:xpath, "//trix-editor[@input='#{id}']").click.set(with)
  end
  
  def find_trix_editor(id)
    find(:xpath, "//*[@id='#{id}']", visible: false)
  end
end
