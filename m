From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:58:45 +0000
Subject: [Intel-wired-lan] [PATCH 16/16] ice: Add support for dynamic
 interrupt moderation
In-Reply-To: <20180920002319.10971-17-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-17-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC509@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 16/16] ice: Add support for dynamic
> interrupt moderation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently there is no support for dynamic interrupt moderation. This patch
> adds some initial code to support this. The following changes were made:
> 
> 1. Currently we are using multiple members to store the interrupt
>    granularity (itr_gran_25/50/100/200). This is not necessary because
>    we can query the device to determine what the interrupt granularity
>    should be set to, done by a new function ice_get_itr_intrl_gran.
> 
> 2. Added intrl to ice_q_vector structure to support interrupt rate
>    limiting.
> 
> 3. Added the function ice_intrl_usecs_to_reg for converting to a value
>    in usecs that the device understands.
> 
> 4. Added call to write to the GLINT_RATE register. Disable intrl by
>    default for now.
> 
> 5. Changed rx/tx_itr_setting to itr_setting because having both seems
>    redundant because a ring is either tx or rx.
> 
> 6. Initialize itr_setting for both tx/rx rings in ice_vsi_alloc_rings()
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  4 +++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 41
> ++++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  5 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 29 +++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_main.c       |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h       | 17 ++++++----
>  drivers/net/ethernet/intel/ice/ice_type.h       | 28 +++++++++++------
>  7 files changed, 102 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


