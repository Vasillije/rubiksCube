class CubesController < ApplicationController
  def index
    @cubes = Cube.all
    render json: @cubes
  end

  def show
    cube = Cube.find(params[:id])
    render json: cube.state
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cube not found" }, status: :not_found
  end

  def create
    cube = CubesService.create_cube
    render json: cube, status: :created
  rescue => e
    render json: {error: e.message}, status: :unprocessable_entity
  end

  def rotate
    cube = CubesService.rotate_cube(params[:id], params[:face], params[:direction])
    render json: cube.state, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {error:"Cube not found"}, status: :not_found
  rescue => e
    render json: {error: e.message}, status: :unprocessable_entity
  end
end
