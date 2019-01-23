From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 23 Jan 2019 16:23:39 +0200
Subject: [Intel-wired-lan] [Intel-gfx] [PATCH 1/3] treewide: Lift switch
 variables out of switches
In-Reply-To: <874l9z31c5.fsf@intel.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
Message-ID: <871s53311w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
>>> Variables declared in a switch statement before any case statements
>>> cannot be initialized, so move all instances out of the switches.
>>> After this, future always-initialized stack variables will work
>>> and not throw warnings like this:
>>> 
>>> fs/fcntl.c: In function ?send_sigio_to_task?:
>>> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
>>>    siginfo_t si;
>>>              ^~
>>
>> That's a pain, so this means we can't have any new variables in { }
>> scope except for at the top of a function?
>>
>> That's going to be a hard thing to keep from happening over time, as
>> this is valid C :(
>
> Not all valid C is meant to be used! ;)
>
> Anyway, I think you're mistaking the limitation to arbitrary blocks
> while it's only about the switch block IIUC.
>
> Can't have:
>
> 	switch (i) {
> 		int j;
> 	case 0:
>         	/* ... */
> 	}
>
> because it can't be turned into:
>
> 	switch (i) {
> 		int j = 0; /* not valid C */
> 	case 0:
>         	/* ... */
> 	}
>
> but can have e.g.:
>
> 	switch (i) {
> 	case 0:
> 		{
> 			int j = 0;
> 	        	/* ... */
> 		}
> 	}
>
> I think Kees' approach of moving such variable declarations to the
> enclosing block scope is better than adding another nesting block.

PS. The patch is

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

and the drivers/gpu/drm/i915/* parts are

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree is appropriate. (There'll be minor
conflicts with in-flight work in our -next tree, but no biggie.)


-- 
Jani Nikula, Intel Open Source Graphics Center
