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

	create_random_world(0, 0, 30, 30)
	load_world(1)
end

function game_update()
	local new_xpos = player.xpos
	local new_ypos = player.ypos

	if btn(0) 
	then
		new_xpos = player.xpos - player.speed
	end
	if not is_wall(new_xpos, player.ypos, player.width, player.height) then
		player.xpos = new_xpos
	end

	if btn(1) 
	then
		new_xpos = player.xpos + player.speed
	end
	if not is_wall(new_xpos, player.ypos, player.width, player.height) then
		player.xpos = new_xpos
	end
	
	if btn(2) 
	then
		new_ypos = player.ypos - player.speed
	end
	if not is_wall(player.xpos, new_ypos, player.width, player.height) then
		player.ypos = new_ypos
	end
	
	if btn(3) 
	then
		new_ypos = player.ypos + player.speed
	end
	if not is_wall(player.xpos, new_ypos, player.width, player.height) then
		player.ypos = new_ypos
	end

	update_camera()


	if btnp(4)
	then
		create_random_map(0, 0, 15, 15)
	end
end

function game_draw()
	cls(0)

	camera(cam.xpos, cam.ypos)
	map(current_world.celx, current_world.cely, 0, 0, current_world.celw, current_world.celh)
	
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
		width = 6,
		height = 6,
		direction = 0
	}

	cam = {
		xpos = 0,
		ypos = 0,
	}

	worlds = {}

	current_world = {
		index = 0
	}
end

function create_random_world(celx_start, cely_start, celw, celh)
	worlds[#worlds+1] = {

		celx = celx_start,
		cely = cely_start,
		celw = celw,
		celh = celh,
		
		palette = random_palette()
	}

	for cely = cely_start, cely_start+celh do
		for celx = celx_start, celx_start+celw do
			mset(celx, cely, random_range(16, 20))
		end
	end
end

function load_world(index)
	current_world = worlds[index]
	current_world.index = index

	load_palette(current_world.palette)
end

function update_camera()
	local new_cam_xpos = mid(0, player.xpos - (current_world.celx*8)-64-player.width/2, (current_world.celw*8)-127)
	local new_cam_ypos = mid(0, player.ypos - (current_world.cely*8)-64-player.height/2, (current_world.celh*8)-127)
	
	cam.xpos = new_cam_xpos
	cam.ypos = new_cam_ypos
end

function random_palette()
	local palette = {}
	for i=1,16 do
		palette[i] = random_range(0, 15)
	end

	return palette
end

function is_wall(xpos, ypos, width, height)
	return 
		fget( mget(xpos/8, ypos/8), 1) or
		fget( mget((xpos+width)/8, ypos/8), 1) or
		fget( mget(xpos/8, (ypos+height)/8), 1) or
		fget( mget((xpos+width)/8, (ypos+height)/8), 1)
		or
		xpos < 0 or
		ypos < 0 or
		xpos+width > current_world.celw*8 or
		ypos+height > current_world.celh*8
end

---
--- utils
---
function cprint(s, ypos, c)
    print(s, 64-#s*2, ypos, c)
end

function random_range(min, max)
	return min + rnd(max)
end

function load_palette(palette)
	pal()
	for i=1,#palette do
		pal(i-1, palette[i])
	end
end

__gfx__
77777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70770700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33330030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0300300000000000000000000ddd0000000cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033330006660000bb000000d00d00000c000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003333300066060000b000000d00d00000c00c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003003300066060000bbbb000d00d00000ccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
030033000066060000b00b000000d00000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03030030000006000bb0000000d0d00000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03300000000666000000000000dd00000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
