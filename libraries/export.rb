def create_or_replace(tmp_dir)
  ::Dir.foreach(tmp_dir) do |file_name|
    temp_path = File.join(tmp_dir, file_name)
    if ::File.file? temp_path
      file File.join(location, file_name) do
        content IO.read(tmp_path)
      end
    elsif ::File.directory? file_path
      directory File.join(location, file_name) do
        owner new_resource.user
      end
      create_or_replace(file_path)
    end
  end
end