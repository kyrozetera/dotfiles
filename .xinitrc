#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


#exec env GNOME_SHELL_SESSION_MODE=classic gnome-session --session

export SSH_ASKPASS=ssh-askpass

xset +dpms
xset dpms 0 0 300

#exec gnome-session
exec startxfce4
