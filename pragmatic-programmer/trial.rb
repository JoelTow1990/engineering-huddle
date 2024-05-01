big_var = 1000
small_var = 10
on_next_call = ->(i) { i ** 2 }
if big_var > small_var
  do_something
end
