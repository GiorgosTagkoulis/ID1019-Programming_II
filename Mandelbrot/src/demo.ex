defmodule Demo do

  def demo() do
    small(-2.6, 1.2, 1.2)    # This is :mandel
    #small(-0.14,0.85,-0.13)   # This is :waves
    #small(-0.136,0.85,-0.134) # This is :forest
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

end
