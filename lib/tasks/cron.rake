require 'TSE'

desc "Cron job"
task :cron => :environment do
  puts "Update TSE stocks list"
  TSE.quote_list.each do |qd|
    quote = Quote.find(:first, :conditions => ['quote_id = ? AND quote_type = ?', qd[0], 'TSE']) || Quote.new
    quote.quote_id, quote.name, quote.quote_type = [qd[0], qd[1], 'TSE']
    quote.save

    begin
      puts "Fetching price for #{qd[0]}.TW"
      price_info = TSE.quote(qd[0])
      qh = QuoteHistory.find(:first, :conditions => ['quote_id = ? AND created_at = ?', quote.id, price_info[:time]]) || QuoteHistory.new 
      qh.price, qh.currency = price_info[:price], price_info[:currency]
      qh.quote = quote
      qh.created_at = price_info[:time]
      qh.save
      puts "  #{price_info[:currency]} #{price_info[:price]} #{price_info[:time].strftime("%Y/%m/%d %H:%M:%S")}"
    rescue
      puts "  Can't get data for #{qd[0]}.TW, delayed to next fetch"
    end
  end
end
