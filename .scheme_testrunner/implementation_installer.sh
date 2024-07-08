RUN apk add --no-cache --update wine 7zip
RUN apt install -y wine64 7zip || true
RUN dnf install -y wine64 7zip || true
RUN unset DISPLAY && wine hostname
RUN wget https://download.racket-lang.org/installers/8.13/racket-8.13-x86_64-win32-cs.exe
ENV WINEDEBUG=-all
RUN wine racket-8.13-x86_64-win32-cs.exe /exenoui /qn /norestart
#RUN 7z e racket-8.13-x86_64-win32-cs.exe -y
#RUN apk add mlocate && updatedb && locate racket.exe
#ENV WINEPATH=/racket/bin
#RUN tree /racket
