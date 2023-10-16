add = fn num1, num2 -> num1 + num2 end
rand1 = :rand.uniform(500)
rand2 = :rand.uniform(500)
IO.puts("Somando #{rand1}, #{rand2} usando uma função anonima: #{add.(rand1, rand2)}")

subtract = fn num1, num2 -> num1 - num2 end
rand1 = :rand.uniform(500)
rand2 = :rand.uniform(500)
IO.puts("Subtraindo #{rand1}, #{rand2} usando uma função anonima: #{subtract.(rand1, rand2)}")
