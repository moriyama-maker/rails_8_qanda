class QuestionsController < ApplicationController
  # 質問一覧表示
  def index
    @questions = Question.all
    # p @questions
  end

  # 質問の詳細ページ表示
  def show
    # p params[:id]
    @question = Question.find(params[:id])
    # p @question
  end

  # 質問の作成
  def new
    @question = Question.new
  end

  # 質問の登録
  def create
    # Questionモデルを初期化
    @question = Question.new(question_params)
    # QuestionモデルをDBへ保存
    if @question.save
      # 質問ページにリダイレクトする
      redirect_to @question
    else
      # 質問の作成ページを表示する
      render 'new', status: :unprocessable_entity
    end
  end

  # 質問の編集
  def edit
    @question = Question.find(params[:id])
  end

  # 質問の更新
  def update
    @question = Question.find(params[:id])

    # DBに登録できた場合
    if @question.update(question_params)
      # 質問詳細ページに遷移する
      redirect_to @question
    # DBに登録できなかった場合
    else
      # 編集ページを表示
      render 'edit', status: :unprocessable_entity
    end
  end

  # 質問の削除
  def destroy
    @question = Question.find(params[:id])
    # 質問の削除
    @question.destroy
    # TOPページに遷移する
    redirect_to questions_path
  end

  private
  def question_params
      params.require(:question).permit( :title, :name,  :content)
  end
end