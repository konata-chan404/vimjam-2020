pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

function _init()
    menu_init()
end

---
--- main menu
---
function menu_init() 
	t = 0

	_update = menu_update
	_draw = menu_draw

	-- music(1)
end

function menu_update()
	if btnp(4) then
		game_init()
	end
end

function menu_draw()
	cls(0)

	if t < 10
	then
		cprint("press z", 100, 6)
	else 
		if t == 10 + 5
		then t = 0 end
	end

	t += 1
end

---
--- game loops
---

function game_init() 
	t = 0

	_update = game_update
	_draw = game_draw

	create_game_stuff()
end

function game_update()

	if btn(0) 
	then
		player.xpos -= player.speed
	end
	
	if btn(1) 
	then
		player.xpos += player.speed
	end
	
	if btn(2) 
	then
		player.ypos -= player.speed
	end
	
	if btn(3) 
	then
		player.ypos += player.speed
	end

end

function game_draw()
	cls(0)

    spr(0, player.xpos, player.ypos)
end

---
--- general game functions
---
function create_game_stuff()
	player = {
		xpos = 0,
		ypos = 0,
		speed = 1,
		direction = 0
	}

end

---
--- utils
---
function cprint(s, ypos, c)
    print(s, 64-#s*2, ypos, c)
end

function load_palette(palette)
	pal()
	for i=1,#palette do
		pal(i-1, palette[i])
	end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
