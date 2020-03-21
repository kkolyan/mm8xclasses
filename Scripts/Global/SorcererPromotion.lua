QuestNPC = 74 -- Vetrinus Taleshire

local give = "Some sorcerers still afraid of Dark Magic. They still could reach impressive power, but they are "
        .. "limited to the duration of mortal. "
        .. "However, I do not see any threat in this way. I'll promote your Sorcerers to a Wizards, "
        .. "but you must do something for me."

function promoteSorcerers()
    for i = 0, 4 do
        evt.ForPlayer(i)
        if not evt.Cmp("Awards", 107) then
            if evt.Cmp("ClassIs", const.Class.Sorcerer) then
                evt.Set("ClassIs", const.Class.Wizard)
                evt.Add("Experience", 35000)
            else
                evt.Add("Experience", 25000)
            end
            evt.Add("Awards", 107)
        end
    end
end

function isBookOfKhelFound()
    evt.ForPlayer("All")
    return evt.Cmp("Awards", 35)
end



-- a simple quest: require item #1 (Longsword), give 1000 exp, 1000 gold and an artifact hat
Quest {
    "SorcererPromotionExplained1",
    Slot = 1,
    Texts = {
        Topic = "Wizard",
    },
    CanShow = function()
        return not isBookOfKhelFound()
    end,
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times,
    Done = function()
        Message(give)
    end
}

Quest {
    Slot = 3,
    CanShow = isBookOfKhelFound,
    Texts = {
        Topic = "Promote to Wizards",
    },
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times
    Done = function()
        Message("All Sorcerers in your party will be promoted to Wizard. Enjoy remainder of your mortal life with this power.")
        promoteSorcerers()
    end,
}

QuestNPC = 75 -- Lathean, Vampire promo. But promos liches too.

Quest {
    Slot = 3,
    CanShow = isBookOfKhelFound,
    Texts = {
        Topic = "Promote to Wizards",
    },
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times
    Done = function()
        Message("Ah, you return seeking promotion for others in your party?  I have not forgotten your help in "
                .. "recovering the Lost Book of Kehl!  All Sorcerers in your party will be promoted to Wizard.")
        promoteSorcerers()
    end,
}