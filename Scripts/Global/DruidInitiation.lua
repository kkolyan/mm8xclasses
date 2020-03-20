QuestNPC = 342  -- Ostrin Grivic, Magic of Earth expert on Dagger Wound Isle. lives in the most northern house

function getPointsForSkill(skill)
    local points = 0
    local s = skill
    while (s > 1) do
        points = points + s
        s = s - 1
    end
    return points
end

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
            local choice = Question("All skills will be forgotten. And some of them - forever. Are you ready to begin a Path? (Yes/No)")
            if string.lower(choice) == "yes" then
                Message("Follow your path with wisdom, brother")
                evt.Set("ClassIs", const.Class.Druid)
                local player = Party[evt.CurrentPlayer]
                for skillId, old in player.Skills do
                    local skill, mastery = SplitSkill(old)
                    local maxMastery = Game.Classes.Skills[const.Class.Druid][skillId]
                    if skill > 0 then
                        if maxMastery > 0 then
                            player.Skills[skillId] = JoinSkill(1, const.Novice)
                        else
                            player.Skills[skillId] = 0
                        end
                        player.SkillPoints = player.SkillPoints + getPointsForSkill(skill)
                    end
                end
            end
        end
    end,
}
