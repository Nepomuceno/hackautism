local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local questionBtn
 local startBtn
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

local function buttonPress (event)

    if(event.phase == "began") then

        composer.gotoScene(event.target.id)

    end

 end   

    -- Code here runs when the scene is first created but has not yet appeared on screen
 questionBtn = display.newImageRect ("images/questionBtn.png", 200 ,62)
questionBtn.x= display.contentCenterX
questionBtn.y = display.contentCenterY - 80
questionBtn.id="questionnaire"

 startBtn = display.newImageRect ("images/startBtn.png", 200 ,62)
startBtn.x= display.contentCenterX 
startBtn.y = display.contentCenterY + 80
startBtn.id = "page1"

questionBtn:addEventListener("touch", buttonPress)
startBtn:addEventListener("touch", buttonPress)


sceneGroup:insert(questionBtn)
sceneGroup:insert(startBtn)


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