From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:12:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 2/7] ixgbe: Add a new
 netdev op to allow/prevent a VF from querying an RSS info
In-Reply-To: <1427787311.2497.110.camel@jtkirshe-mobl>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-3-git-send-email-vladz@cloudius-systems.com>
 <1427787311.2497.110.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F813039@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, March 31, 2015 12:35 AM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v10 2/7] ixgbe: Add a new netdev
> op to allow/prevent a VF from querying an RSS info
> 
> On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> > Implements the new netdev op to allow user to enable/disable the
> > ability of a specific VF to query its RSS Indirection Table and an RSS
> > Hash Key.
> >
> > This patch limits the new feature support to 82599 and x540 devices
> > only.
> > Support for other devices will be added later.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> > New in v10:
> >    - United the for-each-VF loops in __ixgbe_enable_sriov() and
> >      ixgbe_configure_virtualization().
> >    - Use the EOPNOTSUPP error code instead of EPERM when operation is
> >      not supported.
> >
> > New in v9:
> >    - Reduce the support to 82599 and x540 devices only.
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  1 +
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 ++++
> > drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 34
> > ++++++++++++++++++++++++--
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  2 ++
> >  4 files changed, 40 insertions(+), 2 deletions(-)
> 
> Thanks Vlad, applied to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
