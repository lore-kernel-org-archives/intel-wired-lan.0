From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:12:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 4/7] ixgbevf: Add a
	RETA	query code
In-Reply-To: <1427787344.2497.112.camel@jtkirshe-mobl>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-5-git-send-email-vladz@cloudius-systems.com>
 <1427787344.2497.112.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F81301E@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, March 31, 2015 12:36 AM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v10 4/7] ixgbevf: Add a RETA
> query code
> 
> On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> > We will currently support only 82599 and x540 deviced. Support for
> > other devices will be added later.
> >
> >    - Added a new API version support.
> >    - Added the query implementation in the ixgbevf.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> > New in v10:
> >    - Expose the _locked function in the vf.h interface according
> >      to the current ixgbevf layering model.
> >    - Return EOPNOTSUPP in cases then operation is not supported.
> >    - Mask the received RETA according to the VF Rx queues
> > configuration.
> >    - Added IXGBEVF_82599_RETA_SIZE macro.
> >
> > New in v9:
> >    - Reduce the support to 82599 and x540 devices only.
> >    - Improvements in RETA query code:
> >       - Implement a "compression" of VF's RETA contents: pass only 2
> > bits
> >         per-entry.
> >       - RETA querying is done in a single mailbox operation thanks to
> > compression.
> >
> > New in v8:
> >    - Protect mailbox with a spinlock.
> >
> > New in v7:
> >    - Add ixgbe_mbox_api_12 case in ixgbevf_set_num_queues().
> >    - Properly expand HW RETA into the ethtool buffer.
> >
> > New in v6:
> >    - Add a proper return code when an operation is blocked by PF.
> >
> > New in v3:
> >    - Adjusted to the new interface IXGBE_VF_GET_RETA command.
> >    - Added a proper support for x550 devices.
> >
> > New in v1 (compared to RFC):
> >    - Use "if-else" statement instead of a "switch-case" for a single
> > option case
> >      (in ixgbevf_get_reta()).
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  1 +
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  5 +-
> >  drivers/net/ethernet/intel/ixgbevf/mbx.h          |  4 ++
> >  drivers/net/ethernet/intel/ixgbevf/vf.c           | 70
> > +++++++++++++++++++++++
> >  drivers/net/ethernet/intel/ixgbevf/vf.h           |  1 +
> >  5 files changed, 80 insertions(+), 1 deletion(-)
> 
> Thanks Vlad, applied to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
