From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:35:25 +0000
Subject: [Intel-wired-lan] [PATCH S12 12/14] ice: Determine descriptor
 count and ring size based on PAGE_SIZE
In-Reply-To: <20190208205101.12078-13-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367063@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 12/14] ice: Determine descriptor count
> and ring size based on PAGE_SIZE
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we set the default number of Tx and Rx descriptors to 128 by
> default. For Rx this amounts to a full page (assuming 4K pages) because each
> Rx descriptor is 32 Bytes, but for Tx it only amounts to a half page because
> each Tx descriptor is 16 Bytes (assuming 4K pages).
> Instead of assuming 4K pages, determine the ring size and the number of
> descriptors for Tx and Rx based on a calculation using the PAGE_SIZE,
> ICE_MAX_NUM_DESC, and ICE_REQ_DESC_MULTIPLE. This change is being
> made to improve the performance of the driver when using the default
> settings.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 16 ++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 28
> ++++++++++++++++++++++++----  drivers/net/ethernet/intel/ice/ice_txrx.c
> | 10 +++++-----
>  3 files changed, 43 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


