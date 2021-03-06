class ExercisesController < ApplicationController
  before_action :logged_in_user,  only: [:new, :calendar]

  def new
    last_exercise = Exercise.last_exercise(current_user)

    if (Time.current - last_exercise >= 3600)
      current_user.exercises.create(exercise_params)
      flash[:success] = "Exercise Logged"
      redirect_to calendar_path
    else
      flash[:danger] = "You may only log one exercise per hour"
      redirect_to calendar_path
    end
  end

  def calendar
    @exercises = Exercise.select(:exercise_time, :user_id)
      .group("Date(exercise_time)")
      .group(:exercise_time, :user_id, :created_at)    
  end

  private

  def exercise_params
    params.permit(:exercise_time, :user_id)
  end

end
