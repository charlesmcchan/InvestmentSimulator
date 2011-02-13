# encoding: utf-8
require 'rubygems'
require 'mechanize'

module TSE

	# Get quote code list of SKI
	def self.quote_list
    m = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

   stocks = ['nana']
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

    stocks
  end

  # Get price quote for specific TSE stock ID
  def self.quote(stock_id)
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
  end
	
end
