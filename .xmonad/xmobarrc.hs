Config { font = "xft:Bitstream Vera Sans Mono:size=9:regular:antialias=true"
        , overrideRedirect = False
        , borderColor = "#2C323C"
        , border = TopB
        , bgColor = "#21252B"
        , fgColor = "#828997"
        , position = TopW L 100
        , commands = [ Run Weather "CYVR" ["-t","<tempC>C","-L","18","-H","25","--normal","#98c379","--high","red","--low","lightblue"] 36000
                        , Run Network "wlp2s0" ["-L","0","-H","32","--normal","#98c379","--high","#e06c75"] 10
                        , Run Cpu ["-L","3","-H","50","--normal","#98c379","--high","#e06c75"] 10
                        , Run Memory ["-t","Mem: <usedratio>%"] 10
                        , Run Swap [] 10
                        , Run Com "uname" ["-s","-r"] "" 36000
                        , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                        , Run StdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% }{[ %wlp2s0% ] | %cpu% | %memory% * %swap% | <fc=#d19a66>%date%</fc> | %uname% | %CYVR% "
        }

