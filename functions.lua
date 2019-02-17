
local S = cottages.S

--- if no owner is set, all players may use the node; else only the owner
cottages.player_can_use = function( meta, player )

	if not (player) then
		minetest.chat_send_all("kek")
	end
	
	if not (meta) then
		minetest.chat_send_all("lel")
	end

	if( not( player ) or not( meta )) then
		return false;
	end
	local pname = player:get_player_name();
	local owner = meta:get_string('owner' );
	local public = meta:get_string('public')
	if( not(owner) or owner=="" or owner==pname or public=="public") then
		return true;
	end
	return false;
	
end


-- call this in on_receive_fields and add suitable buttons in order
-- to switch between public and private use
cottages.switch_public = function(pos, formname, fields, sender, name_of_the_thing)
	-- switch between public and private
	local meta = minetest.get_meta(pos)
	local public = meta:get_string("public")
	local owner = meta:get_string("owner")
	if( sender and sender:get_player_name() == owner and fields.public) then
		if( public ~= "public") then
			meta:set_string("public", "public")
			meta:set_string("infotext",
				S("Public "..name_of_the_thing.." (owned by %s)"):format(owner))
			minetest.chat_send_player(owner,
				S("Your "..name_of_the_thing.." can now be used by other players as well."))
		else
			meta:set_string("public", "")
			meta:set_string("infotext",
				S("Private "..name_of_the_thing.." (owned by %s)"):format(owner))
			minetest.chat_send_player(owner,
				S("Your "..name_of_the_thing.." can only be used by yourself."))
		end
		return true
	end
end

-- generalized function to register microblocks/stairs
cottages.derive_blocks = function( modname, nodename, nodedesc, tile, groups )
	
	if stairs and stairs.mod and stairs.mod == "redo" then

		stairs.register_all(nodename, modname .. ":" .. nodename,
			{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			{tile},
			cottages.S(nodedesc .. " stair"),
			cottages.S(nodedesc .. " slab"),
			default.node_sound_wood_defaults())
									
	elseif minetest.global_exists("stairsplus") then
															
		stairsplus:register_all(modname, nodename, modname .. ":" .. nodename, {
			description = cottages.S(nodedesc),
			tiles = {tile},
			groups = {snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			sounds = default.node_sound_wood_defaults(),
		})

	else

		stairs.register_stair_and_slab(nodename, modname .. ":" .. nodename,
			{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			{tile},
			cottages.S(nodedesc .. " stair"),
			cottages.S(nodedesc .. " slab"),
			default.node_sound_wood_defaults())
	
	end
	
end
