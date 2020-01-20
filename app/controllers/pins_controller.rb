class PinsController < ApplicationController
before_action :find_pin, only: [:show, :edit, :update, :destroy]

  def index
    @pins = Pin.all
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)

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
    if @pin.save
      redirect_to root_path, notice: 'Pin updated succesfully.'
    else
      render 'edit'
    end
  end

  def destroy
    if @pin.destroy
      redirect_to root_path, notice: 'Pin sdeleted uccesfully.'
    else
      redirect_to pin_path(@pin), alert: "Couldn't delete pin"
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
