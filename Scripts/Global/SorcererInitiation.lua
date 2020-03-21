-- by owner of Spell Shop on Dagger Wound Island
QuestNPC = 339  -- Reshie, expert of Air Magic on Dagger Wound Isle


Quest {
    "SorcererInitiationExplained",
    Slot = 4,
    Texts = {
        Topic = "Sorcerers",
        Give = "Dark arts nowadays are almost normal. Very few magicians in Jadame even try to resist temptation of "
                .. "following Dark path. Not that I challenge Necromancers society, but I believe there should be a choice. "
                .. "If you ready, I'll teach you for the basics of the magic path free of darkness. But know that you must truly dedicate yourself "
                .. "to the magical arts, or you'll get nothing at the end."
    },
    Quest = false
}

Quest {
    Slot = 4,
    CanShow = function()
        return vars.Quests.SorcererInitiationExplained == "Given"
    end, -- a check that the quest is finished (short function!)
    Texts = {
        Topic = "Become a Sorcerer",
    },
    NeverGiven = true, -- skip "Given" state, perform Done/Undone check immediately
    NeverDone = true, -- sell any number of swords. This makes the quest completable mutiple times
    Done = function()
        if evt.Cmp("ClassIs", const.Class.Sorcerer) or evt.Cmp("ClassIs", const.Class.Wizard) then
            Message("I'm glad to see you've stood against the temptation of dark arts.")
        else
            if changeClassDialog(const.Class.Sorcerer) then
                Message("Knowledge is the light, seek the knowledge.")
            end
        end
    end,
}
