class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])

    @question_title = Redcarpet::Markdown.new(Redcarpet::Render::HTML, filter_html: true).render(@question.title)
    @question_body = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@question.description)

    @answer = Answer.new(new_answer_params)
    @answer.question = @question

    @answers = @question.answers

    if @answer.save
      redirect_to question_path(@question), notice: 'Answer was successfully submitted.'
    else
      render template: '/questions/show'
    end
  end

  private

  def new_answer_params
    params.require(:answer).permit(:description)
  end
end
