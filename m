From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 8 Aug 2017 11:00:53 +0200
Subject: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
In-Reply-To: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
Message-ID: <20170808090053.GA3066@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi!

Perhaps you should get regressions at kernel.org alias, or something like that?

> As always: Are you aware of any other regressions? Then please let me
> know. For details see http://bit.ly/lnxregtrackid And please tell me if
> there is anything in the report that shouldn't be there.

I am using wake-on-lan quite a bit, and it stopped working. I'll move
to -rc4 and test there; but if anyone already has some ideas, let me
know.

Hardware is thinkpad X220

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network
Connection (rev 04)

> Ciao, Thorsten
> 
> P.S.: Thx to all those that CCed me on regression reports or provided
> other input, it makes compiling these reports a whole lot easier!
> 
> == Current regressions ==
> 
> [x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
> (2017-07-10)
> http://lkml.kernel.org/r/20170710024020.GA26389 at yexl-desktop
> Status: Asked on the list, but issue still gets ignored by everyone
> Cause: https://git.kernel.org/torvalds/c/e585513b76
> Note: I'm a bit unsure if adding this issue to this list was a good idea.
> 
> Null dereference in rt5677_i2c_probe() (2017-07-17)
> https://bugzilla.kernel.org/show_bug.cgi?id=196397
> Linux-Regression-ID: lr#96bd63
> Status: Patch is available in in asoc-next as commit ddc9e69b9dc2, but
> was not part of the changes to this subsystem that got merged a few days ago
> Cause: https://git.kernel.org/torvalds/c/a36afb0ab6
> Latest: https://bugzilla.kernel.org/show_bug.cgi?id=196397#c6 (2017-07-17)
> 
> [I945GM] Pasted text not shown after mouse middle-click (2017-07-17)
> https://bugs.freedesktop.org/show_bug.cgi?id=101819
> Linux-Regression-ID: lr#d672f3
> Status: could not get reproduced yet
> Note: looks like it's getting ignored
> Latest: https://bugs.freedesktop.org/show_bug.cgi?id=101819#c8 (2017-07-17)
> 
> [Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
> keyboard (2017-07-24)
> https://bugzilla.kernel.org/show_bug.cgi?id=196459
> Linux-Regression-ID: lr#bd29ab
> Status: it's a tracking bug, looks like issue is handled by Intel devs
> already
> Cause: https://git.kernel.org/torvalds/c/33e4f80ee6
> Note: suspend-to-idle is rare
> 
> [lkp-robot] [Btrfs]  28785f70ef: xfstests.generic.273.fail (2017-07-26)
> https://lkml.kernel.org/r/20170726062352.GC4877 at yexl-desktop
> Linux-Regression-ID: lr#a7d273
> Status: Seems it gets ignored by everyone
> Cause: https://git.kernel.org/torvalds/c/28785f70ef
> 
> Xen HVM guest with KASLR enabled wouldn't boot any longer  (2017-07-28)
> https://lkml.kernel.org/r/20170728102314.29100-1-jgross at suse.com
> Status: WIP, patches up for review, but were not part of the changes to
> this subsystem that got merged a few days ago
> 
> bio-integrity: Fix regression if profile verify_fn is NULL (2017-08-02)
> https://lkml.kernel.org/r/20170802122750.12216-1-gmazyland at gmail.com
> Linux-Regression-ID: lr#35498d
> Status: Discussion ongoing how to fix it properly
> Latest: https://lkml.kernel.org/r/yq13795epil.fsf at oracle.com (2017-08-02)
> 
> CIFS mount error -112 (2017-08-06)
> https://bugzilla.kernel.org/show_bug.cgi?id=196599
> Linux-Regression-ID: lr#60efe5
> Status: Brand new
> 
> 
> == Waiting for reporter ==
> 
> NULL pointer deref in networking (2017-07-29)
> https://bugzilla.kernel.org/show_bug.cgi?id=196529
> Linux-Regression-ID: lr#084be9
> Status: maybe reporter lost interest
> 
> SGI UV300/UV300: kernel BUG at arch/x86/mm/init_64.c:350! during boot
> (2017-08-02)
> https://bugzilla.kernel.org/show_bug.cgi?id=196561
> Status: not 100% sure if this is a regression
> Note: related to https://bugzilla.kernel.org/show_bug.cgi?id=196565 ?
> 
> 
> == Fixed since last weeks report ==
> 
> Dell XPS 13 9360: Touchscreen does not report events (2017-07-28)
> https://bugzilla.kernel.org/show_bug.cgi?id=196519
> Linux-Regression-ID: lr#fe68bb
> Status: Fixed in rc3
> 
> 
> == Legend ==
> 
> First few lines -> short summary followed by date and a link to the
>  report that lead to inclusion in this report
> Cause -> commit that causes this regression
> Status -> short start summary written by regression tracker
> Note -> additional note written by regression tracker
> Latest -> most recent and informative point where issue was discussed
> See also -> other places where this issue was or is discussed
> 
> Everything apart from the description and the link to the report is
> optional.
> 
> EOF

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170808/7568c656/attachment.asc>
