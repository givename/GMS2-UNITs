
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super);
	ffree = function(handler, timer, inTick);
*/


/// @function		UNIT_TmTimerSync(steps, [ftick], [finit], [ffree]);
/// @description	Синхронный таймер
function UNIT_TmTimerSync(_steps, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapse(_steps, _ftick, _finit, _ffree) constructor {
	
	#region __private
	
	static __tick = __UNIT_tmSyncTick;
	
	#endregion
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TmTimerSync);
		
		}
		else {
			
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TmTimerSyncExt(steps, [ftick], [finit], [ffree]);
/// @description	Синхронный таймер
function UNIT_TmTimerSyncExt(_steps, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapseExt(_steps, _ftick, _finit, _ffree) constructor {
	
	#region __private
	
	static __tick = __UNIT_tmSyncTick;
	
	#endregion
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TmTimerSyncExt);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}


#region __private

function __UNIT_tmSyncTick(_handler, _timer, _super) {
	
	if (_timer.__step > 0) {
		
		--_timer.__step;
		_timer.__ftick(_handler, _timer, _super);
		return (_timer.__step == 0);
	}
}

#endregion
