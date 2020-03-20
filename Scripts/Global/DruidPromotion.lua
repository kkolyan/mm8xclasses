
--QuestNPC = 32  -- Frederick Talimere
 QuestNPC = 377 -- Raven Quicktoungue, GM of Merchant in Ravenshore near road to Shadowspire

-- another way to make a greeting

local give = "A-ha-ha, Yes, air, water, trees, hot fairies... Such a good time it was...(looking far away with warm smile)."
        .. "You know, I was an Elder of our Druid's Circle. Someday I was really low on cash and sold my Circlet to pay of "
        .. "debts. I dunno know where is it now, but I'd be grateful to get it back as a sweet memory. Actually with this crown "
        .. "I have an authority to promote Druids to Great Druids. ...if you find any Druids in Jadame."

function promoteDruids()
    for i = 0, 4 do
        evt.ForPlayer(i)
        if evt.Cmp("ClassIs", const.Class.Druid) then
            evt.Set("ClassIs", const.Class.GreatDruid)
            evt.Add("Experience", 35000)
            evt.Subtract("Inventory", 638)         -- Druid Circlet of Power
        else
            evt.Add("Experience", 25000)
        end
    end
end

local promotionMessage = "By the wisdom of eternal wood labyrinth, by the speed of the interstellar eagles, bla-bla-bla, I promote all Druids in your party to Great Druids."

-- a simple quest: require item #1 (Longsword), give 1000 exp, 1000 gold and an artifact hat
Quest{
    Slot = 3,
    "DruidPromotionQuest",
    CanShow = function()
        return vars.Quests.DruidPromotionQuest ~= "Done"
    end,
    QuestItem = 638,	-- Druid Circlet of Power
    Gold = 50000,  -- reward: gold
    Exp = 0,  -- reward: experience
    Quest = true,
    Done = function(t)
        promoteDruids()
    end
}
.SetTexts {
    Topic = "Druids",
    Give = give,

    Done = "Oooah! I can't believe you found it. Take this. And... " .. promotionMessage,
    Undone = give,

    After = "Wisdom with you, brothers.",

    Quest = "Find a Druid Circlet for Raven Quicktoungue in Ravenshore.",
}

Quest {
    Slot = 3,
    CanShow = function()
        return vars.Quests.DruidPromotionQuest == "Done"
    end, -- a check that the quest is finished (short function!)
    Texts = {
        Topic = "Promote to Great Druids",
    },
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times
    Done = function()
        Message(promotionMessage)
        promoteDruids()
    end,
}

--[[
NPCTopic{topic, text} and Greeting{firstGreet, greet} functions just call Quest function with appropriate parameters.
You can specify any parameters you would normally pass to Quest function, like Slot, CanShow etc.
Note that if you pass a number as topic to NPCTopic function, it will set StdTopic to that number.
See Quest Example.lua for details on StdTopic and other parameters of Quest function.


The call of Greeting function in this script is equivalent to this:
Quest{
	Slot = -1,
	Texts = {
		FirstGreet = "Hello, world!",
		Greet = "Hi.",
	}
}

The first call of NPCTopic function is equivalent to this:
Quest{
	Texts = {
		Topic = "Blah 1",
		Ungive = "Blah Blah Blah",
	}
}
]]