From: Jan Janssen <medhefgo@web.de>
Date: Thu, 12 Dec 2019 14:07:04 +0100
Subject: [Intel-wired-lan] Regression: e1000e link not coming up
In-Reply-To: <96bdb43e-2a7b-028c-c9ed-98e4477f6b7d@intel.com>
References: <3945198.J3aOToa6sv@minako>
 <92b94935dea3b8c7e7236d6f4e1ac148e6cd2ffd.camel@intel.com>
 <96bdb43e-2a7b-028c-c9ed-98e4477f6b7d@intel.com>
Message-ID: <5085570.ijSX0aXlux@minako>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tuesday, 19 November 2019 07:12:18 CET Neftin, Sasha wrote:
> On 11/18/2019 20:29, Jeff Kirsher wrote:
> > On Sat, 2019-11-16 at 12:50 +0100, Jan Janssen wrote:
> >> Hi,
> >>
> >> since 5.3 my I219-V network interface sometimes doesn't come up when
> >> booting
> >> or resuming from suspend. This either forces me to use "ip link
> >> down/up" or
> >> reloading the module to get working internet.
> >>
> >> I reported this issue previously to netdev at vger.kernel.org where I
> >> initially
> >> bisected to a wrong commit. After finding the right one nobody
> >> reacted to it,
> >> so now I am trying this again here.
> >
> > I apologize, this is the correct mailing list for issues with the Intel
> > wired LAN.
> >
> >> There is also a bugzilla entry for this, but it seems to be ignored
> >> by
> >> maintainers too: https://bugzilla.kernel.org/show_bug.cgi?id=205067
> >> For me, this happens with systemd-networkd, but the people in the
> >> bugzilla
> >> report are observing this with NetworkManager.
> >>
> >> The commit introducing the bug is
> >> 59653e6497d16f7ac1d9db088f3959f57ee8c3db
> >> (e1000e: Make watchdog use delayed work) and reverting it did make
> >> this bug go
> >> away. Though, it cannot be reverted automatically on the latest git
> >> tree from
> >> Torvalds anymore.
> >
> > I will work with the e1000e driver lead (Sasha Neftin) to work up a
> > patch that will apply to David Miller's net tree.  I will make sure you
> > are CC'd on the patch, so you will know when it makes it into the
> > upstream kernel.
>
> I heard a lot of peoples complain about a problem with using
> delayed_work struct in e1000e. I would suggest reverting this patch.
>
> >> I've also tried the master branch on jkirsher/net-queue.git  and
> >> jkirsher/next-queue.git, but the bug is still present there too.
> >>
> >> This bug is really annoying and inconvenient, so I would really
> >> appreciate if
> >> somebody could fix this bug or at least have the offending commit
> >> reverted.
> >>
> >> Regards,
> >> Jan

So... when can we expect a patch revert?


