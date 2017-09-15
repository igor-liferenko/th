/* Copyright 2010 Stefan Tomanek <stefan.tomanek+th@wertarbyte.de>
 * You have permission to copy, modify, and redistribute under the
 * terms of the GPLv3 or any later version.
 * For full license terms, see COPYING.
 */

#include <stdint.h>

typedef struct ignore {
	int code;
	struct ignore *next;
} ignore;

void ignore_key(uint16_t code, ignore **list);
int is_ignored(uint16_t code, ignore *list);
void clear_ignore_list(ignore **list);
