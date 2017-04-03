/* Copyright 2010 Stefan Tomanek <stefan.tomanek+th@wertarbyte.de>
 * You have permission to copy, modify, and redistribute under the
 * terms of the GPLv3 or any later version.
 * For full license terms, see COPYING.
 */

#include <linux/input.h>

const char *lookup_event_name_i(const int evtype, const int evcode);
const char *lookup_event_name(const struct input_event ev);

const char *lookup_type_name_i(const int evtype);
const char *lookup_type_name(const struct input_event ev);

int lookup_event_code(const char *eventname);
int lookup_event_type(const char *eventname);
