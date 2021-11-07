-- some games may not have the default nodes;
-- change this so that craft receipes work!

-- used for: anvil, hammer, barrel, steel hatch, stove pipe, wagon wheel, handmill.
cottages.craftitem_steel = "hades_core:steel_ingot";
cottages.craftitem_steel_block = "hades_core:steelblock";
-- used for: hammer, wood+steel hatch, fence gate, bed, table, bench, shelf,
--           washing place, wagon wheel, glass pane, flat wood, handmill,
--           operating the treshing floor. 
cottages.craftitem_stick = "group:stick";
-- used for: treshing floor, handmill, slate roof, vertical slate
cottages.craftitem_stone = "hades_core:stone";
cottages.craftitem_cobble = "hades_core:cobble";
-- used for: window shutter, half door, half door inverted, fence gate,
--           bed, bench, shelf, roof connector, vertical slate
cottages.craftitem_wood  = "group:wood";
-- used for: half door
cottages.craftitem_door  = "doors:door_wood";
-- used for: small fence
cottages.craftitem_fence = "hades_fences:fence_wood";

if minetest.get_modpath("ethereal") then
	cottages.craftitem_fence = "group:fence";
end

-- used for: rope
cottages.craftitem_cotton = "hades_extrafarming:cotton";
-- used for: rope
cottages.craftitem_string = "hades_farming:string";
-- used for: bed (head+foot), wool for tents
cottages.craftitem_wool  = "wool:white";
-- used for: washing place, loam
cottages.craftitem_clay  = "hades_core:clay";
-- used for: wagon wheel
cottages.craftitem_iron  = "hades_core:iron_lump";
-- used for: dirt road, brown roof (if no homedecor is installed)
cottages.craftitem_dirt  = "hades_core:dirt";
-- used for: loam
cottages.craftitem_sand  = "hades_default:sand";
-- used for: glass pane
cottages.craftitem_glass = "hades_core:glass";
-- used for: reet roof, reet block
cottages.craftitem_papyrus      = "hades_core:papyrus";
-- used for: black roof (if no homedecor is installed)
cottages.craftitem_coal_lump    = "hades_core:coal_lump";
-- used for: red roof (if no homedecor is installed)
cottages.craftitem_clay_brick   = "hades_core:clay_brick";
-- used for: treshing floor
cottages.craftitem_junglewood   = "hades_trees:jungle_wood";
cottages.craftitem_chest_locked = "hades_chests:chest_locked";
cottages.craftitem_chest        = "hades_chests:chest";
-- used for: hatch, table
cottages.craftitem_slab_wood = "hades_moreblocks:slab_wood";
-- use moreblocks slab > stairs slab > cottage planks
if (minetest.get_modpath("stairs")) then
	cottages.craftitem_slab_wood_fallback = "stairs:slab_wood";
else 
	cottages.craftitem_slab_wood_fallback = "hades_cottages:wood_flat";
end

-- texture used for fence gate and bed posts
cottages.texture_furniture  = "default_wood.png";
-- texture for the side of roof nodes
cottages.texture_roof_sides = "default_wood.png";
-- if the default wood node does not exist, use an alternate wood texture
-- (which is also used for furnitures and doors in this mod)
if( not( minetest.registered_nodes['hades_core:wood'])) then
	cottages.texture_roof_sides = "cottages_minimal_wood.png";
	cottages.texture_furniture  = "cottages_minimal_wood.png";
end

cottages.texture_chest = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
                "default_chest_side.png", "default_chest_side.png", "default_chest_front.png"};

-- the treshing floor produces wheat seeds
cottages.craftitem_wheat   = "hades_farming:wheat";
cottages.craftitem_seed_wheat   = "hades_farming:seed_wheat";
cottages.craftitem_seed_barley  = "hades_extrafarming:seed_barley";
cottages.texture_wheat_seed = "farming_wheat_seed.png";
cottages.texture_barley_seed = "farming_barley_seed.png";
cottages.texture_stick      = "default_stick.png";

-- texture for roofs where the tree bark is the main roof texture
cottages.textures_roof_wood = "default_tree.png";
if( not( minetest.registered_nodes["trees:tree"])) then
	-- realtest has diffrent barks; the spruce one seems to be the most fitting
	if( minetest.registered_nodes["trees:spruce_log" ]) then
		cottages.textures_roof_wood = "trees_spruce_trunk.png";

		-- this is also an indicator that we are dealing with realtest;
		cottages.craftitem_steel = "metals:pig_iron_ingot";
		-- stone exists, but is hard to obtain; chiseled stone is more suitable
		cottages.craftitem_stone = "hades_core:stone_flat";
		-- there are far more diffrent wood types
		cottages.craftitem_wood  = "group:planks";
		cottages.craftitem_door  = "doors:door_birch";
		cottages.craftitem_fence = "group:fence";
		cottages.craftitem_clay  = "grounds:clay_lump";
		cottages.craftitem_iron  = "group:plank"; -- iron lumps would be too specific
		cottages.craftitem_coal_lump  = "minerals:charcoal";
		cottages.craftitem_junglewood = "trees:chestnut_planks";
		cottages.craftitem_slab_wood  = "group:plank";

		cottages.texture_chest = { "spruce_chest_top.png", "spruce_chest_top.png", "spruce_chest_side.png",
			"spruce_chest_side.png", "spruce_chest_side.png", "spruce_chest_front.png"};

		-- wheat is called spelt in RealTest
		cottages.craftitem_seed_wheat = 'farming:seed_spelt';
		cottages.texture_wheat_seed   = 'farming_spelt_seed.png';
		cottages.texture_stick        = 'trees_maple_stick.png';
	else
		-- does not look so well in this case as it's no bark; but what else shall we do?
		cottages.textures_roof_wood = "cottages_minimal_wood.png";
	end
end

if( not( minetest.registered_nodes["wool:white"])) then
	cottages.craftitem_wool = "hades_cottages:wool";
end

