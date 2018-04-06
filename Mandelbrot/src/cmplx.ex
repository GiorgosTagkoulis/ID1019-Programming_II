defmodule Cmplx do

  def new(r, i) do
    {:cpx, r, i}
  end

  def add({:cpx, r1, i1}, {:cpx, r2, i2}) do
    {:cpx, r1+r2, i1+i2}
  end

  def sqr({:cpx, r, i}) do
    {:cpx, r*r - i*i, 2*r*i}
  end

  def abs({:cpx, r, i}) do
    :math.sqrt(r*r + i*i)
  end

end
