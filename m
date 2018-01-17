From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Jan 2018 20:04:39 +0000
Subject: [Intel-wired-lan] [net-queue PATCH] i40e/i40evf: Update
 DESC_NEEDED value to reflect larger value
In-Reply-To: <20180116192719.11191.21193.stgit@ahduyck-green-test.jf.intel.com>
References: <20180116192719.11191.21193.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A92C6A9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 16, 2018 11:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-queue PATCH] i40e/i40evf: Update
> DESC_NEEDED value to reflect larger value
> 
> When compared to ixgbe and other previous Intel drivers the i40e and i40evf
> drivers actually reserve 2 additional descriptors in maybe_stop_tx for cache
> line alignment. We need to update DESC_NEEDED to reflect this as otherwise
> we are more likely to return TX_BUSY which will cause issues with things like
> xmit_more.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


