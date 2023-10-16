keys_tuple = {:success, :error}
IO.puts("Tuple size: #{tuple_size(keys_tuple)}")
IO.puts("Item at index 0: #{elem(keys_tuple, 0)}")
IO.puts("Item at index 1: #{elem(keys_tuple, 1)}")

IO.puts("Adding element to keys tuple: :server_error")
keys_tuple = Tuple.append(keys_tuple, :server_error)
IO.puts("Adding element to keys tuple: :client_error")
keys_tuple = Tuple.append(keys_tuple, :client_error)
IO.puts("Adding element to keys tuple: :http_error")
keys_tuple = Tuple.append(keys_tuple, :http_error)
IO.puts("Tuple new size: #{tuple_size(keys_tuple)}")
values = Enum.join(Tuple.to_list(keys_tuple), ", ")
IO.puts("Tuple new values: #{values}")
