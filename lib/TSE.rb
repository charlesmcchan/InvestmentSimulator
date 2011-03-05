# encoding: utf-8
require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'csv'

module TSE

	# Get quote code list of SKI
	def self.quote_list
    m = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    stocks = []
    # 上市股票
    m.get('http://mops.twse.com.tw/mops/web/t51sb01') do |page|
      stocks_page = page.form_with(:name => 'form1') do |form|
        form.TYPEK = 'sii'
        form.code = ''
      end.submit

      stocks = (stocks_page / 'table tr.even, table tr.odd').map do |tr|
        tds = tr / 'td'
        # gsub is used to remove strange space (code: 160) from td
        [tds[0], tds[1]].map(&:text).map { |t| t.gsub(" ", "") }
      end
    end

    # ETF
    src = open('http://mis.twse.com.tw/data/TCB0.csv').read
    sids = CSV.parse(src).flatten
    stocks.concat(sids.map do |sid|
      src = open("http://mis.twse.com.tw/data/#{sid}.csv").read
      arr = CSV.parse(src.encode('UTF-8', :replace => '')).flatten
      arr[-1] = "恒中國" if sid == "0080"
      arr[-1] = "恒香港" if sid == "0081"
      [sid, arr[-1]]
    end)

    stocks
  end

  # Get price quote for specific TSE stock ID
  def self.quote(stock_id)
# Google Finance parsing
=begin
    m = Mechanize.new
    src = m.get("http://finance.google.com/finance/info?client=ig&q=TPE:#{stock_id}").body
    data = JSON.parse(src[3..-1])[0]
    {
      :quote_id => data["t"],
      :price => data["l"],
      :currency => "NTD",
      :time => DateTime.parse(data["lt"]),
      :quote_type => "TSE"
    }
=end
    src = open("http://mis.twse.com.tw/data/#{stock_id}.csv").read
    data = CSV.parse(src.encode('UTF-8', :replace => '')).flatten
    {
      :quote_id => stock_id,
      :price => data[8].to_f,
      :currency => "NTD",
      :time => DateTime.parse(data[2]),
      :quote_type => "TSE"
    }
  end
	
end
