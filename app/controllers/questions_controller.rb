class QuestionsController < ApplicationController
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
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new question_params
    if @question.save
      # redirect_to question_path({ id: @question.id })
      # redirect_to question_path({ id: @question })
      redirect_to question_path(@question)
    else
      # this will render the `app/views/questions/new.html.erb` to show the form
      # again (with errors). The default behaviour is to render `create.html.erb`
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
  end

  def index
    @questions = Question.recent(30)
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    question_params = params.require(:question).permit([:title, :body])
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    q = Question.find params[:id]
    q.destroy
    redirect_to questions_path
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
