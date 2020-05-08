class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question_title = Redcarpet::Markdown.new(Redcarpet::Render::HTML, filter_html: true).render(@question.title)
    @question_body = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@question.description)

    @answer = Answer.new
    @answers = @question.answers
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(new_question_params)

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(new_question_params)
      redirect_to @question, notice: "Question was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    @answers = @question.answers
    @answers.destroy_all
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def new_question_params
    params.require(:question).permit(:title, :description)
  end
end
