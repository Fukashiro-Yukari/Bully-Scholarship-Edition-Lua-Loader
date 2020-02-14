MOD.Name = 'godmode'

local name = MOD.Name

function MOD:init()
    self.plylasthp = PlayerGetHealth()
end

function MOD:KeyDown()
    if not IsButtonPressed(8,0) then return end

    if IsButtonBeingPressed(15,0) then
        if not self.IsOn then
            self.plylasthp = PlayerGetHealth()
        end

        if self.IsOn then
            self.IsOn = false
        else
            self.IsOn = true
        end

        if not self.IsOn then
            PlayerSetHealth(self.plylasthp or 200)
        end

        self:Print('God Mode '..(self.IsOn and 'On' or 'Off'))
    end
end

function MOD:Think()
    self:KeyDown()

    if self.IsOn then
        PlayerSetHealth(500)
    end
end