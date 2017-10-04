From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Oct 2017 19:11:47 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] ixgbe:
	Update	adaptive ITR algorithm
In-Reply-To: <20170925215225.15616.63705.stgit@localhost.localdomain>
References: <20170925215225.15616.63705.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EABB0A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, September 25, 2017 2:56 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: brouer at redhat.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] ixgbe: Update
> adaptive ITR algorithm
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The following change is meant to update the adaptive ITR algorithm to better
> support the needs of the network. Specifically with this change what I have
> done is make it so that our ITR algorithm will try to prevent either starving a
> socket buffer for memory in the case of Tx, or overruing an Rx socket buffer
> on receive.
> 
> In addition a side effect of the calculations used is that we should function
> better with new features such as XDP which can handle small packets at high
> rates without needing to lock us into NAPI polling mode.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> So I am putting this out to a wider distribution list than normal for a patch like
> this in order to get feedback on if there are any areas I may have overlooked.
> With this patch is should address many of the performance limitations seen
> with pktgen and XDP in terms of workloads that the old adaptive scheme
> wasn't handling.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    7 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   11 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  215
> +++++++++++++++++++------
>  3 files changed, 178 insertions(+), 55 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


