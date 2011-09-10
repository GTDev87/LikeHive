
namespace :sunspot do
  desc "indexes searchable models"
  task :index => :environment do
    [Like].each {|model| Sunspot.index!(model.all)}
  end
end 