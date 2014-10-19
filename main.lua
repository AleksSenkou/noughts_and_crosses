-- Крестики - нолики
require "font"
require "game_map"

map = {}
number_of_press = 0
rectangle_size = {x = 250, y = 200, length = 300, height = 300}
up_panel = {x = 305, y = 80, circle = 30}
left_panel = {x = 10, y = 210, circle = 20}
down_panel = {x = 215, y = 575}
right_panel = {x = 775, y = 264, length = 40, height = 215}
game_lever = {ON = 0, DROW = 0, START = 0}

function love.run()
  love.load(arg) 
  local dt = 0
  while true do
    if love.event then
      love.event.pump()
      for e,a,b,c,d in love.event.poll() do
        if e == "quit" then
          if not love.quit or not love.quit() then
            return
          end
        end
        love.handlers[e](a,b,c,d)
      end
    end
    love.update(dt)
    love.graphics.clear()
    love.draw()
    love.timer.sleep(0.1) 
    love.graphics.present()
  end
end

function love.load()
  word_size_up_panel = love.graphics.newFont(20)
  word_size_left_panel = love.graphics.newFont(17)
  word_size_down_panel = love.graphics.newFont(15)
  word_size_right_panel = love.graphics.newFont(20)
  word_size_right_panel_new = love.graphics.newFont(25)
  X_up_panel = love.graphics.newFont(50)
  X_left_panel = love.graphics.newFont(30)
  white = {255, 255, 255}
  black = {0, 0, 0}
  blue = {0, 0, 100}
  violet = {100, 10, 255}
  down_panel_text = {50, 50, 50}
  up_panel_text = {255, 250, 250}
  left_panel_text = {50, 47, 44}
  right_panel_text = {50, 47, 80}
  love.graphics.setBackgroundColor(104, 136, 248)
end

function love.update(dt)
end

function love.draw()
  draw_start_game()
  draw_player()
  font:draw_up_panel(up_panel)
  font:draw_left_panel(left_panel)
  font:draw_game_rectangle(rectangle_size)
  font:draw_down_panel(down_panel)
  font:draw_right_panel(right_panel, game_lever)
  output_win()
  draw_map()
end

function draw_start_game()
  if game_lever.START == 0 then 
    love.graphics.setFont(word_size_right_panel_new)
    love.graphics.setColor(black)
    love.graphics.print("Press 'TAB' for start", up_panel.x - 30, up_panel.y + 55)
  end
end

function draw_player()
  local text
  love.graphics.setFont(word_size_left_panel)
  if game_lever.ON == 1 and game_lever.START == 1 and game_lever.DROW == 0 then
    if number_of_press%2 == 0 or number_of_press == 0  then 
      color = blue
      text = "the course of the first player..."
    else
      color = violet
      text = "the course of the second player..."
    end
    love.graphics.setColor(color)
    love.graphics.print(text, up_panel.x - 34, up_panel.y + 57)
  end 
end

function draw_map()
  local flag = 1
  local i = 1
  if number_of_press > 0 then
    for i = 1, 16 do
      if map[i] == 1 or map[i] == 2 then
        game_place_x, game_place_y = game_map:work_with_map(i,rectangle_size)
        if map[i] == 1 then
          love.graphics.setColor(blue)
          love.graphics.circle("fill", game_place_x, game_place_y, left_panel.circle)
        else
          love.graphics.setColor(violet)
          love.graphics.setFont(X_up_panel)
          love.graphics.print("X", game_place_x - 17, game_place_y - 27)
        end
      else flag = 0 
      end
    end
    if flag == 1 then
      drow()
    end
  end
end

function drow()
  love.graphics.setColor(up_panel_text) 
  love.graphics.print("DROW !", up_panel.x , up_panel.y + 50)  
  game_lever.DROW = 1
end

function love.mousepressed(x, y, button)
  local w = rectangle_size.x
  local q = rectangle_size.y
  local length = rectangle_size.length
  local height = rectangle_size.height
  if button == 'l' or button == 'r' then
    button_start(x, y)  
    if x >= w and x <= w + length and y >= q and y <= q + height and game_lever.ON == 1 then
      number_of_press = number_of_press + 1
      map, number_of_press = game_map:get_place(x ,y, w, q, length, height, number_of_press, map)
    end
  end
end

function button_start(x, y)
  local w = right_panel.x - 14
  local q = right_panel.y - 14
  local length = right_panel.length
  local height = right_panel.height
  if x >= w and x <= w + length and y >= q and y <= q + height then
    new_game()
  end
end

function new_game()
  game_lever.ON = 1
  number_of_press = 0
  for i = 1, 16 do
    map[i] = 0
  end
  love.timer.sleep(0.2) 
end

function output_win()
  if number_of_press > 6 then
    j, win = font:draw_win(map, number_of_press)
    if j > 0 then
      x1, y1, length1, height1 = font:check_line(rectangle_size, j)
      if j == 9 or j == 10 then
        font:draw_diagonal(rectangle_size)
      else
        love.graphics.setColor(255, 100, 0)
        love.graphics.rectangle('fill', x1, y1, length1, height1)
      end
      if win == 1 then 
        player = "one"
      else player = "two"
      end
      love.graphics.setColor(left_panel_text)
      love.graphics.setFont(X_up_panel)
      love.graphics.print('Player number       WIN !', up_panel.x - 220, up_panel.y + 50)
      love.graphics.print(player, up_panel.x + 160, up_panel.y + 50)
      game_lever.ON = 0;
    end
  end
end

function love.focus(f)
  if not f then
    print("\n --- Game stoped --- \n")
  else
    print("\n --- Game continued --- \n")
  end
end

function love.keypressed(k)
  if k == 'escape' then
    print ("\n --- See you later) --- \n")
    love.event.push('quit')
  end 
  if k == 'tab' then 
    if game_lever.START == 0 then
      game_lever.START = 1
      game_lever.ON = 1
      love.timer.sleep(0.1)
    end
    new_game()
  end
end