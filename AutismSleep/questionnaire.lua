local composer = require( "composer" )
local widget = require( "widget" )
local questionSet = require "questionSet"
local json = require ("json")
--local questionnaireAnswers = require "questionnaireAnswers"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local questionText
 local questionCounter = 1
 local pickerWheel
 local questionnaireAnswers = {}
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
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





 local time = 
{ 
    { 
        align = "left",
        width = 124,
        labelPadding = 20,
        startIndex = 2,
        labels = { "1", "2", "3","4","5","6","7","8","9","10","11","12"}
    },

    { 
        align = "left",
        width = 124,
        labelPadding = 20,
        startIndex = 2,
        labels = { "00", "10", "20","30","40","50"}
    },

    { 
        align = "left",
        width = 124,
        labelPadding = 20,
        startIndex = 2,
        labels = { "am", "pm"}
    }

}


 local isProblem = 
{ 
    { 
        align = "left",
        width = 124,
        labelPadding = 20,
        startIndex = 2,
        labels = { "Yes", "No" }
    }

}

 local frequency = 
{ 
    { 
        align = "left",
        width = 124,
        labelPadding = 20,
        startIndex = 2,
        labels = { "Rarely", "Sometimes", "Usually" }
    }

}

local function makeWheel(wheelType)

local myPickerType = frequency

if (wheelType=="frequency") then

    myPickerType = frequency

    elseif (wheelType=="isProblem") then

        myPickerType = isProblem

    elseif (wheelType=="time") then

        myPickerType = time
    end
print (wheelType)


-- Create the widget
pickerWheel = widget.newPickerWheel(
{
    x = display.contentCenterX,
    top = display.contentHeight - 160,
    columns = myPickerType,
    style = "resizable",
    width = 280,
    rowHeight = 32,
    fontSize = 14
})

end

local function sendData()

    local headers = {}
 
headers["Content-Type"] = "application/atom+xml;type=entry;charset=utf-8"
headers["Authorization"] = "SharedAccessSignature sr=https%3a%2f%2fhackautism.servicebus.windows.net%2f&sig=V4MAr%2fdfgq4CNhP9wNkvKirDiAItM0M0FxPGFpNsr5A%3d&se=1525536107&skn=sender"

local t = {
    ["answers"] = {questionnaireAnswers},

}



local body = json.encode(t)



local params = {}
params.headers = headers
params.body = body
 
network.request( "https://hackautism.servicebus.windows.net/devicedata/messages?api-version=2014-01", "POST", networkListener, params )

--local json_file_by_get = jsonFile( network.request( "https://my-json-server.typicode.com/caffebd/testjson/sensors", "GET", networkListener ) )

print ('send done')

end

 
local function getValueFromWheel()
 local values = pickerWheel:getValues()
 local currentStyle = values[1].value
end

local function getAnswer()

    local values = pickerWheel:getValues()
    local myAnswer

        if (questionSet.picker[questionCounter]=="time") then

            print (values[1].value)

         myAnswer = values[1].value..":"..values[2].value..""..values[3].value

        end   

--print (myAnswer)

table.insert (questionnaireAnswers, myAnswer)
         

end    

local function  nextQuestion( event )

    if(event.phase == "began") then

        getAnswer()

        --table.insert (questionnaireAnswers, )

        print ("set"..#questionSet.question)
        print ("counter"..questionCounter)

        if (questionCounter<#questionSet.question) then

      questionCounter = questionCounter + 1

        questionText:removeSelf()
        pickerWheel:removeSelf()
    
        questionText = display.newText( questionSet.question[questionCounter], display.contentCenterX, 200, 300, 200, native.systemFont, 18 )
        makeWheel(questionSet.picker[questionCounter])
        
        --sendData()

    else

        sendData()

    end

    end
end

 questionText = display.newText( questionSet.question[questionCounter], display.contentCenterX, 200, 300, 200, native.systemFont, 18 )


nextBtn = display.newImageRect ("images/nextBtn.png", 50 ,50)
nextBtn.x= display.contentWidth - 55
nextBtn.y = 55
nextBtn.id = "nextQuestion"

nextBtn:addEventListener("touch", nextQuestion)
--print( currentStyle, currentColor, currentSize )

makeWheel(questionSet.picker[questionCounter])

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