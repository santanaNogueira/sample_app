module ClientsHelper

#returns the gravatar for the given client
def gravatar_for(client, options = { size: 50})
	gravatar_id = Digest::MD5::hexdigest(client.email.downcase)
	size = options[:size]
	gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	image_tag(gravatar_url, alt: client.name, class: "gravatar")
end

end
