get '/' do
  @urls = Url.order(:id).all
  @urls.each_with_index do |url,index|
  	url.update_attributes(index_number: index+1)
  end
  erb :"static/index"
end

post '/urls' do	
	url = Url.create(long_url: params[:user_input_long_url])
	redirect "/"
end

get '/:browser_short_url' do
	url = Url.find_by(short_url: params[:browser_short_url])
	url.click_count += 1
	url.save
	unless url.nil?
		redirect url.long_url
	else
		redirect "/"
	end
end

get '/delete/:id' do
	id_num = params[:id]
	url = Url.find_by(index_number: id_num).delete
	redirect "/"
end