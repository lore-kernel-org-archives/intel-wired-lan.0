From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 23 Jan 2019 17:46:14 +0200
Subject: [Intel-wired-lan] [Intel-gfx] [PATCH 1/3] treewide: Lift switch
 variables out of switches
In-Reply-To: <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
 <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net>
Message-ID: <87va2f1int.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Jan 2019, Edwin Zimmerman <edwin@211mainstreet.net> wrote:
> On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
>> >> Variables declared in a switch statement before any case statements
>> >> cannot be initialized, so move all instances out of the switches.
>> >> After this, future always-initialized stack variables will work
>> >> and not throw warnings like this:
>> >>
>> >> fs/fcntl.c: In function ?send_sigio_to_task?:
>> >> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
>> >>    siginfo_t si;
>> >>              ^~
>> >
>> > That's a pain, so this means we can't have any new variables in { }
>> > scope except for at the top of a function?
>> >
>> > That's going to be a hard thing to keep from happening over time, as
>> > this is valid C :(
>> 
>> Not all valid C is meant to be used! ;)
>
> Very true.  The other thing to keep in mind is the burden of enforcing
> a prohibition on a valid C construct like this.  It seems to me that
> patch reviewers and maintainers have enough to do without forcing them
> to watch for variable declarations in switch statements.  Automating
> this prohibition, should it be accepted, seems like a good idea to me.

Considering that the treewide diffstat to fix this is:

 18 files changed, 45 insertions(+), 46 deletions(-)

and using the gcc plugin in question will trigger the switch-unreachable
warning, I think we're good. There'll probably be the occasional
declarations that pass through, and will get fixed afterwards.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
