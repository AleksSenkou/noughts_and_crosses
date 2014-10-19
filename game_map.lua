game_map = {}

function game_map:work_with_map(i,rectangle_size)
  local x = rectangle_size.x
  local y = rectangle_size.y
  local length = rectangle_size.length
  local height = rectangle_size.height
  if i == 6 then
    game_place_x = x + length/8*3
    elseif i == 9 then 
      game_place_x = x + length/8*1
  end
  if i%4 == 0 then
    game_place_x = x + length/8*7
  elseif i == 3 or i == 15 or i == 11 or i == 7 then
    game_place_x = x + length/8*5 
  elseif i%2 == 0 then
    game_place_x = x + length/8*3
  else
    game_place_x = x + length/8*1
  end 
  if i<=4 then
    game_place_y = y + height/8*1
  elseif i<=8 then 
    game_place_y = y + height/8*3
  elseif i<=12 then 
    game_place_y = y + height/8*5
  else 
    game_place_y = y + height/8*7
  end
  return game_place_x, game_place_y
end

function game_map:get_place(x ,y, w, q, length, height, number_of_press, map)
  local y1, y2, y3, y4, x1, x2, x3, x4
  if number_of_press%2 == 0 then
    r = 2
  else 
    r = 1
  end
  if y <= q + height/4 then y1 = 1
    elseif y <= q + height/2 then y2 = 1 
    elseif y <= q + height/4*3 then y3 = 1 
  else 
    y4 = 1 
  end
  if x <= w + length/4 then x1 = 1
    elseif x <= w + length/2 then x2 = 1
    elseif x <= w + length/4*3 then x3 = 1 
  else 
    x4 = 1 
  end
  return game_map:checking_map(y1, y2, y3, y4, x1, x2, x3, x4, map, number_of_press)
end

function game_map:checking_map(y1, y2, y3, y4, x1, x2, x3, x4, map, number_of_press)
  if x1 == 1 then 
    if y1 == 1 then 
      map, number_of_press = game_map:check_input(1, map)
    elseif y2 == 1 then
      map, number_of_press = game_map:check_input(5, map)
    elseif y3 == 1 then 
      map, number_of_press = game_map:check_input(9, map)
    elseif y4 == 1 then 
      map, number_of_press = game_map:check_input(13, map)  
    end
  elseif x2 == 1 then
    if y1 == 1 then 
      map, number_of_press = game_map:check_input(2, map)
    elseif y2 == 1 then 
      map, number_of_press = game_map:check_input(6, map)
    elseif y3 == 1 then 
      map, number_of_press = game_map:check_input(10, map)
    elseif y4 == 1 then 
      map, number_of_press = game_map:check_input(14, map)
    end
  elseif x3 == 1 then
    if y1 == 1 then 
      map, number_of_press = game_map:check_input(3, map)
    elseif y2 == 1 then 
      map, number_of_press = game_map:check_input(7, map)
    elseif y3 == 1 then 
      map, number_of_press = game_map:check_input(11, map)
    elseif y4 == 1 then 
      map, number_of_press = game_map:check_input(15, map)
    end
  elseif y1 == 1 then 
    map, number_of_press = game_map:check_input(4, map)
  elseif y2 == 1 then 
    map, number_of_press = game_map:check_input(8, map)
  elseif y3 == 1 then 
    map, number_of_press = game_map:check_input(12, map)
  else
    map, number_of_press = game_map:check_input(16, map)
  end
  return map, number_of_press
end

function game_map:check_input(i, map)
  if map[i] == 1 or map[i] == 2 then
    number_of_press = number_of_press - 1
  else 
    map[i] = r
  end
  return map, number_of_press
end
