
-- Version: 2.2
-- Autor:   Sokomine
-- License: GPLv3
--
-- Modified:
-- 11.03.19 Adjustments for MT 5.x
--          cottages_feldweg_mode is now a setting in minetest.conf
-- 27.07.15 Moved into its own repository.
--          Made sure textures and craft receipe indigrents are available or can be replaced.
--          Took care of "unregistered globals" warnings.
-- 23.01.14 Added conversion receipes in case of installed castle-mod (has its own anvil)
-- 23.01.14 Added hammer and anvil as decoration and for repairing tools.
--          Added hatches (wood and steel).
--          Changed the texture of the fence/handrail.
-- 17.01.13 Added alternate receipe for fences in case of interference due to xfences
-- 14.01.13 Added alternate receipes for roof parts in case homedecor is not installed.
--          Added receipe for stove pipe, tub and barrel.
--          Added stairs/slabs for dirt road, loam and clay
--          Added fence_small, fence_corner and fence_end, which are useful as handrails and fences
--          If two or more window shutters are placed above each other, they will now all close/open simultaneously.
--          Added threshing floor.
--          Added hand-driven mill.

cottages = {}

local modpath = minetest.get_modpath(minetest.get_current_modname())

-- there should be a way to distinguish this fork from others
cottages.mod = "linuxforks"

-- Boilerplate to support localized strings if intllib mod is installed.
if minetest.get_modpath( "intllib" ) and intllib then
	cottages.S = intllib.Getter()
else
	cottages.S = function(s) return s end
end

cottages.sounds = {}
-- MineClone2 needs special treatment; default is only needed for
-- crafting materials and sounds (less important)
if( not( minetest.get_modpath("hades_sounds"))) then
	default = {};
	cottages.sounds.wood   = nil
	cottages.sounds.dirt   = nil
	cottages.sounds.leaves = nil
	cottages.sounds.stone  = nil
	cottages.sounds.metal  = nil
else
	cottages.sounds.wood   = hades_sounds.node_sound_wood_defaults()
	cottages.sounds.dirt   = hades_sounds.node_sound_dirt_defaults()
	cottages.sounds.stone  = hades_sounds.node_sound_stone_defaults()
	cottages.sounds.leaves = hades_sounds.node_sound_leaves_defaults()
	cottages.sounds.metal = hades_sounds.node_sound_metal_defaults()
end

-- the straw from default comes with stairs as well and might replace
-- hades_cottages:roof_connector_straw and hades_cottages:roof_flat_straw
-- however, that does not look very good
if( false and minetest.registered_nodes["farming:straw"]) then
	cottages.straw_texture = "farming_straw.png"
	cottages.use_farming_straw_stairs = true
else
	cottages.straw_texture = "cottages_darkage_straw.png"
end
--cottages.config_use_mesh_barrel   = false;
--cottages.config_use_mesh_handmill = true;

-- set alternate crafting materials and textures where needed
-- (i.e. in combination with realtest)
dofile(modpath.."/adaptions.lua");

-- add to this table what you want the handmill to convert;
-- add a stack size if you want a higher yield
cottages.handmill_product = {};
cottages.handmill_product[ cottages.craftitem_seed_wheat ] = 'hades_farming:flour 1';
if minetest.get_modpath("hades_extrafarming") then
  cottages.handmill_product[ cottages.craftitem_seed_barley ] = 'hades_farming:flour 1';
	cottages.handmill_product[ "hades_extrafarming:seed_oat" ] = 'hades_farming:flour 1';
	cottages.handmill_product[ "hades_extrafarming:seed_rye" ] = 'hades_farming:flour 1';
	cottages.handmill_product[ "hades_extrafarming:seed_rice" ] = 'hades_extrafarming:rice_flour 1';
	cottages.handmill_product[ "hades_extrafarming:rice" ] = 'hades_extrafarming:rice_flour 1';
end

--[[ some examples:
cottages.handmill_product[ 'hades_core:cobble' ] = 'hades_core:gravel';
cottages.handmill_product[ 'hades_core:gravel' ] = 'hades_core:sand';
cottages.handmill_product[ 'hades_core:sand'   ] = 'hades_core:dirt 2';
cottages.handmill_product[ 'flowers:rose'   ] = 'dye:red 6';
cottages.handmill_product[ 'hades_core:cactus' ] = 'dye:green 6';
cottages.handmill_product[ 'hades_core:coal_lump' ] = 'dye:black 6';
--]]

-- same for the threshing floor
cottages.threshing_product = {};
cottages.threshing_product[ "hades_core:grass_1" ] = cottages.craftitem_seed_wheat;
cottages.threshing_product[ "hades_farming:wheat" ] = cottages.craftitem_seed_wheat;
if minetest.get_modpath("hades_extrafarming") then
	cottages.threshing_product[ "hades_extrafarming:barley" ] = cottages.craftitem_seed_barley;
	cottages.threshing_product[ "hades_extrafarming:oat" ] = 'hades_extrafarming:seed_oat';
	cottages.threshing_product[ "hades_extrafarming:rye" ] = 'hades_extrafarming:seed_rye';
-- 	cottages.threshing_product[ "hades_extrafarming:rice" ] = 'hades_extrafarming:seed_rice';
end

-- API to add items to the handmill and threshing floor

function cottages:add_threshing_product(input, output)
--Probably pretty obvious, but, for instance, 
--	hades_cottages:add_threshing_product("hades_core:grass_1",{"farming:seed_wheat", "farming:seed_oat"})
--	supports the two possible grains that can come from grass_1, 50/50 chance  of each
--maybe should add some error checking sometime...
	cottages.threshing_product[input] = output
end

function cottages:add_handmill_product(input, output)
	cottages.handmill_product[input] = output
end


-- process that many inputs per turn
cottages.handmill_max_per_turn = 20;
cottages.handmill_min_per_turn = 0;

dofile(modpath.."/functions.lua");
-- uncomment parts you do not want
dofile(modpath.."/nodes_furniture.lua");
dofile(modpath.."/nodes_historic.lua");
dofile(modpath.."/nodes_feldweg.lua");
-- allows to dig hay and straw fast
dofile(modpath.."/nodes_pitchfork.lua");
dofile(modpath.."/nodes_straw.lua");
dofile(modpath.."/nodes_hay.lua");
dofile(modpath.."/nodes_anvil.lua");
dofile(modpath.."/nodes_doorlike.lua");
dofile(modpath.."/nodes_fences.lua");
dofile(modpath.."/nodes_roof.lua");
dofile(modpath.."/nodes_barrel.lua");
dofile(modpath.."/nodes_mining.lua");
dofile(modpath.."/nodes_fireplace.lua");
--dofile(modpath.."/nodes_water.lua");
--dofile(modpath.."/nodes_chests.lua");

-- this is only required and useful if you run versions of the random_buildings mod where the nodes where defined inside that mod
dofile(modpath.."/alias.lua");

-- variable no longer needed
cottages.S = nil;
