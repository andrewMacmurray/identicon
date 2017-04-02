defmodule IdenticonTest do
  use ExUnit.Case
  alias Identicon.Image, as: Img

  test "hash_input takes a string and returns a list of integers in a struct" do
    %Img{hex: hex} = Identicon.hash_input("smellyandrew")

    assert hex != nil
    assert length(hex) == 16
  end

  test "pick_color picks the first 3 values from hash_input and returns them in a struct" do
    img = Identicon.hash_input("smellyandrew")
    %Img{color: {r, g, b}} = Identicon.pick_color(img)

    assert r > 0 && r <= 255
    assert g > 0 && g <= 255
    assert b > 0 && b <= 255
  end

  test "build_grid takes a struct with a hex and color and creates a mirrored grid with indecies" do
    %Img{grid: grid} =
      "smellyandrew"
      |> Identicon.hash_input()
      |> Identicon.pick_color()
      |> Identicon.build_grid()

    [{a, i}, {b, j}, _, {d, _}, {e, _} | _tail] = grid

    assert length(grid) == 25
    assert a == e
    assert b == d
    assert i == 0
    assert j == 1
  end
end
