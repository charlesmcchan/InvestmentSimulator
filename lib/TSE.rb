# encoding: utf-8
require 'rubygems'
require 'nokogiri'
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
	
end
