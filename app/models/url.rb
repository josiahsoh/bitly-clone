class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :short_url, uniqueness: true 
	validates :long_url, presence: true
	validates :long_url, format: { with: /(http(s?):\/\/)(.*)/ }

	before_create :shorten
	
	def shorten
		self.short_url = Array.new(6){[*'0'..'9', *'A'..'Z', *'a'..'z'].sample}.join
	end

end
