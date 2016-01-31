
default:	build

clean:
	rm -rf Makefile objs

build:
	$(MAKE) -f objs/Makefile
	$(MAKE) -f objs/Makefile manpage

install:
	$(MAKE) -f objs/Makefile install

upgrade:
	/home/hsh/envirment/webserver/nginx/sbin/nginx -t

	kill -USR2 `cat /home/hsh/envirment/var/nginx.pid`
	sleep 1
	test -f /home/hsh/envirment/var/nginx.pid.oldbin

	kill -QUIT `cat /home/hsh/envirment/var/nginx.pid.oldbin`
