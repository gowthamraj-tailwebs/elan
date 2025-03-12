module ApplicationHelper
	# Friday, 1 April 2022
	def formatted_date1 datetime
		if datetime
            datetime.strftime("%A, %e %B %Y")
		end
	end

	# Nov 03, 2023
	def formatted_date2 datetime
		if datetime.present?
            return datetime.strftime("%b %d, %Y")
		else
			return nil
		end
	end

	def formatted_title_dynamic data, max_length = 10
		if data.present?
			if data.size >= max_length
				return data[0, max_length] + "..."
			else
				return data
			end
		else
			return data
		end
	end
end
