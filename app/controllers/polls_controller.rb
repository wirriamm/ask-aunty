class PollsController < ApplicationController
  #user is at picture page, route meals#setup
  def create
    @poll = Poll.new(params.require(:poll).permit(:score, :meal, :cuisine))
    @poll.user = current_user
    raise
    #current implementation assume whole poll is on one page
    if @poll.save
      redirect_to result_path
    else
      redirect_to setup_path(@poll.meal)
    end
  end
end
