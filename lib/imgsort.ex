defmodule ImageSort do
  def main([dir | _]) do

    dir
       # dir/str -> [file1/str, file2/str, ....]
    |> get_files()

       # [file1/str, file2/str] -> [image1/str, image2/str, .....]
    |> Enum.filter(&is_image?/1)

       # [image1/str, image2/str..] -> %{jpeg: [jpeg1/str, jpeg2/str, ...],
       #                                 gif: [gif1/str, gif2/str, ...],
       #                                 png: [png1/str, png2/str, ...]}
    |> categorize_files()

      # ??? -> str
    |> format_output()

    |> IO.puts()
  end
  def get_files2(directories, fucket) do
    if Enum.empty?(directories) do
      fucket
    else
      directory = hd(directories)
      files_and_directories = File.ls!(directory)

      {sub_directories, files} =
        Enum.split_with(files_and_directories, fn file_or_directory ->
          File.dir?(file_or_directory)
        end)

        # add sub_directories to bucket of directories

      get_files2(sub_directories ++ tl(directories), fucket ++ files)


    end
  end

  def get_files(directory) do
    files_and_directories = File.ls!(directory)

    {directories, files} =
      Enum.split_with(files_and_directories, fn file_or_directory ->
        File.dir?(file_or_directory)
      end)

    ### what do we want to return?
    Enum.map(files, fn file -> Path.join(directory, file) end) ++
      Enum.map(
        Enum.flat_map(directories, fn directory -> get_files(directory) end),
        fn subpath -> Path.join(directory, subpath) end
      )
  end

  def is_image?(file) do
    is_jpeg?(file) or is_png?(file) or is_gif?(file)
  end

  def is_jpeg?(file) do
     match?({:ok, <<0xFF, 0xD8, 0xFF, _::binary>>}, File.read(file))
  end

  def is_png?(file) do
    match?({:ok, <<0x89, 0x50, 0x4e, 0x47, _::binary>>}, File.read(file))
  end

  def is_gif?(file) do
    match?({:ok, <<0x47, 0x49, 0x46, 0x38, 0x37, 0x61, _::binary>>}, File.read(file))
  end



end
ImageSort.main(System.argv())


# elixir lib/sortimg.ex .     -> Output the list of found images
# elixir lib/sortimg.ex -c .  -> Output the count
# Found:
#   JPEGs: ##
#   GIFs:  ##
#   PNGs:  ##

#document the steps inputs and outputs
# think about how to break down the steps
# break them down further than you think you need to
# use the input / output to help decide where you can break down
# the most complicated steps
