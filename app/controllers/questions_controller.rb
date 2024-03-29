class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_poll
  before_action :set_kind_questions
  before_action :admin!

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = @poll.questions.build
    5.times { @question.possible_answers.build }
  end

  def edit
  end

  def create
    @question = @poll.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @poll, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :kind, :poll_id, { possible_answers_attributes: [ :title, :question_id ]})
    end

    def set_kind_questions 
      @kind_options = [
        [ "Open Answer", "open" ], 
        [ "Multiple Choice", "choice" ], 
      ]
    end

    def set_poll
      @poll = Poll.find params[:poll_id]
    end

    def admin!
      authenticate_user!
      redirect_to root_path, alert: "You are not authorized to this operation." unless current_user.admin? 
      #user.admin == true
    end
end
