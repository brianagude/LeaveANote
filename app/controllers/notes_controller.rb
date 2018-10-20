class NotesController < ApplicationController

  def index
    @note = Note.new
    # @featured_notes = Note.where(is_featured: true)
  end


  def all
    @notes = Note.all
  end


  def random
    @note = Note.order('RANDOM()').first
  end


  def create
    @note = Note.new(form_params)
      if session[:notes].present? and @note.save
        session[:notes].push(@note.id)
        redirect_to root_path
        flash[:success] = 'Your note has been submitted!'
      else
        session[:notes] = [@note.id]
        render "index"
        # flash[:error] = 'Your note must be between 3 and 150 characters!'
      end

  end


  def edit
    @note = Note.find(params[:id])

    # if @note.created_at < 5.minutes.ago
    #   redirect_to note_path(@note)
    # end
    flash[:success] = 'Your note has been submitted!'
  end


  def show
    @note = Note.find(params[:id])
    if session[:notes].present?
      session[:notes].push(@note.id)
    else
      session[:notes] = [@note.id]
    end

  end


  def update
    @note = Note.find(params[:id])


    # if @note.created_at < 5.minutes.ago
    #   redirect_to root_path
    # else
      if @note.update(form_params)
        redirect_to note_path(@note)
      else
        render "edit"
      end
    # end
  end


  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to random_path
    flash[:success] = 'Your note has been deleted!'
  end


  def form_params
    params.require(:note).permit(:body)
  end

end
