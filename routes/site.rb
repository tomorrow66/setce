['/index/?', '/?', '/home/?', '/index.html/?', '/home.html/?'].each do |path|
  get path do
    @categories = Category.all
    view 'index'
  end
end

get '/category/:id/?' do
  @categories = Category.all 
  @category = Category.first(url: params[:id])
  view 'category'
end

get '/category/:id/:sub/?' do 
  @categories = Category.all
  @cat = Category.first(url: params[:id])
  unless params[:sub] == 'employee-recognition' || params[:sub] == 'volunteer-opportunities'
    @sub = Subcategory.first(url: params[:sub])
  else
    @sub = Subcategory.first(url: params[:sub], category_id: @cat.id)
  end
  @path = 'sub'
  view 'subcategory'
end

get '/download/?' do
  file = 'public/img/logo.png'
  send_file file, disposition: 'attachment', filename: File.basename(file)
  redirect back
end

get '/download/*.*/?' do |path, ext|
  file = path.to_s
  file.gsub!(/download/,'')
  file = 'public/' + file + '.' + ext.to_s
  send_file file, disposition: 'attachment', filename: File.basename(file) 
  redirect back
end

get '/preview/:cat/:sub/:id/?' do
  @cat = params[:cat]
  @sub = params[:sub]
  @file = Asset.get(params[:id])
  view 'preview', layout: false
end

get '/test/?' do
  view 'test', layout: false
end