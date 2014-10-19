font = {}

function font:draw_up_panel(up_panel)
  local x = up_panel.x
  local y = up_panel.y
  local circle = up_panel.circle
  love.graphics.setFont(word_size_up_panel)
  love.graphics.setColor(up_panel_text)
  love.graphics.print('Noughts  -  crosses', x, y)
  love.graphics.setColor(255, 100, 0)
  love.graphics.print('VS', x + 85, y - 43)
  love.graphics.setColor(blue)
  love.graphics.circle('fill', x + 5, y - 40, circle)
  love.graphics.setColor(violet)
  love.graphics.setFont(X_up_panel)
  love.graphics.print('X', x + 160, y - 63) 
end

function font:draw_down_panel(down_panel)
  local x = down_panel.x
  local y = down_panel.y 
  love.graphics.setFont(word_size_down_panel)
  love.graphics.setColor(down_panel_text)
  love.graphics.print('Press "escape" for guit, "tab" - for start new game', x, y - 25)
  love.graphics.print('p.s. Have a good time)', x + 106, y)
end

function font:draw_right_panel(right_panel, game_lever)
  local x = right_panel.x
  local y = right_panel.y
  local length = right_panel.length
  local height = right_panel.height
  if game_lever.ON == 0 or game_lever.DROW == 1 then 
    love.graphics.setColor(black)
    love.graphics.rectangle('fill', x - 28, y - 38, length + 28, height + 34)
    love.graphics.setFont(word_size_right_panel_new)
    game_lever.DROW = 0
    x = x - 14 y = y - 32
  else
    love.graphics.setColor(0, 100, 200)
    love.graphics.rectangle('fill', x - 14, y - 14, length, height)
    love.graphics.setFont(word_size_right_panel)
  end
  love.graphics.setColor(white)
  love.graphics.print('N\ne\nw\n\ng\na\nm\ne', x, y)
end

function font:draw_left_panel(left_panel)
  local x = left_panel.x
  local y = left_panel.y
  local circle = left_panel.circle
  love.graphics.setFont(word_size_left_panel)
  love.graphics.setColor(left_panel_text)
  love.graphics.print('First player:', x, y)
  love.graphics.print('Second player:', x, y + 100)
  love.graphics.setColor(blue)
  love.graphics.circle('fill', x + circle - 4, y + circle + 25, circle)
  love.graphics.setColor(violet)
  love.graphics.setFont(X_left_panel)
  love.graphics.print('X', x , y + 120) 
end

function font:draw_game_rectangle(rectangle_size)
  local x = rectangle_size.x 
  local y = rectangle_size.y
  local length = rectangle_size.length
  local height = rectangle_size.height
  love.graphics.setColor(black)
  love.graphics.rectangle('fill', x - 2 , y - 2 , length + 4, height + 4)
  love.graphics.setColor(white)
  love.graphics.rectangle('fill', x, y, length, height)
  love.graphics.setColor(black)
  love.graphics.rectangle('fill', x + length/4, y, 2, height)
  love.graphics.rectangle('fill', x, y + height/4, length, 2)
  love.graphics.rectangle('fill', x + length/2, y, 2, height)
  love.graphics.rectangle('fill', x , y + height/2, length, 2)
  love.graphics.rectangle('fill', x + 3*length/4, y, 2, height)
  love.graphics.rectangle('fill', x , y + 3*height/4, length, 2)
end

function font:draw_win(map, number_of_press)
  local j = 0
  local win = 0
  if number_of_press > 6 then
    if map[1] == map[5] and map[1] == map[9] and map[1] == map[13] 
                                  and (map[1] == 1 or map[1] == 2) then
      win = map[1]
      j = 1 -- 1 cтолбец
    end
    if map[2] == map[6] and map[2] == map[10] and map[2] == map[14] 
                                        and (map[2] == 1 or map[2] == 2) then
      win = map[2]
      j = 2 -- 2 столбец
    end
    if map[3] == map[7] and map[3] == map[11] and map[3] == map[15] 
                                        and (map[3] == 1 or map[3] == 2) then
      win = map[15]
      j = 3 -- 3 столбец
    end
    if map[4] == map[8] and map[4] == map[12] and map[4] == map[16] 
                                  and (map[4] == 1 or map[4] == 2) then
      win = map[4]
      j = 4 -- 4 столбец
    end
    if map[1] == map[2] and map[1] == map[3] and map[1] == map[4] 
                                  and (map[1] == 1 or map[1] == 2) then
      win = map[2]
      j = 5 -- 1 строка
    end
    if map[5] == map[6] and map[5] == map[7] and map[5] == map[8] 
                                    and (map[5] == 1 or map[5] == 2) then
      win = map[5]
      j = 6 -- 2 строка
    end
    if map[9] == map[10] and map[9] == map[11] and map[9] == map[12] 
                                        and (map[9] == 1 or map[9] ==2 ) then
      win = map[9]
      j = 7 -- 3 строка
    end
    if map[13] == map[14] and map[13] == map[15] and map[13] == map[16] 
                                      and (map[13] == 1 or map[13] == 2) then
      win = map[13]
      j = 8 -- 4 строка
    end
    if map[4] == map[7] and map[4] == map[10] and map[4] == map[13] 
                                      and (map[4] == 1 or map[4] == 2) then
      win = map[10]
      j = 9 -- диагональ с права на лево
    end
    if map[1] == map[6] and map[1] == map[11] and map[1] == map[16] 
                                  and (map[1] == 1 or map[1] == 2) then
      win = map[6]
      j = 10 -- диагональ с лева на право
    end
  end
  return j, win
end

function font:check_line(rectangle_size, j)
  local x = rectangle_size.x
  local y = rectangle_size.y
  local length = rectangle_size.length
  local height = rectangle_size.height
  if j == 1 or j == 2 or j == 3 or j == 4 then
    y1 = y 
    length1 = length/4 - 2
    height1 = height
    if j == 1 then -- 1 cтолбец
      x1 = x
      length1 = length/4 
    elseif j == 2 then -- 2 cтолбец
      x1 = x + length/4 + 2
    elseif j == 3 then -- 3 столбец
      x1 = x + length/4*2 + 2
    else -- 4 столбец
      x1 = x + length/4*3 + 2 
    end
  end
  if j == 5 or j == 6 or j == 7 or j == 8 then
    x1 = x
    length1 = length
    height1 = height/4 - 2
    if j == 5 then -- 1 строка
      y1 = y  
      height1 = height/4 
    elseif j == 6 then -- 2 строка
      y1 = y + height/4*1 + 2
    elseif j == 7 then -- 3 строка
      y1 = y + height/4*2 + 2
    else -- 4 строка 
      y1 = y + height/4*3 + 2 
    end
  end
  return x1,y1,length1,height1
end

function font:draw_diagonal(rectangle_size)
  local x = rectangle_size.x
  local y = rectangle_size.y
  local length = rectangle_size.length
  local height = rectangle_size.height
  if j == 9 then 
    love.graphics.setColor(255, 100, 0)
    love.graphics.rectangle('fill', x, y + height/4*3 + 2, length/4, height/4 - 2)
    love.graphics.rectangle('fill', x + length/4 + 2, y + height/4*2 + 2, length/4 - 2, height/4 - 2)
    love.graphics.rectangle('fill', x + length/4*2 + 2, y + height/4*1 + 2, length/4 - 2, height/4 - 2)
    love.graphics.rectangle('fill', x + length/4*3 +2, y , length/4 - 2, height/4)
  else
    love.graphics.setColor(255, 100, 0)
    love.graphics.rectangle('fill', x, y , length/4, height/4 )
    love.graphics.rectangle('fill', x + length/4 + 2, y + height/4*1 + 2, length/4 - 2, height/4 - 2)
    love.graphics.rectangle('fill', x + length/4*2 + 2, y + height/4*2 + 2, length/4 - 2, height/4 - 2)
    love.graphics.rectangle('fill', x + length/4*3 +2, y + length/4*3 + 2, length/4 - 2, height/4 - 2)
  end
end
