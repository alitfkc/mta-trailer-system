--değişkenler 
 local dorsekontrol=false
 local screenW, screenH = guiGetScreenSize()
 local panelacmadeger=false
 local tirabindi=false
 local tirdanindi=false
 local ozelarababindi=false 
 local ozelarabaindi=false
 local traktorbindi=false 
 local traktorindi=false
 local ozeldorse=false
 local tirhayaletmodu=false 
 local ayrilmasilme=false
 local dorseayrildi=false
function centerWindow(center_window) --panel ortalama
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end
function panel() --PANEL GENEL AYARLARI
    --panel genel ayarları
    main = guiCreateWindow(250, 250, 250, 125, "Trailer System", false)
    centerWindow( main )
    --dorse 1 butonu ayarları
    dorse1buton = guiCreateButton(18,25,100,40, "Tanker", false, main)
    
    --dorse2 butonu ayarları
    dorse2buton = guiCreateButton(18,75,100,40, "Dorse", false, main)

    --dorse3 butonu ayarları
    dorse3buton = guiCreateButton(130,25,100,40, "Çakıl", false, main)

    --dorse4 butonu ayarları
    dorse4buton = guiCreateButton(130,75,100,40, "Dorse 2", false, main)

    --kapat butonu ayarları
    kapatdorsebuton = guiCreateButton(229,0,20,20, "X", false, main)

    guiSetVisible(main,false)
end
function panelacma() --PANEL AÇMA KAPAMA
 if (isPedInVehicle(localPlayer)) then
    local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
    local oyuncuarabamodel=getElementModel(oyuncuaraba)
    local dorsevarmi=getVehicleTowedByVehicle(oyuncuaraba)   
    if oyuncuarabamodel== 515 or oyuncuarabamodel==514 or oyuncuarabamodel==403 then 
      if dorsekontrol == false then
        if panelacmadeger==false then
          if dorsevarmi==false then
            guiSetVisible(main,true)
           showCursor ( true ) 
           addEventHandler("onClientGUIClick",root,butonabasma)
           panelacmadeger=true
          else
            mesaj("Bu araca bağlı bir dorse var!","error")
          end
          else
          guiSetVisible(main,false) 
          removeEventHandler("onClientGUIClick",root,butonabasma)
          showCursor(false)
          panelacmadeger=false
        end
       else
       dorsekontrol=false
       triggerServerEvent("dorsesil",localPlayer)
       mesaj("Dorseniz kaldırıldı.","success")
       unbindKey("n","down",dorseindir)
       if (isTimer(altyazitimer)==nil) then --timer ayarlama    
        elseif (isTimer(altyazitimer)==true) then
        killTimer(altyazitimer)
        else
        end
      end
    elseif oyuncuarabamodel==531 then 
      if dorsekontrol == false then
        if panelacmadeger==false then
          if dorsevarmi==false then
            triggerServerEvent("dorse.bagla",localPlayer,610)
            mesaj("Traktörden dorseyi ayırmak için 'N' tuşunuza basınız.","info")
           dorsekontrol=true
           --timer ayarlama
           bindKey("n","down",dorseindir)
           
          else
            mesaj("Bu araca bağlı bir dorse var!","error")
          end 
        end
       else
       dorsekontrol=false
       triggerServerEvent("dorsesil",localPlayer)
       mesaj("Dorseniz kaldırıldı.","success")
       unbindKey("n","down",dorseindir)
       if (isTimer(altyazitimer)==nil) then --timer ayarlama    
        elseif (isTimer(altyazitimer)==true) then
        killTimer(altyazitimer)
        else
        end
      end
    elseif oyuncuarabamodel==552 then 
      if dorsekontrol == false then
        if dorsevarmi==false then
          triggerServerEvent("dorse.bagla",localPlayer,611)
          mesaj("Özel aracınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
          ozeldorse=true
          dorsekontrol=true
          --timer ayarlama
          bindKey("n","down",dorseindir)
          
        else
          mesaj("Bu araca bağlı bir dorse var!","error")
        end
       else
       dorsekontrol=false
       triggerServerEvent("dorsesil",localPlayer)
       mesaj("Dorseniz kaldırıldı.","success")
       unbindKey("n","down",dorseindir)
       ozeldorse=false
       if (isTimer(altyazitimer)==nil) then --timer ayarlama    
        elseif (isTimer(altyazitimer)==true) then
        killTimer(altyazitimer)
        else
        end
      end
     else
       if dorsekontrol==true then 
        dorsekontrol=false
        triggerServerEvent("dorsesil",localPlayer)
        mesaj("Dorseniz kaldırıldı.","success")
        unbindKey("n","down",dorseindir)
        ozeldorse=false
        if (isTimer(altyazitimer)==nil) then --timer ayarlama    
         elseif (isTimer(altyazitimer)==true) then
         killTimer(altyazitimer)
         else
         end
         return
        end
        mesaj("Dorse almak için bir TIR'a binmelisin.","info")
    end
   else
    if dorsekontrol==true then 
      dorsekontrol=false
      triggerServerEvent("dorsesil",localPlayer)
      mesaj("Dorseniz kaldırıldı.","success")
      unbindKey("n","down",dorseindir)
      ozeldorse=false
       return
      end
       mesaj("Dorse almak için bir TIR'a binmelisin.","info")
    end
end
function butonabasma() --BUTONA BASINCA YAPILAN GENEL AYARLAR
     --dorse1 butonuna basılınca
    if source == dorse1buton then
      local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
      if ( getElementModel ( oyuncuaraba) == 515 )  or ( getElementModel ( oyuncuaraba) == 514 )  or ( getElementModel ( oyuncuaraba) == 403 ) then
      triggerServerEvent("dorse.bagla",localPlayer,584)
      mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
      guiSetVisible(main,false)
      removeEventHandler("onClientGUIClick",root,butonabasma)
      showCursor(false)
      panelacmadeger=false

      else 
        mesaj("Bu yalnızca tırlarda kullanılır.","info")
      end
    end

    --dorse2 butonuna basılınca
    if source == dorse2buton then
      local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
      if ( getElementModel ( oyuncuaraba) == 515 )  or ( getElementModel ( oyuncuaraba) == 514 )  or ( getElementModel ( oyuncuaraba) == 403 ) then
        triggerServerEvent("dorse.bagla",localPlayer,435)
        mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
        bindKey("n","down",dorseindir)

       dorsekontrol=true
       guiSetVisible(main,false)
       removeEventHandler("onClientGUIClick",root,butonabasma)
       showCursor(false)
       panelacmadeger=false
       --timer ayarlama
      
       
      else 
        mesaj("Bu yalnızca tırlarda kullanılır.","info")
      end
    end

    --dorse3 butonuna basılınca
    if source == dorse3buton then
      local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
      if ( getElementModel ( oyuncuaraba) == 515 )  or ( getElementModel ( oyuncuaraba) == 514 )  or ( getElementModel ( oyuncuaraba) == 403 ) then
        triggerServerEvent("dorse.bagla",localPlayer,450)
        mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
        bindKey("n","down",dorseindir)
       dorsekontrol=true
       guiSetVisible(main,false)
       removeEventHandler("onClientGUIClick",root,butonabasma)
       showCursor(false)
       panelacmadeger=false
       --timer ayarlama
      
       
      else 
        mesaj("Bu yalnızca tırlarda kullanılır.","info")
      end
    end

    --dorse4 butonuna basılınca
    if source == dorse4buton then
      local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
      if ( getElementModel ( oyuncuaraba) == 515 )  or ( getElementModel ( oyuncuaraba) == 514 )  or ( getElementModel ( oyuncuaraba) == 403 ) then
        triggerServerEvent("dorse.bagla",localPlayer,591)
        mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
        bindKey("n","down",dorseindir)
       dorsekontrol=true
       guiSetVisible(main,false)
       
       removeEventHandler("onClientGUIClick",root,butonabasma)
       showCursor(false)
       panelacmadeger=false
       --timer ayarlama
      
       
      else 
        mesaj("Bu yalnızca tırlarda kullanılır.","info")
      end
    end

   --kapat butonuna basılınca
    if source == kapatdorsebuton then
      guiSetVisible(main,false)
      removeEventHandler("onClientGUIClick",root,butonabasma)
      showCursor(false)
      panelacmadeger=false
    end
end
function dorseindir()
  local oyuncuaraba=getPedOccupiedVehicle(localPlayer)
  local oyuncuarabamodel=getElementModel(oyuncuaraba)
  if dorsekontrol== true and dorseayrildi==false and oyuncuarabamodel==515 or oyuncuarabamodel==514 or oyuncuarabamodel==403  or oyuncuarabamodel==552 or oyuncuarabamodel==531 then
    local hiz= ( function( x, y, z ) return math.floor( math.sqrt( x*x + y*y + z*z ) * 155 ) end )( getElementVelocity( oyuncuaraba) ) 
     if hiz<=10 then
      triggerServerEvent("dorseyiayir",localPlayer)
      dorseayrildi=true
     else
      mesaj("Çok hızlısın bu hızda dorse bırakamazsın!","warning")
     end
  end
end
function arabayabinme(araba,koltuk) 
  if ( getElementModel ( araba) == 515 )  or ( getElementModel ( araba) == 514 )  or ( getElementModel ( araba) == 403 ) then
    if koltuk==0 then 
      if dorsekontrol==false then
        mesaj("TIR'a dorse eklemek için /dorse yazabilirsiniz.","info")
      end
      tirabindi=true
    end
  end
  if  ( getElementModel ( araba) == 552 ) then
    if koltuk==0 then 
      ozelarababindi=true
      if dorsekontrol==false then
        mesaj("Özel aracınıza dorse eklemek için /dorse yazabilirsiniz.","info")
      end
    end
  end
  if  ( getElementModel ( araba) == 531 ) then
    if koltuk==0 then 
      traktorbindi=true
      if dorsekontrol==false then
        mesaj("Traktöre dorse eklemek için /dorse yazabilirsiniz.","info")
      end
    end
  end
end
function arabadaninme(araba,koltuk) 
  if ( getElementModel ( araba) == 515 )  or ( getElementModel ( araba) == 514 )  or ( getElementModel ( araba) == 403 )then
   if panelacmadeger==true then
    guiSetVisible(main,false)
    removeEventHandler("onClientGUIClick",root,butonabasma)
    showCursor(false)
    panelacmadeger=false
   end
    if koltuk==0 then 
      tirdanindi=true
      if (isTimer(altyazidorsetimer)==nil) then --timer ayarlama    
      elseif (isTimer(altyazidorsetimer)==true) then
      killTimer(altyazidorsetimer)
      end
    end
 end
 if ( getElementModel ( araba) == 552 )  then
   if koltuk==0 then 
     ozelarabaindi=true
     if (isTimer(altyazidorsetimer)==nil) then --timer ayarlama    
     elseif (isTimer(altyazidorsetimer)==true) then
     killTimer(altyazidorsetimer)
     end
   end
  end
   if ( getElementModel ( araba) == 531 )  then
    if koltuk==0 then 
      traktorindi=true
      if (isTimer(altyazidorsetimer)==nil) then --timer ayarlama    
      elseif (isTimer(altyazidorsetimer)==true) then
      killTimer(altyazidorsetimer)
      end
    end
  end
end
function dorsebaglandi()
  for k, v in ipairs(getElementsByType('vehicle')) do
    if getElementData(v, "dorse.sahip") == getPlayerName(localPlayer) then
      oyuncudorse=v
    end
  end
  dorseayrildi=false
  if ayrilmasilme==true then 
    ayrilmasilme=false
    if (isTimer(dorsesilmezamanlayici)==nil) then   
    elseif (isTimer(dorsesilmezamanlayici)==true) then
    killTimer(dorsesilmezamanlayici)
    else
    end
  end
end
function dorseayrilma()
 dorseayrildi=true
 for k, v in ipairs(getElementsByType('vehicle')) do
    if getElementData(v, "dorse.sahip") == getPlayerName(localPlayer) then
      for k, g in ipairs(getElementsByType('vehicle')) do
        setElementCollidableWith(g, v,false)  
      end
    end
  end
  for k, v in ipairs(getElementsByType('vehicle')) do
    if getElementData(v, "dorse.sahip") == getPlayerName(localPlayer) then
      for k, g in ipairs(getElementsByType('player')) do
        setElementCollidableWith(g, v,false)
      end
    end
  end
  
  if  ayrilmasilme==false then
    function silmeonayli()
      dorsekontrol=false
      triggerServerEvent("dorsesil",localPlayer)
      mesaj("Dorseniz kaldırıldı.","success")
      unbindKey("n","down",dorseindir)
      ozeldorse=false
      ayrilmasilme=false
      oyuncudorse=nil
    end
    dorsesilmezamanlayici=setTimer(silmeonayli,60000,1)
    ayrilmasilme=true
  end

end
addEventHandler("onClientVehicleExplode", getRootElement(), function()
  for k, v in ipairs(getElementsByType('vehicle')) do
    if getElementData(v, "dorse.sahip") == getPlayerName(localPlayer) then
       if v== source then 
        triggerServerEvent("dorsesil",localPlayer)
        mesaj("Dorseniz kaldırıldı.","success")
        unbindKey("n","down",dorseindir)
        ozeldorse=false
        dorsekontrol=false
       end
    end
  end
end)
function sildi()
  for k, v in ipairs(getElementsByType('vehicle')) do
    v=getVehicleTowingVehicle(v)
    if getElementData(v, "dorse.sahip") == getPlayerName(localPlayer) then
       if v== source then 
        dorsekontrol=false
        triggerServerEvent("dorsesil",localPlayer)
        mesaj("Dorseniz kaldırıldı.","success")
        unbindKey("n","down",dorseindir)
        ozeldorse=false
        ayrilmasilme=false
        oyuncudorse=nil
      end
    end
  end
end
addEventHandler("onClientResourceStart",root,panel)
addEventHandler("onClientElementDestroy", getRootElement(), sildi)
addEventHandler("onClientTrailerDetach",root,dorseayrilma)
addEventHandler("onClientTrailerAttach",root, dorsebaglandi)
addEventHandler ( "onClientPlayerVehicleEnter", localPlayer, arabayabinme )-- baronun ateş etmesini engelledik
addEventHandler ( "onClientPlayerVehicleExit", localPlayer, arabadaninme )-- baronun ateş etmesini engelledik
addCommandHandler("dorse",panelacma)
addEvent("dorse.ayirma.engel.yazi",true)
addEventHandler("dorse.ayirma.engel.yazi",localPlayer,function()
  mesaj("Dorse ile TIR aynı açıda olmalı!","warning")
end)
function f1_dorse_ekle(dorseid) --F1'DEN DORSE ALMA
  if dorsekontrol then 
    dorsekontrol=false
    triggerServerEvent("dorsesil",localPlayer)
    mesaj("Dorseniz kaldırıldı.","success")
    unbindKey("n","down",dorseindir)
    ozeldorse=false
  else
    if dorseid== 584 then 
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    elseif dorseid==435 then
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    elseif dorseid==450 then 
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    elseif dorseid==591 then 
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Tırınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    elseif dorseid==611 then 
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Özel aracınızdan dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    elseif dorseid==610 then 
      triggerServerEvent("dorse.bagla",localPlayer,dorseid)
      mesaj("Traktörünüzden dorseyi ayırmak için 'N' tuşunuza basınız.","info")
      bindKey("n","down",dorseindir)
      dorsekontrol=true
    end
  end
end
addEvent("dorse.ekle",true)
addEventHandler("dorse.ekle",root,f1_dorse_ekle)