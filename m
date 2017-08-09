From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 9 Aug 2017 23:56:34 +0200
Subject: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
In-Reply-To: <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <15027171.LoAvHuklGv@aspire.rjw.lan> <20170809064231.GA19118@amd>
 <25469991.213uJSqkO8@aspire.rjw.lan>
 <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
Message-ID: <20170809215634.GA16992@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

> >[You seem to have a stale linux-pm address in your address book,
> >I replaced it with the current one in the CC list.]

Thanks, fixed.

> >>ACPI S3, right. Machine still wakes up properly when I hit a key on
> >>USB keyboard.
> >
> >OK, so my guess would be a driver issue.  What driver is this, igb?
> >
> >>Does wake on LAN work on you, on any hardware?
> >
> >Yes it does, I checked two machines earlier today, both work.
> >
> >Can you enable dynamic debug in device_pm.c and send a dmesg output
> >with that covering a suspend-resume cycle?
> 
> 82579 is e1000e

Thanks for all the help.

I now realized what was going on: I had badly inserted ethernet
cable; machine just connected to wifi, and everything worked... except
wake on LAN.

Sorry for the noise,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170809/458e2143/attachment.asc>
