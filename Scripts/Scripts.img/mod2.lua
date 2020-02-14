MOD.Name = 'test mod'

function MOD:Think()
    if not IsButtonPressed(14,0) then return end

    if IsButtonBeingPressed(15,0) then
        self:Print('test')

        -- DebugMenuAddPage('Test')
    end
end