require 'TSE'

desc "Cron job"
task :cron => :environment do
  TSE.quote_list.each do |qd|
    quote = Quote.find(:first, :conditions => ['quote_id = ? AND quote_type = ?', qd[0], 'TSE']);
    quote = Quote.new if !quote
    quote.quote_id, quote.name, quote.quote_type = [qd[0], qd[1], 'TSE']
    quote.save
  end
end
