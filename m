From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:30:15 +0000
Subject: [Intel-wired-lan] [PATCH S16 07/11] ice: Add priority
 information into VLAN header
In-Reply-To: <20190228232432.31659-8-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B4F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 07/11] ice: Add priority information into
> VLAN header
> 
> This patch introduces a new function ice_tx_prepare_vlan_flags_dcb to
> insert 802.1p priority information into the VLAN header
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 39
> ++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h | 10 +++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c    |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  2 ++
>  4 files changed, 54 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


