exports.launch = function(data, ctx) {
    //var os = require("os");
    var sys = require("sys");
    var subprocess = require("subprocess");
    var put = subprocess.popen(["qmlscene", data.from_qml], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, bufsize=1); //os.system("qmlscene", [data.from_qml]);




    //var put = subprocess.check_call("qmlscene", [data.from_qml]); //os.system("qmlscene", [data.from_qml]);


    print(subprocess);
    print(put);

    var output = sys.stdout;

print(output)

    /*for ( line in output) {
        print(line);
        for(l in line) {
            print(l);
            for(i in l){
                print(i)
            }
        }
    }*/
    print(output.impl__);
    while (true) {
        //ctx.reply(output);
        for ( line in output) {
        ctx.reply({'out':line});
        }
        if (output != '' && output != null){

        }
        else break;
    }


    return ({'out':output});


    /*var process = require('child_process');
    //var qml = process.exec("qmlscene", [data.from_qml]);


    process.exec(("qmlscene" + data.from_qml), function(error, stdout, stderr) {
        ctx.reply({out: stdout.toString()});
        ctx.reply({out: error.toString()});
        ctx.reply({out: stderr.toString()});
    });

    /*qml.stdout.on('data', function(chunk) {
      ctx.reply({out: chunk});
    });

    qml.stderr.on('data', function(chunk) {
      ctx.reply({out: chunk});
    });

    qml.on('close', function(chunk) {
      ctx.reply({out: chunk});
    });*/

}
