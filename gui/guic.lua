-------------------------------------------------------------------------------------------
     
--  Resource description : Custom styled gui for MTA:SA                                  --
--  Author : #Mann                                                                       --
--  Status : In Progress                                                                 --
--  Not suppoesd to be distributed without the author's consent. Be kind enough to       --
--  give the credits to the author.                                                      --
	 
-------------------------------------------------------------------------------------------
	 
function drawBlack()
	
	dxDrawRectangle(290,190,400,200,tocolor(0,0,0,130))
	dxDrawImage(300,200,50,50,"i_w.png")

end

addEventHandler("onClientRender",root,drawBlack)
