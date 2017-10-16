dofile(minetest.get_modpath("vehicles").."/api.lua")

minetest.register_entity("spacecraft:explorer", {
	visual = "mesh",
	mesh = "spacecraft_explorer.b3d",
	textures = {"spacecraft_skin_clean.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 50,
	physical = true,
	collisionbox = {-1.1, 0, -1, 1, 1.9, 1.1},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=8, z=3}, false, {x=0, y=9, z=0})
		end
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 30, 
			decell = 0.95,
			shoots = true,
			arrow = "vehicles:missile_2",
			reload_time = 1,
			fly = true,
			fly_mode = "rise",
			braking_effect = "vehicles_trans.png",
		})
	end,
})

vehicles.register_spawner("spacecraft:explorer", ("Explorer"), "spacecraft_explorer_clean_inv.png")

minetest.register_craftitem("spacecraft:ion_thruster", {
	description = "Ion Thruster",
	inventory_image = "spacecraft_ion_thruster.png",
	})
	
minetest.register_craftitem("spacecraft:hull_section", {
	description = "Hull Section",
	inventory_image = "spacecraft_hull.png",
	})
	
minetest.register_craftitem("spacecraft:gyroscope", {
	description = "Gyroscope",
	inventory_image = "spacecraft_gyroscope.png",
	})
	
	minetest.register_craft({
	output = "spacecraft:ion_thruster",
	recipe = {
	{'','default:mese',''},
	{'','default:steelblock',''},
	{'','vessels:steel_bottle',''},
		}
	})
	
	minetest.register_craft({
	output = "spacecraft:hull_section 2",
	recipe = {
	{'','',''},
	{'','default:steelblock',''},
	{'','',''},
		}
	})
	
	minetest.register_craft({
	output = "spacecraft:gyroscope",
	recipe = {
	{'default:steel_ingot','default:stick','default:steel_ingot'},
	{'','default:stick',''},
	{'','spacecraft:hull_section',''},
		}
	})
	
	minetest.register_craft({
	output = "spacecraft:explorer_spawner",
	recipe = {
	{'spacecraft:ion_thruster','spacecraft:hull_section','spacecraft:ion_thruster'},
	{'spacecraft:hull_section','default:glass','spacecraft:hull_section'},
	{'spacecraft:gyroscope','spacecraft:ion_thruster','spacecraft:gyroscope'},
		}
	})