#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
    setuid( 0 );
    system( "su -c 'invoker --type=silica-qt5 -n /usr/bin/harbour-tide'" );
    return 0;
}
