Rails.application.routes.draw do

  # the order in the routes.rb file is important, it's basically first come
  # first served which means the first URL that matches your request will be the
  # one that will get used.

  get('/contact', { to: 'welcome#contact' })

  post('/contact_submit', { to: 'welcome#submit' })

  # in the line below ð we're defining a route that says: when we receive a GET
  # (http) requests with URL (from HTTP as well) that is `/` then handle that
  # request in the `WelcomeController` using the `index` action
  # the `as` option will define a route helper method that can be used in the
  # view files to auto-generate the URL portion of the route defined here.
  # you will have two methods generated: home_path and home_url. The method with
  # _path will generate a relative path (no domain name) and the mehtod with
  # _url will generate an absolute path (with domain name)
  get '/', to: 'welcome#index', as: 'home'

  # get('/', { to: 'welcome#index' })

  # DSL: Domain Specific Language. It's basically how the classes, methods and
  # blocks are defined in Ruby for a speicifc purpose (in this case defining
  # routes)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
