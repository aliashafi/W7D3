class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render new_user_goal(params[:user_id])
  end

  def index
    if params[:user_id]
      @goals = Goal.where(user_id: params[:user_id])
    else
      @goals = Goal.where(goal_type: 'public')
    end
  end

  def create
    @goal = Goal.new(goal_params, user_id: params[:user_id])
    if @goal.save
      redirect_to new_user_goal(params[:user_id])
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to new_user_goal(params[:user_id])
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :goal_type, :user_id)
  end
end
