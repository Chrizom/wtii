class WtiisController < ApplicationController
	def index
		
	end
	
	def spelltime
		@words = {0=>"midnight", 1=>"one", 2=>"two", 3=>"three",
			  4=>"four", 5=>"five",6=>"six", 7=>"seven", 8=>"eight",
			  9=>"nine",10=>"ten",11=>"eleven",12=>"twelve",
			  13=>"thirteen",14=>"fourteen",15=>"quarter",16=>"sixteen",
			  17=>"seventeen",18=>"eighteen",19=>"nineteen",
			  20=>"twenty",30=>"thirty", 40=>"fourty",
			  50=>"fifty"}
		
		@hour = params[:hour]
		@minute = params[:minute]		
		
#		@hourliteral = self.getAsLiteral(@hour.to_i) ee
#		@minuteliteral = self.getAsLiteral(@decimal + self.getAsLiteral(@minute.to_i - @decimal)
		
		@spelledtime = self.spellIt(@hour.to_i, @minute.to_i)
		
	end
	
	protected
	
	def conv24To12(hour)
		if hour > 12
			case hour
				when 13 : @h = 1
				when 14 : @h = 2
				when 15 : @h = 3
				when 16 : @h = 4
				when 17 : @h = 5
				when 18 : @h = 6
				when 19 : @h = 7
				when 20 : @h = 8
				when 21 : @h = 9
				when 22 : @h = 10
				when 23 : @h = 11
				when 24 : @h = 12
			end
		else
			@h = hour
		end

		return @h
	end
	
	def getDay(hour)
			
		if ((hour >= 5) and (hour <= 11))
			return "in the morning" 
		end
		if ((hour >= 12) and (hour <= 17)) 
			return "in the afternoon" 
		end
		if ((hour >= 18) and (hour <= 21))
			return "in the evening" 
		end
		if ((hour >= 22) or (hour <= 5)) 
			return "at night" 
		end
		
		return ""
	end
	
	def spellIt(hour, min)
		@conjuction = ""
		@h = ""
		@m = ""
		
		if min < 31
			@conjuction = " past "
			@h = self.getAsLiteral(self.conv24To12(hour))
		else
			@conjuction = " to "
			@h = self.getAsLiteral(self.conv24To12(hour+1))
			min = 60 - min
		end		
					
		if min > 19
			if min == 30
				@m = "half"
			else		
				@decimal = (min / 10 )*10
				@m = self.getAsLiteral(@decimal) + "-" + self.getAsLiteral(min - @decimal)
			end						
		else
			@m = self.getAsLiteral(min)
		end
		
		return @m + @conjuction + @h + " o'clock ( " +self.getDay(hour)+" )"
	
	end
	
	def getAsLiteral(number)
		return @words[number]
	end
		
end		