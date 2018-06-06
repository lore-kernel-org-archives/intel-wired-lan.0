From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:44:54 +0000
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Fix setting of TC
 configuration for macvlan case
In-Reply-To: <20180604150647.74618.23221.stgit@ahduyck-green-test.jf.intel.com>
References: <20180604150647.74618.23221.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C634F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, June 4, 2018 8:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Fix setting of TC
> configuration for macvlan case
> 
> When we were enabling macvlan interfaces we weren't correctly configuring
> things until ixgbe_setup_tc was called a second time either by tweaking the
> number of queues or increasing the macvlan count past 15.
> 
> The issue came down to the fact that num_rx_pools is not populated until
> after the queues and interrupts are reinitialized.
> 
> Instead of trying to set it sooner we can just move the call to setup at least 1
> traffic class to the SR-IOV/VMDq setup function so that we just set it for this
> one case. We already had a spot that was configuring the queues for TC 0 in
> the code here anyway so it makes sense to also set the number of TCs here
> as well.
> 
> Fixes: 49cfbeb7a95c ("ixgbe: Fix handling of macvlan Tx offload")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    8 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


