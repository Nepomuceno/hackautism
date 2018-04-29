local composer = require( "composer" )
local widget = require( "widget" )
local questionSet = require "questionSet"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local questionText
 local questionCounter = 1
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

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

    end
print (wheelType)

-- Create the widget
local pickerWheel = widget.newPickerWheel(
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

 
local function getValueFromWheel()
 local values = pickerWheel:getValues()
 local currentStyle = values[1].value
end

local function  nextQuestion( event )

    if(event.phase == "began") then

        questionCounter = questionCounter + 1

        questionText:removeSelf()
    
        questionText = display.newText( questionSet.question[questionCounter], display.contentCenterX, 200, 300, 200, native.systemFont, 18 )
        makeWheel(questionSet.picker[questionCounter])

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