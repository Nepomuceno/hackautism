local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local txtTitle
local txtName
local inputName
local txtAge
local inputAge
local txtRelationship
local inputRelationship

local PADDING_TOP = 60
local PADDING_LEFT = 60
local TITLE_FONT_SIZE = 32
local LABEL_FONT_SIZE = 18
local INPUT_HEIGHT = 24
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    txtTitle = display.newText("CARER INFO",
        display.contentCenterX, PADDING_TOP,
        nil, TITLE_FONT_SIZE
    )
    
    txtName = display.newText("Name",
        display.contentCenterX, PADDING_TOP + TITLE_FONT_SIZE,
        display.contentWidth - PADDING_LEFT, LABEL_FONT_SIZE
    )

    inputName = native.newTextField(
        display.contentCenterX, PADDING_TOP + TITLE_FONT_SIZE + INPUT_HEIGHT,
        display.contentWidth - PADDING_LEFT, INPUT_HEIGHT
    )
    
    txtAge = display.newText("Age",
        display.contentCenterX, PADDING_TOP + 2 * TITLE_FONT_SIZE + INPUT_HEIGHT,
        display.contentWidth - PADDING_LEFT, LABEL_FONT_SIZE
    )

    inputAge = native.newTextField(
        display.contentCenterX, PADDING_TOP + 2 * TITLE_FONT_SIZE + 2 * INPUT_HEIGHT,
        display.contentWidth - PADDING_LEFT, INPUT_HEIGHT
    )
    
    txtRelationship = display.newText("Relationship",
        display.contentCenterX, PADDING_TOP + 3 * TITLE_FONT_SIZE + 2 * INPUT_HEIGHT,
        display.contentWidth - PADDING_LEFT, LABEL_FONT_SIZE
    )

    inputRelationship = native.newTextField(
        display.contentCenterX, PADDING_TOP + 3 * TITLE_FONT_SIZE + 3 * INPUT_HEIGHT,
        display.contentWidth - PADDING_LEFT, INPUT_HEIGHT
    )
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