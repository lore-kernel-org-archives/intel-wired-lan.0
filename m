From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 24 Jan 2019 09:10:24 +0100
Subject: [Intel-wired-lan] [Intel-gfx] [PATCH 1/3] treewide: Lift switch
 variables out of switches
In-Reply-To: <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
 <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net>
 <87va2f1int.fsf@intel.com>
 <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
Message-ID: <20190124081024.GA1108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 24, 2019 at 07:55:51AM +1300, Kees Cook wrote:
> On Thu, Jan 24, 2019 at 4:44 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Wed, 23 Jan 2019, Edwin Zimmerman <edwin@211mainstreet.net> wrote:
> > > On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> > >> >> Variables declared in a switch statement before any case statements
> > >> >> cannot be initialized, so move all instances out of the switches.
> > >> >> After this, future always-initialized stack variables will work
> > >> >> and not throw warnings like this:
> > >> >>
> > >> >> fs/fcntl.c: In function ?send_sigio_to_task?:
> > >> >> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
> > >> >>    siginfo_t si;
> > >> >>              ^~
> > >> >
> > >> > That's a pain, so this means we can't have any new variables in { }
> > >> > scope except for at the top of a function?
> 
> Just in case this wasn't clear: no, it's just the switch statement
> before the first "case". I cannot imagine how bad it would be if we
> couldn't have block-scoped variables! Heh. :)

Sorry, it was not clear at first glance.  So no more objection from me
for this change.

greg k-h
