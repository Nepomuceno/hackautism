local composer = require( "composer" )
local json = require ("json")
local widget = require( "widget" )
local tableData = require "tableData"
local receivedData = require "receivedData"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local monitor
 local profile 
 local sleep
 local log

 local buttonSize = 60
 local buttonSpacer = 80

 local windowObjects = {}
 local tableView

 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    local windowGroup = display.newGroup()

    local function checkIfSleeping()

  sleep:removeSelf()

if (tableData.isSleeping=="yes") then

sleep = display.newImageRect ("images/sleepSleep.png", buttonSize ,buttonSize)
sleep.x=buttonSize/2 + (2*buttonSpacer)
sleep.y = display.contentHeight-buttonSize

else

sleep = display.newImageRect ("images/sleepAwake.png", buttonSize ,buttonSize)
sleep.x=buttonSize/2 + (2*buttonSpacer)
sleep.y = display.contentHeight-buttonSize

end

end


local jsonFile = function( filename, base )

-- set default base dir if none specified
if not base then base = system.ResourceDirectory; end

-- create a file path for corona i/o
local path = system.pathForFile( filename, base )

-- will hold contents of file
local contents

-- io.open opens a file at path. returns nil if no file found
local file = io.open( path, "r" )
if file then
-- read all contents of file into a string
contents = file:read( "*a" )
io.close( file ) -- close the file after using it
end

return contents
end




local function networkListener( event )

    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        print ( "RESPONSE: " .. event.response )
        myDataTable = json.decode(event.response)

        print(myDataTable["environment"]["temp"])

         receivedData.temp[1] = myDataTable["environment"]["temp"]
         tableData.content[1].value = receivedData.temp[1]

         receivedData.pressure[1] = myDataTable["environment"]["pressure"]
         tableData.content[2].value = receivedData.pressure[1]

         receivedData.altitude[1] = myDataTable["environment"]["altitude"]
         tableData.content[3].value = receivedData.altitude[1]

         receivedData.humidity[1] = myDataTable["environment"]["humidity"]
         tableData.content[4].value = receivedData.humidity[1]

         receivedData.light[1] = myDataTable["environment"]["light"]
         tableData.content[5].value = receivedData.light[1]

         receivedData.red[1] = myDataTable["environment"]["red"]
         tableData.content[6].value = receivedData.red[1]

         receivedData.green[1] = myDataTable["environment"]["green"]
         tableData.content[7].value = receivedData.green[1]

         receivedData.blue[1] = myDataTable["environment"]["blue"]
         tableData.content[8].value = receivedData.blue[1]


         receivedData.noise[1] = myDataTable["environment"]["noise"]

         if (receivedData.noise[1]==false) then

            tableData.content[9].value = "Quiet"

         else

            tableData.content[9].value = "Noisy"
         end

         




         --tableData.content[1].level = receivedData.light[2]

         --receivedData.sound[1] = myDataTable[1]["sound"][1]
         --receivedData.sound[2] = myDataTable[1]["sound"][2]

         --tableData.content[2].value = receivedData.sound[1]
         --tableData.content[2].level = receivedData.sound[2]

         --receivedData.isSleeping = myDataTable[1]["isSleeping"]
         --tableData.isSleeping = receivedData.isSleeping

         --print (tableData.isSleeping)

         print (receivedData.light[1])


       --checkIfSleeping()

    end
end

--sb://autismsleep.servicebus.windows.net/;SharedAccessKeyName=sender;SharedAccessKey=8/zDLu1zjQKTsfE3XH1I01fobJpgJqqQDXOt0hR0pnM=;EntityPath=austismsleep

local headers = {}
 
headers["Content-Type"] = "application/json"
--headers["Authorization"] = "SharedAccessSignature sr=https%3a%2f%2fhackautism.servicebus.windows.net%2f&sig=V4MAr%2fdfgq4CNhP9wNkvKirDiAItM0M0FxPGFpNsr5A%3d&se=1525536107&skn=sender"


local body = "If this works, I'm going home"

local params = {}
params.headers = headers
params.body = body
 
--network.request( "https://hackautism.servicebus.windows.net/devicedata/messages?api-version=2014-01", "POST", networkListener, params )

--local json_file_by_get = jsonFile( network.request( "https://my-json-server.typicode.com/caffebd/testjson/sensors", "GET", networkListener ) )

local json_file_by_get = jsonFile( network.request( "http://hackautism.azurewebsites.net/device", "GET", networkListener ) )



local function clearWindow()

  if (#windowObjects>0) then

    for a = 1, #windowObjects do
        windowObjects[a]:removeSelf()
        windowObjects[a]=nil;
    end

  end

end   

local function  showMonitor(event )

 if(event.phase == "began") then

  clearWindow()  
 
  local monitorText = display.newText( "monitor", 200, 10, native.systemFont, 14 )
  

   local function onRowRender( event )
 
    -- Get reference to the row group
    local row = event.row

        local level = "low" --tableData.content[row.index].level

        local myRowColor = { 0, 0, 0}

        if (level == "low") then

           print (level)

          row:setRowColor( { default = {0.59, 0.98, 0.59}, over = {0.59, 0.98, 0.59}} )


          elseif (level =="medium") then

             print (level)

            row:setRowColor( { default = {1, 0.84, 0}, over = {1, 0.84, 0}} )

            elseif (level =="high") then

               print (level)

              row:setRowColor( { default = {0.8, 0.07, 0.23}, over = {0.8, 0.07, 0.23}} )


            end
 
    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

  --  if (row.index <= #tableData.content) then 
 
    --local rowIcon = display.newImageRect ("images/"..tableData.content[row.index].icon, 25,25)
    local rowTitle = display.newText( row, tableData.content[row.index].text, 0, 0, nil, 14 )
    local rowValue = display.newText( row, tableData.content[row.index].value, 0, 0, nil, 14 )


    --row:insert(rowIcon)
    row:insert(rowTitle)
    row:insert(rowValue)

    rowTitle:setFillColor( 0 )
    rowValue:setFillColor( 0 )

        rowTitle.anchorX = 0
    rowTitle.x = 40
    rowTitle.y = rowHeight * 0.5

    rowValue.anchorX = 0
    rowValue.x = 180
    rowValue.y = rowHeight * 0.5

 --[[   
    rowValue:setFillColor( 0 )
 
    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 40
    rowTitle.y = rowHeight * 0.5

    rowValue.anchorX = 0
    rowValue.x = 180
    rowValue.y = rowHeight * 0.5

    rowIcon.anchorX = 0
    rowIcon.x = 10
    rowIcon.y = rowHeight *0.5--]]


    --end

 
end

  tableView = widget.newTableView
    {
        left = 5,
        top = 15,
        height = display.contentHeight-buttonSize-55,
        width = display.contentWidth-10,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener
    }

 print (#tableData.content)
-- Insert 40 rows
for i = 1, #tableData.content do
    -- Insert a row into the tableView

     tableView:insertRow(
        {
            isCategory = isCategory,
            rowHeight = 50,
            rowColor =  {0.8, 0.07, 0.23,1},
            lineColor = lineColor,
            params = {}  -- Include custom data in the row
        }
    )
    
end


  windowGroup:insert(monitorText)
  windowGroup:insert(tableView)
  table.insert(windowObjects, monitorText)
  table.insert(windowObjects, tableView)

end

  tableView:reloadData()
end

local function  showProfile(event)

if(event.phase == "began") then

    clearWindow()
   
     local profileText = display.newText( "profile", 100, 100, native.systemFont, 14 )
     windowGroup:insert(profileText)
     table.insert(windowObjects,profileText)

 end    
end

local function  showSleep(event)

    if(event.phase == "began") then

    clearWindow()
    
     local sleepText = display.newText( "sleep", 100, 100, native.systemFont, 14 )
     windowGroup:insert(sleepText)
     table.insert(windowObjects,sleepText)

 end
end

local function  showLog(event)

  if(event.phase == "began") then

   clearWindow()
   
   local logText = display.newText( "log", 100, 100, native.systemFont, 14 )
   windowGroup:insert(logText)
   table.insert(windowObjects,logText)

 end
end



  


monitor = display.newImageRect ("images/monitor.png", buttonSize ,buttonSize)
monitor.x=buttonSize/2
monitor.y = display.contentHeight-buttonSize

profile = display.newImageRect ("images/profile.png", buttonSize ,buttonSize)
profile.x=buttonSize/2 + buttonSpacer
profile.y = display.contentHeight-buttonSize

sleep = display.newImageRect ("images/sleepSleep.png", buttonSize ,buttonSize)
sleep.x=buttonSize/2 + (2*buttonSpacer)
sleep.y = display.contentHeight-buttonSize

log = display.newImageRect ("images/log.png", buttonSize ,buttonSize)
log.x=buttonSize/2 + (3*buttonSpacer)
log.y = display.contentHeight-buttonSize

monitor:addEventListener("touch", showMonitor)
profile:addEventListener("touch", showProfile)
sleep:addEventListener("touch", showSleep)
log:addEventListener("touch", showLog)

sceneGroup:insert(monitor)
sceneGroup:insert(profile)
sceneGroup:insert(sleep)
sceneGroup:insert(log)



end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    composer.removeScene( "mainMenu")
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene