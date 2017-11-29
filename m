From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:02:43 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 04/16] ixgbe:
 There is no need to update num_rx_pools in L2 fwd offload
In-Reply-To: <20171122185634.29785.72563.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185634.29785.72563.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC53@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 04/16] ixgbe: There is
> no need to update num_rx_pools in L2 fwd offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The num_rx_pools value is overwritten when we reinitialize the queue
> configuration. In reality we shouldn't need to be updating the value since it is
> redone every time we call into ixgbe_setup_tc so for now just drop the spots
> where we were incrementing or decrementing the value.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


