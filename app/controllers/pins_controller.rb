class PinsController < ApplicationController
before_action :find_pin, only: [:show, :edit, :update, :destroy, :like, :unlike]
before_action :authenticate_user!, except: [:index, :show]
before_action :authorize, only: [:edit, :destroy]

  def index
    @pins = Pin.all
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to pin_path(@pin), notice: 'Pin added succesfully.'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:pin][:picture]
      unless @pin.update_attribute(:picture, params[:pin][:picture])
        render 'edit', alert: "Couldn't upload a picture"
      end
    end

    if @pin.save
      redirect_to @pin, notice: 'Pin updated succesfully.'
    else
      render 'edit', alert: "Couldn't edit pin."
    end
  end

  def destroy
    if @pin.destroy
      redirect_to root_path, notice: 'Pin deleted uccesfully.'
    else
      redirect_to pin_path(@pin), alert: "Couldn't delete pin"
    end
  end

  def like
    @pin.liked_by current_user
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @pin.unliked_by current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :picture)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def authorize
    find_pin
    unless current_user && current_user == @pin.user
      redirect_back(fallback_location: root_path, alert: "You are not allowed to make changes to this pin.")
    end
  end
end
