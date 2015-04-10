From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:07:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] ixgbe: Add the
 appropriate ethtool ops to query RSS indirection table and key
In-Reply-To: <1427758652.2497.101.camel@jtkirshe-mobl>
References: <1427739538-1038-1-git-send-email-vladz@cloudius-systems.com>
 <1427739538-1038-3-git-send-email-vladz@cloudius-systems.com>
 <1427758652.2497.101.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F812F93@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, March 30, 2015 4:38 PM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/2] ixgbe: Add the
> appropriate ethtool ops to query RSS indirection table and key
> 
> On Mon, 2015-03-30 at 21:18 +0300, Vlad Zolotarov wrote:
> > Added get_rxfh_indir_size, get_rxfh_key_size and get_rxfh ethtool_ops
> > callbacks implementations.
> >
> > This enables the ethtool's "-x" and "--show-rxfh[-indir]" options.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 42
> > ++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
> >  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> Thanks Vlad, I have added your patch to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
