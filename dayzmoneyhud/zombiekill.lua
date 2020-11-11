
addEventHandler( "onZombieGetsKilled", getRootElement(),
    function( killer )
        givePlayerMoney( killer, 5 );
    end
)
