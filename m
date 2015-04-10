From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:11:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v11 3/7] ixgbe: Add a RETA
 query command to VF-PF channel API
In-Reply-To: <1427877181.2662.21.camel@jtkirshe-mobl>
References: <1427876694-19821-1-git-send-email-vladz@cloudius-systems.com>
 <1427877181.2662.21.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F812FBB@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, April 01, 2015 1:33 AM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v11 3/7] ixgbe: Add a RETA query
> command to VF-PF channel API
> 
> On Wed, 2015-04-01 at 11:24 +0300, Vlad Zolotarov wrote:
> > Add this new command for 82599 and x540 devices only. Support for
> > other devices will be added later.
> >
> > 82599 and x540 VFs and PF share the same RSS redirection table (RETA).
> > Therefore we
> > just return it for all VFs.
> >
> > For 82599 and x540 RETA table is an array of 32 registers (128 bytes)
> > and the maximum number of registers that may be delivered in a single
> > VF-PF channel command is 15. On the other hand VFs of these devices
> > can be configured to have up to 4 RSS queues.
> > Therefore we will "compress"
> > the RETA by transfering only 2 bits per entry and thereby it will take
> > only 8 registers (DWORDS) to transfer the whole VF RETA.
> >
> > Thus this patch does the following:
> >
> >   - Adds a new API version (to specify a new commands set).
> >   - Adds the IXGBE_VF_GET_RETA command to the VF-PF commands set.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> > New in v11:
> >    - Updated the patch description.
> >
> > New in v10:
> >    - Drop the PRSTYPE reading since it's VF that finally modifies it
> > (via VFPSRTYPE)
> >      and we will add the proper masking at the VF driver level.
> >    - Return more self-explaining values.
> >
> > New in v9:
> >    - Reduce the support to 82599 and x540 devices only.
> >    - Improvements in query RETA VF-PF command implementation:
> >       - Use the cached RETA contents.
> >       - Compress the mailbox message.
> >
> > New in v5:
> >    - Use the newly added netdev op to allow/prevent the RETA query on
> > a per-VF basis.
> >
> > New in v4:
> >    - Deleted an empty line in ixgbe_get_vf_reta() switch-case.
> >
> > New in v3:
> >    - Pass the number of dwords and offset in RETA in the
> > IXGBE_VF_GET_RETA request message.
> >      This allows to reduce the added command set to a single command.
> >    - Added a support for all devices supported by the ixgbe driver
> > that have
> >      SR-IOV functions support: 82599, x540 and x550. The original code
> > supported
> >      only 82599 and x540.
> >    - Added the masking of the RETA entries according to the
> > PSRTYPE[n].RQPL
> >      value.
> >
> > New in v1 (compared to RFC):
> >    - Use "if-else" statement instead of a "switch-case" for a single
> > option case
> >      (in ixgbe_get_vf_reta()).
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  4 +++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 35
> > ++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> 
> Thanks Vlad, applied to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
