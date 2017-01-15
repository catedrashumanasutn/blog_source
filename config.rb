require 'contentful_middleman'
require 'slim'

activate :livereload

activate :contentful do |f|
  f.space = {blog: 'ezsm20i7y53c'}
  f.access_token = '443ac1befea7084f32dc6049b44075e3c7a791d6c35f89e91dc07dc058ba87a4'
  f.all_entries = true
  f.content_types = {posts: 'post'}
  f.cda_query = {content_type: 'post', include: 2, order: '-fields.fechaDePublicacion'}
end

activate :contentful do |f|
  f.space = {navegacion: 'ezsm20i7y53c'}
  f.access_token = '443ac1befea7084f32dc6049b44075e3c7a791d6c35f89e91dc07dc058ba87a4'
  f.all_entries = true
  f.content_types = {paginas: 'pagina'}
  f.cda_query = {'include' => 2}
end

if data.key?('blog') && data.blog.key?('posts')
  data.blog.posts.each do |_, post|
    proxy "/posts/#{post.slug}.html", "/posts/post.html", locals: {post: post}, ignore: true
  end
end

if data.key?('navegacion') && data.navegacion.key?('paginas')
  data.navegacion.paginas.each do |_, pagina|
    proxy "/#{pagina.slug}.html", "/paginas/pagina.html", locals: {pagina: pagina}, ignore: true
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

configure :build do
end
