From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:49:49 +0000
Subject: [Intel-wired-lan] [PATCH S22 04/16] ice: Always set prefena
 when configuring an Rx queue
In-Reply-To: <20190626092027.52845-4-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBDE2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Creeley, Brett <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 04/16] ice: Always set prefena when
> configuring an Rx queue
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we are always setting prefena to 0. This is causing the hardware to
> only fetch descriptors when there are none free in the cache for a received
> packet instead of prefetching when it has used the last descriptor regardless
> of incoming packets. Fix this by allowing the hardware to prefetch Rx
> descriptors.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c    | 9 ++++++++-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


