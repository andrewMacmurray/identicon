defmodule Identicon do
  alias Identicon.Image, as: Img

  def main(args \\ []) do
    {opts, _, _} = OptionParser.parse(args, switches: [name: :string])
    case process(opts[:name]) do
      :ok -> IO.puts "image created for #{opts[:name]}"
      _ -> IO.puts "could not create image"
    end
  end

  def process(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Img{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Img{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50

      top_left = {x, y}
      bottom_right = {x + 50, y + 50}

      {top_left, bottom_right}
    end

    %Img{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Img{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Img{image | grid: grid}
  end

  def build_grid(%Img{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Img{image | grid: grid}
  end

  defp mirror_row([a, b, c]) do
    [a, b, c, b, a]
  end

  def pick_color(%Img{hex: [r, g, b | _tail]} = image) do
    %Img{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list

    %Img{hex: hex}
  end
end
