module ApplicationHelper
#retorna o titulo completo por pagina
	def full_title(page_title)
		base_title = '1D'

		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		 end
	end
end
