JSON

Awesome answers project example

//add this in questions_controller as part of def index:

```ruby
    respond_to do |format|
      format.html { render }
      format.json { render jsonL: @questions }
    end
```

```ruby
def index
  if params.has_key? :user_id
    @user = User.find(params[:user_id])
    @questions = @user.liked_questions.order(created_at: :desc)
  else
    @questions = Question.recent(30)
  end

  # respond_to enables us to send different responses depending
  # on the format of the request
  respond_to do |format|
    # `html` is the default form. In this case, render will just show
    # the page `index.html.erb`
    format.html { render }
    # with every ActiveRecord object (models), there are to_json and a as_json
    # methods that returns JSON object with every single attribute from
    # the model. This is what `render json: @questions` will show for every question.
    format.json { render json: @questions }
    format.xml { render xml: @questions }
  end
end
```

//Create a versioned questions controller

```bash

rails g controller api::v1::questions
```

controllers/api/v1/questions_controller.rb

```ruby
class Api::V1::QuestionsController < ApplicationController
  def index
    questions = Question.all

    #render json: questions
  end
end
```

check in chrome:
```
localhost:3000/api/v1/questions_controller.rb
```


api/v1/questions_controller.rb

```
class Api::V1::QuestionsController < ApplicationController
  before_action :find_question, only: [:show]
  def show
    render json: @question
  end

  def index
    @questions = Question.all
    # by default, rails will to look for an instance variable named
    # after controller and it will render (in this case as json)
    render json: @questions
  end

  def create
    question = Question.new(question_params)
    if question.save
      render json: { id: question.id }
    else
      render json: { errors: question.errors.full_messages }
    end
  end

  private
  def question_params
    param.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
```

//check in chrome

http://localhost:3000/api/v1/questions/10

![screenshot 2017-06-20 13 54 04](https://user-images.githubusercontent.com/19618674/27356051-f633ca60-55c1-11e7-8e22-19adff7c9c3c.png)
![screenshot 2017-06-20 14 07 46](https://user-images.githubusercontent.com/19618674/27356056-f8e93164-55c1-11e7-9ce3-eb39b2b4a870.png)

curl tool:
tool to get request; like fetch to render json



```
$curl
curl: try 'curl --help' or 'curl --manual' for more information

$curl http://localhost:3000/api/v1/questions
```

curl -v POST -F '' http://localhost:3000/api/v1/questions

curl -v POST -d '' http://localhost:3000/api/v1/questions

curl -X POST -d 'question[title]=This is my title' -d 'question[body]=This' -d 'question[view_count]=2' http://localhost:3000/api/v1/questions/




//Fetch: another way to test your api
fetch('/api/v1/questions').then(res => res.json()).then(console.table)



//Faraday Gem:

~ $mkdir faraday_client
~ $cd faraday_client
faraday_client $gem install faraday
Successfully installed faraday-0.12.1
Parsing documentation for faraday-0.12.1
Installing ri documentation for faraday-0.12.1
Done installing documentation for faraday after 1 seconds
1 gem installed
faraday_client $atom client.rb
faraday_client $


views/

index.json.builder



//serializer



//rails g migration add_api_key_to_users api_key


class AddApiKeyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :api_key, :string
    add_index :users, :api_key
  end
end


//then rails db:migrate

SecureRandom.hex
"3e3edb90ab198c26013d3404978b5f5b"

hex:
0-f







github-awesome-answers $rails g controller api::application
Running via Spring preloader in process 7917
Expected string default value for '--serializer'; got true (boolean)
      create  app/controllers/api/application_controller.rb
      invoke  erb
      create    app/views/api/application
      invoke  rspec
      create    spec/controllers/api/application_controller_spec.rb
      invoke  helper
      create    app/helpers/api/application_helper.rb
      invoke    rspec
      create      spec/helpers/api/application_helper_spec.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/api/application.coffee
      invoke    scss
      create      app/assets/stylesheets/api/application.scss

//then edit application_controller under api folder

class Api::ApplicationController < ApplicationController
  # this will not throw an exception if an authenticity token is not
  # passed. In other words, this will allow post requests to be made
  # from tools other than a form rendered by rails
  skip_before_action :verify_authenticity_token
  def current_user
    @user = User.find_by(api_key: params[:api_key])
  end
end












---------------------

Here's today's mirror of code: http://codemirror.io/bob

stevego
[1:20 PM]
https://github.com/CodeCoreYVR/awesome_answers_apr_2017

stevego
[2:27 PM]
```curl -X POST -d 'question[title]=This is my title' -d 'question[body]=This' -d 'question[view_count]=2' http://localhost:3000/api/v1/questions/
```

stevego
[2:37 PM]
```fetch('/api/v1/questions').then(res => res.json()).then(console.table)
```

stevego
[2:48 PM]
```require 'faraday'

BASE_URL = 'http://localhost:3000/api/v1'
response = Faraday.get "#{BASE_URL}/questions/308"

puts response.body

response = Faraday.post "#{BASE_URL}/questions", {
  question: {
    title: "What is going on?",
    body: "Writing things in the body",
    view_count: 2
  }
}

puts response
```

stevego [3:17 PM]
```https://github.com/rails-api/active_model_serializers/tree/v0.10.6
```

new messages
stevego
[3:52 PM]
```❯ rails g controller api::application```























#
