
function getPointsForSkill(skill)
    local points = 0
    local s = skill
    while (s > 1) do
        points = points + s
        s = s - 1
    end
    return points
end

function changeClassDialog(newClass)
    local choice = Question("All skills will be forgotten. And some of them - forever. Are you ready to dedicate yourself to the light side of knowledge? (Yes/No)")
    if string.lower(choice) == "yes" then
        evt.Set("ClassIs", newClass)
        local player = Party[evt.CurrentPlayer]
        for skillId, old in player.Skills do
            local skill, mastery = SplitSkill(old)
            local maxMastery = Game.Classes.Skills[newClass][skillId]
            if skill > 0 then
                if maxMastery > 0 then
                    player.Skills[skillId] = JoinSkill(1, const.Novice)
                else
                    player.Skills[skillId] = 0
                end
                player.SkillPoints = player.SkillPoints + getPointsForSkill(skill)
            end
        end
        return true
    end
    return false
end