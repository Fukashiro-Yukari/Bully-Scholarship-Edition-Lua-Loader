MOD.Name = 'Spawn Car'
MOD.CarId = 272

function MOD:CarRemove()
    if not self.car or not VehicleIsValid(self.car) then return end
    
    if PedIsInVehicle(gPlayer,self.car) then
        PedWarpOutOfCar(gPlayer)
    end

    VehicleDelete(self.car)
end

function MOD:Think()
    if self.car and PedIsInVehicle(gPlayer,self.car) and IsButtonPressed(3,0) and IsButtonBeingPressed(6,0) then
        self:CarRemove()
    end

    if not IsButtonPressed(8,0) then return end

    if IsButtonBeingPressed(0,0) then
        self.CarId = self.CarId-1

        if self.CarId < 272 then
            self.CarId = 298
        end

        self:Print('Select car: '..self.CarId)
    end

    if IsButtonBeingPressed(1,0) then
        self.CarId = self.CarId+1

        if self.CarId > 298 then
            self.CarId = 272
        end

        self:Print('Select car: '..self.CarId)
    end

    if IsButtonBeingPressed(2,0) then
        self:Print('Spawn car: '..self.CarId)

        local x,y,z = PlayerGetPosXYZ()
        VehicleRequestModel(self.CarId)
        
        self:CarRemove()

        self.car = VehicleCreateXYZ(self.CarId,x,y+3,z)
    end

    if not self.car then return end

    if IsButtonBeingPressed(3,0) and not PedIsInVehicle(gPlayer,self.car) and VehicleIsValid(self.car) then
        local x,y,z = PlayerGetPosXYZ()
        VehicleSetPosXYZ(self.car,x,y+3,z)
        self:Print('TP car: '..self.CarId)
    end

    if IsButtonBeingPressed(7,0) then
        if not PedIsInVehicle(gPlayer,self.car) then
            PedWarpIntoCar(gPlayer,self.car)
        else
            self:CarRemove()
        end
    end
end