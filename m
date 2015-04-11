From: Vladislav Zolotarov <vladz@cloudius-systems.com>
Date: Sat, 11 Apr 2015 09:33:07 +0300
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: Refactor the
 RSS configuration code.
In-Reply-To: <305E19FFAC908240AB6DEBD1E2D8C1E17F812F69@ORSMSX108.amr.corp.intel.com>
References: <1427739538-1038-1-git-send-email-vladz@cloudius-systems.com>
 <1427739538-1038-2-git-send-email-vladz@cloudius-systems.com>
 <1427758606.2497.100.camel@jtkirshe-mobl>
 <305E19FFAC908240AB6DEBD1E2D8C1E17F812F69@ORSMSX108.amr.corp.intel.com>
Message-ID: <CAOYyTHZHVdOUjDZRxrCGjH61VBkBQfZz_5aTM1cj=FpO2-x4Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Apr 11, 2015 2:07 AM, "Schmitt, Phillip J" <phillip.j.schmitt@intel.com>
wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
On
> > Behalf Of Jeff Kirsher
> > Sent: Monday, March 30, 2015 4:37 PM
> > To: Vlad Zolotarov
> > Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> > lan at lists.osuosl.org; gleb at cloudius-systems.com
> > Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: Refactor
the RSS
> > configuration code.
> >
> > On Mon, 2015-03-30 at 21:18 +0300, Vlad Zolotarov wrote:
> > > This patch is a preparation for enablement of ethtool RSS indirection
> > > table and hash key querying. We don't want to read registers every
> > > time the RSS info is queried. Therefore we will store its current
> > > content in the arrays in the adapter struct and will read it from
> > > there (instead of from
> > > registers) when requested.
> > >
> > > Will change the code that writes the indirection table and hash key
> > > into the HW registers to take its content from these arrays. This will
> > > also simplify the indirection table updating ethtool callback
> > > implementation in the future.
> > >
> > > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > > ---
> > > New in v3:
> > >    - Fix the byte ordering in RETA storing.
> > >
> > > New in v2:
> > >    - Some styling fixes.
> > >    - Moved macros definitions from ixgbe_type.h to ixgbe.h.
> > > ---
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   9 ++
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 147
> > > ++++++++++++++++++--------
> > >  2 files changed, 112 insertions(+), 44 deletions(-)
> >
> > Thanks Vlad, I have added your patch to my queue.
> > --
> > git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> > dev-queue
>
> Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

Thanks a lot, Phil for testing them all!

Vlad
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150411/df449e3e/attachment.html>
