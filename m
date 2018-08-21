From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:30:04 +0000
Subject: [Intel-wired-lan] [PATCH v4 10/13] ice: Fix a few null pointer
 dereference issues
In-Reply-To: <20180809132903.22819-11-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-11-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A3B@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 10/13] ice: Fix a few null pointer
> dereference issues
> 
> 1) When ice_ena_msix_range() fails to reserve vectors, a devm_kfree()
>    warning was seen in the error flow path. So check pf->irq_tracker
>    before use in ice_clear_interrupt_scheme().
> 
> 2) In ice_vsi_cfg(), check vsi->netdev before use.
> 
> 3) In ice_get_link_status, check link_up before use.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c   | 17 ++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


