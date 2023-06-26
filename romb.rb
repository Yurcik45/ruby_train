def print_romb (width = 4, symbol = "$")
  if width % 2 == 1
    return puts "only plural"
  end
  if width < 3
    return puts "only >4"
  end
  puts "all is ok"

  step = 0
  for a in 1...width
    # puts "a: #{a}"
    # puts "step: #{step}"
    line = Array.new
    for b in 0..width
      if b == width/2 + step || b == width/2 - step
        line.push(symbol)
      else
        line.push(" ")
      end
    end
    if a >= width/2
      step -= 1
    else
      step += 1
    end
    puts line.join("")
  end

end

print_romb 50, "@"
