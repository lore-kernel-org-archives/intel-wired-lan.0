From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 21:56:55 +0000
Subject: [Intel-wired-lan] i40e: fix handling of HW ATR eviction
In-Reply-To: <20170612215118.17642-1-jeffrey.t.kirsher@intel.com>
References: <20170612215118.17642-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAC07@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, June 12, 2017 2:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] i40e: fix handling of HW ATR eviction
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A recent commit to refactor the driver and remove the hw_disabled_flags
> field accidentally introduced two regressions. First, we overwrote
> pf->flags which removed various key flags including the MSI-X settings.
> 
> Additionally, it was intended that we have now two flags,
> HW_ATR_EVICT_CAPABLe and HW_ATR_EVICT_ENABLED, but this was not
> done, and we accidentally were mis-using HW_ATR_EVICT_CAPABLE
> everywhere.
> 
> This patch adds the missing piece, HW_ATR_EVICT_ENABLED, and safely
> updates pf->flags instead of overwriting it.
> 
> Without this patch we will have many problems including disabling MSI-X
> support, and we'll attempt to use HW ATR eviction on devices which do not
> support it.
> 
> Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of using
> separate flag bits", 2017-04-19)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |    4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |    7 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |    4 ++--
>  4 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


