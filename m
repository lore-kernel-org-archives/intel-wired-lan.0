From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Jan 2019 13:12:26 +0100
Subject: [Intel-wired-lan] [PATCH 1/3] treewide: Lift switch variables
 out of switches
In-Reply-To: <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com>
 <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
Message-ID: <CAKv+Gu-ECKNy+nmnbsetkOg28VR1YkFgnRsu+u9mN4DC_poBwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Jan 2019 at 13:09, Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jan 23, 2019 at 1:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> > > Variables declared in a switch statement before any case statements
> > > cannot be initialized, so move all instances out of the switches.
> > > After this, future always-initialized stack variables will work
> > > and not throw warnings like this:
> > >
> > > fs/fcntl.c: In function ?send_sigio_to_task?:
> > > fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
> > >    siginfo_t si;
> > >              ^~
> >
> > That's a pain, so this means we can't have any new variables in { }
> > scope except for at the top of a function?
>
> AFAICS this only applies to switch statements (because they jump to a
> case and don't execute stuff at the start of the block), not blocks
> after if/while/... .
>

I guess that means it may apply to other cases where you do a 'goto'
into the middle of a for() loop, for instance (at the first
iteration), which is also a valid pattern.

Is there any way to tag these assignments so the diagnostic disregards them?
