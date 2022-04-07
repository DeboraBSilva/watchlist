require 'rufus-scheduler'

return if defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'

scheduler = Rufus::Scheduler.singleton

scheduler.every  '5m' do
  puts 'scheduler rodou'
  UpdateQuotes.call
end

# scheduler.join
