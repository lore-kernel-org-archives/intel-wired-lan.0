From: Stefan Dietrich <roots@gmx.de>
Date: Thu, 25 Nov 2021 09:41:56 +0100
Subject: [Intel-wired-lan] [REGRESSION] Kernel 5.15 reboots / freezes
 upon ifup/ifdown
In-Reply-To: <87a6htm4aj.fsf@intel.com>
References: <924175a188159f4e03bd69908a91e606b574139b.camel@gmx.de>
 <YZ3q4OKhU2EPPttE@kroah.com>
 <8119066974f099aa11f08a4dad3653ac0ba32cd6.camel@gmx.de>
 <20211124153449.72c9cfcd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87a6htm4aj.fsf@intel.com>
Message-ID: <227af6b0692a0a57f5fb349d4d9c914301753209.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

thanks - this was spot-on: disabling CONFIG_PCIE_PTM resolves the issue
for latest 5.15.4 (stable from git) for both manual and network-manager
NIC configuration.

Let me know if I may assist in debugging this further.


Cheers,
Stefan


On Wed, 2021-11-24 at 17:07 -0800, Vinicius Costa Gomes wrote:
> Hi Stefan,
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Wed, 24 Nov 2021 18:20:40 +0100 Stefan Dietrich wrote:
> > > Hi all,
> > >
> > > six exciting hours and a lot of learning later, here it is.
> > > Symptomatically, the critical commit appears for me between
> > > 5.14.21-
> > > 051421-generic and 5.15.0-051500rc2-generic - I did not find an
> > > amd64
> > > build for rc1.
> > >
> > > Please see the git-bisect output below and let me know how I may
> > > further assist in debugging!
> >
> > Well, let's CC those involved, shall we? :)
> >
> > Thanks for working thru the bisection!
> >
> > > a90ec84837325df4b9a6798c2cc0df202b5680bd is the first bad commit
> > > commit a90ec84837325df4b9a6798c2cc0df202b5680bd
> > > Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > > Date:   Mon Jul 26 20:36:57 2021 -0700
> > >
> > >     igc: Add support for PTP getcrosststamp()
>
> Oh! That's interesting.
>
> Can you try disabling CONFIG_PCIE_PTM in your kernel config? If it
> works, then it's a point in favor that this commit is indeed the
> problematic one.
>
> I am still trying to think of what could be causing the lockup you
> are
> seeing.
>
>
> Cheers,

