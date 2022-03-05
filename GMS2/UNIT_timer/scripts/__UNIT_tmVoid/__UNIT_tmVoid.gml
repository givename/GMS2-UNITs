
function __UNIT_tmVoid() {};

function __UNIT_tmOverride_set_finit(_f) {
	self.__set_f("__finit", _f);
}

function __UNIT_tmOverride_set_ftick(_f) {
	self.__set_f("__ftick", _f);
}

function __UNIT_tmOverride_get_finit() {
	return self.__finit;
}

function __UNIT_tmOverride_get_ftick() {
	return self.__ftick;
}

#macro ____UNIT_TM_SKIP_VOID_TICK_LOOP \
if (UNIT_PREPROCESSOR_TM_ENABLE_SKIP_VOID_TICK) { \
if (_timer._get_ftick() == __UNIT_tmVoid) { \
	____UNIT_TM_SKIP_VOID_TICK; \
	return false; \
} \
}

#macro ____UNIT_TM_SKIP_VOID_TICK_TIMELAPSE \
if (UNIT_PREPROCESSOR_TM_ENABLE_SKIP_VOID_TICK) { \
if (_timer._get_ftick() == __UNIT_tmVoid) { \
	____UNIT_TM_SKIP_VOID_TICK; \
	return (_timer.__step == 0); \
} \
}
