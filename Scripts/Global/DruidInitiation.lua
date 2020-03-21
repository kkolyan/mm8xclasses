QuestNPC = 342  -- Ostrin Grivic, Magic of Earth expert on Dagger Wound Isle. lives in the most northern house

Quest {
    "DruidInitiationExplained",
    Slot = 4,
    Texts = {
        Topic = "Druids",
        Give = "There are very few of us in Jadame. Druid path grant access to the full power of Elemental and Self schools, "
                .. "but mirror Dark and Light disciplines are closed. "
                .. "I can show you direction, but you should reject all your past "
                .. "and rethink your present to make your future."
    },
    Quest = false
}

Quest {
    Slot = 4,
    CanShow = function()
        return vars.Quests.DruidInitiationExplained == "Given"
    end, -- a check that the quest is finished (short function!)
    Texts = {
        Topic = "Become a Druid",
    },
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times
    Done = function()
        if evt.Cmp("ClassIs", const.Class.Druid) or evt.Cmp("ClassIs", const.Class.GreatDruid) then
            Message("If it'd be possible to rewind it, brother...")
        else
            if changeClassDialog(const.Class.Druid) then
                Message("Follow your path with wisdom, brother")
            end
        end
    end,
}
