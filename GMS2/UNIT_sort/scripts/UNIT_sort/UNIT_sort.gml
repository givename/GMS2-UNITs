
/*
sourse:
https://github.com/dicksonlaw583/LightweightDataStructures/blob/master/extensions/LightweightDataStructures/LightweightDataStructures.gml
*/

//					f_set     = f_set(data, index, value);
//					f_get     = f_get(data, index);
//					f_compare = f_compare(value1, value2);
/// @function		UNIT_sort(data, reverse, sort_begin, sort_end, f_set, f_get, f_compare);
function UNIT_sort(_data, _reverse, _sort_begin, _sort_end, _set, _get, _compare) {
	
	static _def_compare = method_get_index(function(_x, _y) {
		return _x > _y;
	});
	
	if (_sort_end - _sort_begin < 2) return;
	if (_compare == undefined) _compare = _def_compare;
	
	var _stack = ds_stack_create();
	var _main = [
		_stack,
		_data,
		_reverse,
		_set,
		_get,
		_compare,
	];
	
	ds_stack_push(_stack, _sort_end, _sort_begin, __UNIT_sort_kernel);
	
	while (not ds_stack_empty(_stack))
		ds_stack_pop(_stack)(_main);
	
	ds_stack_destroy(_stack);
}


#region __private

enum __UNIT_SORT_MAIN {
	STACK,
	DATA,
	REVERSE,
	SET,
	GET,
	COMPARE,
};

function __UNIT_sort_kernel(_main) {
	
	var _stack = _main[__UNIT_SORT_MAIN.STACK];
	var _begin = ds_stack_pop(_stack);
	var _end   = ds_stack_pop(_stack);
	
	var _span = _end - _begin;
	if (_span < 2) return;
	if (_span == 2) {
		
		var _data = _main[__UNIT_SORT_MAIN.DATA];
		var _get  = _main[__UNIT_SORT_MAIN.GET];
		
		var _value1 = _get(_data, _begin);
		var _value2 = _get(_data, _begin + 1);
		if (_main[__UNIT_SORT_MAIN.REVERSE] == _main[__UNIT_SORT_MAIN.COMPARE](_value1, _value2)) {
			
			var _set = _main[__UNIT_SORT_MAIN.SET];
			
			_set(_data, _begin,     _value2);
			_set(_data, _begin + 1, _value1);
		}
		return;
	}
	
	var _halfSpan = _span div 2;
	var _middle   = _begin + _halfSpan;
	
	ds_stack_push(_stack,
		_middle, _end, _begin, __UNIT_sort_merger,
		_middle, _begin, __UNIT_sort_kernel,
		_end, _middle, __UNIT_sort_kernel,
	);
	
}

function __UNIT_sort_merger(_main) {
	
	var _stack  = _main[__UNIT_SORT_MAIN.STACK];
	var _begin  = ds_stack_pop(_stack);
	var _end    = ds_stack_pop(_stack);
	var _middle = ds_stack_pop(_stack);
	
	var _data    = _main[__UNIT_SORT_MAIN.DATA]; 
	var _set     = _main[__UNIT_SORT_MAIN.SET];
	var _get     = _main[__UNIT_SORT_MAIN.GET];
	var _compare = _main[__UNIT_SORT_MAIN.COMPARE];
	var _reverse = _main[__UNIT_SORT_MAIN.REVERSE];
	
	var _i = 0;
	var _j = 0;
	var _iSize = _middle - _begin;
	var _jSize = _end - _middle;
	var _ii    = -1;
	var _span  = _end - _begin;
	var _arr   = array_create(_span);
	
	var _value1, _value2;
	
	repeat (_span) {
		if (_i >= _iSize) {
			_arr[++_ii] = _get(_data, _middle + _j);
			++_j;
		}
		else
		if (_j >= _jSize) {
			_arr[++_ii] = _get(_data, _begin + _i);
			++_i;
		}
		else {
			
			_value1 = _get(_data, _begin + _i);
			_value2 = _get(_data, _middle + _j);
			
			if (_reverse == _compare(_value1, _value2)) {
				
				_arr[++_ii] = _value2;
				++_j;
			}
			else {
				
				_arr[++_ii] = _value1;
				++_i;
			}
		}
	}
	
	for (_i = 0; _i < _span; ++_i) {
		
		_set(_data, _begin + _i, _arr[_i]);
	}
	
}

#endregion
