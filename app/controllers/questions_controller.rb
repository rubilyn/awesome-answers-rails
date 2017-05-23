class QuestionsController < ApplicationController
  # `before_action` takes it a block or a symbol that refers to a method. The
  # block or the method will be executed just before the action. This will
  # happen within the same request/response cycle which means that defined
  # instance variables are available in the actions and consequently in the
  # associated views.
  # you can pass `only` or `except` options to the `before_action` method to
  # restrict that actions that will have `before_action` called on.
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  # the New action is usuaully used to show a form that will be used to create
  # an object which is `question` in this case
  # URL: /question/new
  # VERB: GET
  def new
    @question = Question.new
  end

  # The create action is usually used to handle form submission from the new
  # action to create a record (question in this case) in the database.
  # URL: /questions
  # VERB: POST
  def create
    @question = Question.new question_params
    if @question.save
      # redirect_to question_path({ id: @question.id })
      # redirect_to question_path({ id: @question })

      # the flash message set here will be avaialble in the next
      # request/response cycle and will be deleted once used.
      flash[:notice] = 'Question created'
      redirect_to question_path(@question)
    else
      # if you want to show the flash message within the same request/response
      # cycle then you will need to use `flash.now` instead of `flash`
      flash.now[:alert] = 'Please fix errors below'

      # this will render the `app/views/questions/new.html.erb` to show the form
      # again (with errors). The default behaviour is to render `create.html.erb`
      render :new
    end
  end

  def show
  end

  def index
    @questions = Question.recent(30)
  end

  def edit
  end

  def update
    if @question.update(question_params)
      # if you have a `redirect_to` and you'd like to specify a flash message
      # then you can just pass in the `flash` or `alert` as options to the
      # `redirect_to` instead of having a separate line. Please note that this
      # does not work with `render`
      redirect_to question_path(@question), notice: 'Question updated'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question deleted'
  end

  private

  def question_params
    params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find params[:id]
  end

end

##################
# class QuestionsController < ApplicationController
#   # the New action is usuaully used to show a form that will be used to create
#   # an object which is `question` in this case
#   # URL: /question/new
#   # VERB: GET
#   def new
#     @question = Question.new
#   end
#   # The create action is usually used to handle form submission from the new
#   # action to create a record (question in this case) in the database.
#   # URL: /questions
#   # VERB: POST
#   def create
#     question_params = params.require(:question).permit([:title, :body])
#     @question = Question.new question_params
#     if @question.save
#       # redirect_to question_path({ id: @question.id })
#       # redirect_to question_path({ id: @question })
#       redirect_to question_path(@question)
#     else
#       # this will render the `app/views/questions/new.html.erb` to show the form
#       # again (with errors). The default behaviour is to render `create.html.erb`
#       render :new
#     end
#   end
#   def show
#     @question = Question.find params[:id]
#   end
#   def index
#     @questions = Question.recent(30)
#   end
#   def edit
#     @question = Question.find params[:id]
#   end
#   def update
#     @question = Question.find params[:id]
#     question_params = params.require(:question).permit([:title, :body])
#     if @question.update(question_params)
#       redirect_to question_path(@question)
#     else
#       render :edit
#     end
#   end
#   def destroy
#     q = Question.find params[:id]
#     q.destroy
#     redirect_to questions_path
#   end
# end
##################
# class QuestionsController < ApplicationController
#   # the New action is usuaully used to show a form that will be used to create
#   # an object which is `question` in this case
#   # URL: /question/new
#   # VERB: GET
#   def new
#     @question = Question.new
#   end
#
#   # The create action is usually used to handle form submission from the new
#   # action to create a record (question in this case) in the database.
#   # URL: /questions
#   # VERB: POST
#   def create
#     question_params = params.require(:question).permit([:title, :body])
#     @question = Question.new question_params
#     if @question.save
#       render :show
#     else
#       # this will render the `app/views/questions/new.html.erb` to show the form
#       # again (with errors). The default behaviour is to render `create.html.erb`
#       render :new
#     end
#   end
#
#   def show
#     @question = Question.find params[:id]
#   end
# end

##################
# class QuestionsController < ApplicationController
#   # the New action is usuaully used to show a form that will be used to create
#   # an object which is `question` in this case
#   # URL: /question/new
#   # VERB: GET
#   def new
#     @question = Question.new
#   end
#
#   # The create action is usually used to handle form submission from the new
#   # action to create a record (question in this case) in the database.
#   # URL: /questions
#   # VERB: POST
#   def create
#     question_params = params.require(:question).permit([:title, :body])
#     @question = Question.new question_params
#     if @question.save
#       render json: params
#     else
#       # this will render the `app/views/questions/new.html.erb` to show the form
#       # again (with errors). The default behaviour is to render `create.html.erb`
#       render :new
#     end
#   end
#
#   def show
#     render json: params
#   end
# end
#################
# def create
#   question_params = params.require(:question).permit([:title, :body])
#   q = Question.new question_params
#   q.save
#   render json: params
# end
