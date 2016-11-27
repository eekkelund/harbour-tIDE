#include "src.h"
#include "database.h"
#include "settings.h"
#include <qqml.h>

void src::registerTypes(const char *uri)
{
    // @uri harbour.sailorcreator.keyboard
    qmlRegisterType<Database>(uri, 1, 0, "Database");
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");

}

