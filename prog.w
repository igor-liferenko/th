@ @c
@<Header files@>@;
@<Functions@>@;
int main(void)
{
  int fd = open("/dev/input/event2", O_RDONLY | O_NOCTTY);
  if (read_event(fd) == 0) printf("ok\n");
  else printf("bad\n");
  close(fd);
}

@ @<Functions@>=
int read_event(int fd)
{
        struct input_event ev;
        ssize_t n = read(fd, &ev, sizeof ev);
        if (n != sizeof ev) {
                fprintf(stderr, "Error reading device\n");
                return 1;
        }
        printf("type=%d code=%d value=%d\n", ev.type, ev.code, ev.value);
        return 0;
}

@ @<Header...@>=
#include <linux/input.h> /* |struct input_event| */
#include <stdio.h>
#include <fcntl.h> /* |open| */
#include <unistd.h> /* |read|, |close| */
