config bot;
    design lib1.bot;
    default liblist lib1 lib2;
    instance bot.a1 liblist lib3;
endconfig

config top;
    design lib1.top;
    default liblist lib2 lib1;
    instance top.bot use lib1.bot:config;
    instance top.bot.a1 liblist lib4;
    // ERROR - cannot set liblist for top.bot.a1 from this config
endconfig

config cfg2;
    design rtlLib.top;
    default liblist gateLib aLib rtlLib;
    cell foo use gateLib.foo;
endconfig

config cfg5;
    design aLib.adder;
    default liblist gateLib aLib;
    instance adder.f1 liblist rtlLib;
endconfig

config cfg6;
    design rtlLib.top;
    default liblist aLib rtlLib;
    instance top.a2 use work.cfg5:config;
endconfig