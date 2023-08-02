
--[[replicated storage vars]]--
local replicatedStorage = game:GetService("ReplicatedStorage") -- variable to hold the location of replicated storage
local nailTool = replicatedStorage.nailTool                    -- var for the nail that will be in the players invintory
local nail = replicatedStorage.nail                            -- var for the nail model

--[[proximity prompt vars]]--
local proxprompt1 = script.Parent.Parent.pileOfNails.mainNail.Attachment.ProximityPrompt -- var for the location of the pile of nails proxinity prompt
local proxPrompt = script.Parent.Attachment.ProximityPrompt                              -- var for the prox prompt in the block

--[[functional/mic]]--
local block = script.Parent -- the location of the block to be nailed
local toolName = 'My Nail'  -- name for the nail in the invintory
local hasGivenPoints = nil  -- varialbe to hold if the script has given the player their points in the leaderstats (this ensured the script only runs once)


--[[pile of nails prox prompt]]--
proxprompt1.Triggered:Connect(function(player)             -- when the nail prox prompt is triggered
	if not (player.Backpack:FindFirstChild(toolName)) then -- if the nail tool is not already in the player's backpack
		local nailCopy = nailTool:Clone()                  -- create a copy of the nail tool in repStorage
		nailCopy.Name = toolName                           -- rename the copy
		nailCopy.Parent = player.Backpack                  -- put the copy of the nail tool in the player's backpack
	end
end)

--[[block to be nailed prox prompt]]--
proxPrompt.Triggered:Connect(function(player)           -- when the block prox prompt is triggerd
	if (player.Backpack:FindFirstChild('My Nail')) then -- if there is a nail in the player's backpack
		
		local myNail = player.Backpack:FindFirstChild('My Nail') -- crate a variable for the nial tool in the player's backpack
		local hammer = player.Backpack.Hammer                    -- create a variable for the hammer tool in the player's backpack
		
		local colidePart = script.Parent.Parent.interactionPart  -- create a variable for the interaction part
		local numNails = player.leaderstats.Nails                -- create a variavle for the nials leaderstats
		
		hasGivenPoints = false     -- set given points to false (the player has not reciced pints in the leaderstats)
		
		myNail:Destroy()           -- get rid of the nail in the player's backpack
		proxPrompt.Enabled = false -- turn off the block prox prompt
		
		nail:Clone()                -- clone the nail part in repStorage
		nail.Parent = script.Parent
		nail.CFrame = CFrame.new(block.Position + Vector3.new(0,0.35,0)) * CFrame.Angles(math.rad(180), math.rad(0), math.rad(0)) -- set the CFrame of the nail to be barley in the block
		
		colidePart.Transparency = 0.65 -- set the transparency of the interaction part to slightly transparent
		
		colidePart.Touched:Connect(function()   -- when the colide part is touched
			hammer.Activated:Connect(function() -- when the hammer is used
				if hasGivenPoints == false then -- if the points have not been given to the player

					nail.CFrame = CFrame.new(block.Position + Vector3.new(0,0.05,0)) * CFrame.Angles(math.rad(180),0,0) -- set the CFrame of the nail to be entierly in the block
					colidePart.Transparency = 1 -- make the interaction part comleatly transparent
		
					numNails.Value = numNails.Value + 1 -- add one to the nails in the player's leaderstats
					hasGivenPoints = true               -- set has given points to true
					proxPrompt.Enabled = true           -- re enable the proximity prompt
				end
			end)
		end)
	end
end)
