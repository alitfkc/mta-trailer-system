function dorse_bagla (dorseid) 
        local oyuncuaraba=getPedOccupiedVehicle(source)
		local x,y,z = getElementPosition( oyuncuaraba)
		local x1,y1,z1 = getElementRotation( oyuncuaraba)
        dorse = createVehicle ( dorseid, x, y, z, x1,y1,z1 )
        setElementData(dorse, "dorse.sahip", getPlayerName(source))
        attachTrailerToVehicle (oyuncuaraba, dorse)
        oyuncuayirdi=false
        setElementData(source,"oyuncu.dorse",oyuncuayirdi)
end 
function dorsesilme()
    for k, v in ipairs(getElementsByType('vehicle')) do
        if getElementData(v, "dorse.sahip") == getPlayerName(source) then
                 destroyElement(v)
                 oyuncuayirdi=false
                 setElementData(source,"oyuncu.dorse",oyuncuayirdi)
        end
      end
end
function dorseayirma()
    local oyuncuaraba=getPedOccupiedVehicle(source)
    for k, v in ipairs(getElementsByType('vehicle')) do
        if getElementData(v, "dorse.sahip") == getPlayerName(source) then

           local x,y,z=getElementPosition(v)
           local arx,ary,arz=getElementRotation(oyuncuaraba)
           local rx,ry,rz=getElementRotation(v)
           adrz=arz+    5
           edrz=arz-5
         if rz<=adrz and rz>=edrz then
           detachTrailerFromVehicle(oyuncuaraba,v)
           if rz>=0 and rz<=45 then
            setElementPosition(v,x+1,y-2,z)
           end
           if rz>=45 and rz<=90 then
            setElementPosition(v,x+2,y-0.5,z)
           end
           if rz>=90 and rz<=135 then
            setElementPosition(v,x+2,y+0.8,z)
           end
           if rz>=135 and rz<=180 then
            setElementPosition(v,x+0.5,y+1.5,z)
           end
           if rz>=180 and rz<=225 then
            setElementPosition(v,x-1,y+2,z)
           end
           if rz>=225 and rz<=270 then
            setElementPosition(v,x-2,y+0.5,z)
           end
           if rz>=270 and rz<=315 then
            setElementPosition(v,x-2,y-0.8,z)
           end
           if rz>=315 and rz<=360 then
            setElementPosition(v,x-0.5,y-1.5,z)
           end
           setElementFrozen(v,true)
           setElementAlpha(v,200)   
            oyuncuayirdi=true
            setElementData(source,"oyuncu.dorse",oyuncuayirdi)
        else
          triggerClientEvent("dorse.ayirma.engel.yazi",source)
        end
        end
      end   
end 
function oyundancikti()
    for k, v in ipairs(getElementsByType('vehicle')) do
        if getElementData(v, "dorse.sahip") == getPlayerName(source) then
                 destroyElement(v)
        end
      end
end
function dorseayrilmaengel(theTruck)
   local oyuncu=getVehicleOccupant(theTruck,0)
    oyuncuayirdik= getElementData(oyuncu,"oyuncu.dorse")
  if oyuncuayirdik==true then 
  else
    attachTrailerToVehicle(theTruck, source) -- Reattach the truck and trailer
  end
end
function dorsebaglandi(theTruck)        
    local oyuncu=getVehicleOccupant(theTruck,0)
   local dorse=getVehicleTowedByVehicle (theTruck) 
    setElementFrozen(dorse,false)
    setElementAlpha(dorse,255)
    oyuncuayirdi=false
    setElementData(oyuncu,"oyuncu.dorse",oyuncuayirdi)
end
addEventHandler("onTrailerAttach", getRootElement(),dorsebaglandi)
addEventHandler("onTrailerDetach", getRootElement(), dorseayrilmaengel)
addEventHandler ( "onPlayerQuit", root, oyundancikti)
addEvent("dorse.bagla",true)
addEventHandler("dorse.bagla",root,dorse_bagla)
addEvent("dorsesil",true)
addEventHandler("dorsesil",root,function()
    dorsesilme(source)
end)
addEvent("dorseyiayir",true)
addEventHandler("dorseyiayir",root,function()
    dorseayirma(source)
end)