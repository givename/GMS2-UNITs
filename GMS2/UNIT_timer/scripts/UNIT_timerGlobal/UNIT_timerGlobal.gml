
/*
	Данное решение не относится к базовым и представленно как дополнение

	Глобальный интерфейс для удобной простой и удобной работы
	Необходимо вызывать UNIT_timerGlobalTick каждый шаг для работы
	
	Данный файл можно удалить, он не влияет на работу остальных скриптов
*/

/// @description	Получение глобального обработчика
function UNIT_timerGlobal() {
	static _handler = new __UNIT_TimersHandlerGlobal();
	return _handler;
}

/// @param			super
/// @description	Итератор глобального обработчика
function UNIT_timerGlobalTick(_super) {
	static _handler = UNIT_timerGlobal();
	_handler.tick(_super);
}



/// @function		UNIT_timerGl_timer(timer, [argument]);
function UNIT_timerGl_timer(_timer, _argument) {
	return UNIT_timerGlobal().bind(_timer, _argument);
}

/// @function		UNIT_timerGl_loop([ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_loop(_ftick, _finit, _ffree, _argument) {
	return UNIT_timerGlobal().newLoop(_ftick, _finit, _ffree, _argument);
}

/// @function		UNIT_timerGl_loopAsync([ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_loopAsync(_ftick, _finit, _ffree, _argument) {
	return UNIT_timerGlobal().newLoopAsync(_ftick, _finit, _ffree, _argument);
}

/// @function		UNIT_timerGl_sync(steps, [ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_sync(_steps, _ftick, _finit, _ffree, _argument) {
	return UNIT_timerGlobal().newSync(_steps, _ftick, _finit, _ffree, _argument);
}

/// @function		UNIT_timerGl_async(milisec, [ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_async(_milisec, _ftick, _finit, _ffree, _argument) {
	return UNIT_timerGlobal().newAsync(_milisec, _ftick, _finit, _ffree, _argument);
}

/// @function		UNIT_timerGl_endSync(steps, f);
function UNIT_timerGl_endSync(_steps, _f) {
	return UNIT_timerGlobal().newEndSync(_steps, _f);
}

/// @function		UNIT_timerGl_endAsync(milisec, f);
function UNIT_timerGl_endAsync(_milisec, _f) {
	return UNIT_timerGlobal().newEndAsync(_milisec, _f);
}


#region __private

function __UNIT_TimersHandlerGlobal() : UNIT_TimersHandlerSimpleExt() constructor {
	
	static toString = function() {
		return ("UNIT::timer::UNIT_timerGlobal; number of timers: " + string(self.__count));
	}

}

#endregion

