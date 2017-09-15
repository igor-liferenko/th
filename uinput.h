/* Copyright 2010 Stefan Tomanek <stefan.tomanek+th@wertarbyte.de>
 * You have permission to copy, modify, and redistribute under the
 * terms of the GPLv3 or any later version.
 * For full license terms, see COPYING.
 */

#include <stdint.h>

int open_uinput(const char *path);
void close_uinput();
int send_event(const uint16_t type, const uint16_t code, const int value);
