defmodule Brot do

@doc """
c: the complex number that we want to check
if it belongs in the Mandelbort set
m: is the the "depth" we want to give to our
iterations
"""
  def mandelbrot({:cpx, cr, ci}, m) do
    {:cpx, z0r, z0i} = Cmplx.new(0, 0) # This is my z0
    i = 0
    test(i, z0r, z0i, cr, ci, m)
  end

@doc """
Checks when (the iteration), if ever, the absolute
value of the function f(z) = z^2 + c is greater
than 2
"""
  defp test(m, _zr, _zi, _cr, _ci, m), do: 0
  defp test(i, zr, zi, cr, ci, m) do
    a = Cmplx.abs({:cpx, zr, zi})

    if a <= 2.0 do
      {:cpx, z1r, z1i} = Cmplx.add(Cmplx.sqr({:cpx, zr, zi}), {:cpx, cr, ci})
      test(i+1, z1r, z1i, cr, ci, m)
    else
      i
    end
  end

end
