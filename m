From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 9 Jun 2021 18:23:29 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix for failed to init
 adminq while VF reset and for sync VF driver reset
In-Reply-To: <20210609105101.88005-1-karen.sornek@intel.com>
References: <20210609105101.88005-1-karen.sornek@intel.com>
Message-ID: <9afe652dbf360187d1a6c498cbe3291aeeabe0ab.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-06-09 at 12:51 +0200, Karen Sornek wrote:
> Fix for failed to init adminq: -53 while VF is resetting via MAC
> address changing procedure.
> Added sync module to avoid reading deadbeef value in reinit adminq
> during software reset.
> Fix for sync VF driver reset before trigger next one by PF.
> Change VF in reset state detection from check VFR state
> register to examination of enable admin queue interrupt.
> ADMINQ is enabled by VF after completely reinit admin queue.
> 
> Fixes: b40c82e6ae85 ("i40e: Fix inconsistent use of PF/VF vs pf/vf")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_register.h   | 10 +++++
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 45
> ++++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h
> b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index 8d0588a27..b5c741e76 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -371,6 +371,16 @@
>  #define I40E_PFINT_ICR0_ENA_VFLR_MASK I40E_MASK(0x1,
> I40E_PFINT_ICR0_ENA_VFLR_SHIFT)
>  #define I40E_PFINT_ICR0_ENA_ADMINQ_SHIFT 30
>  #define I40E_PFINT_ICR0_ENA_ADMINQ_MASK I40E_MASK(0x1,
> I40E_PFINT_ICR0_ENA_ADMINQ_SHIFT)
> +#define I40E_VFINT_ICR0_ADMINQ_SHIFT 30
> +#define I40E_VFINT_ICR0_ADMINQ_MASK I40E_MASK(0x1,
> I40E_VFINT_ICR0_ADMINQ_SHIFT)
> +#define I40E_VFINT_ICR0_ENA(_VF) (0x0002C000 + ((_VF) * 4)) /*
> _i=0...127 */ /* Reset: CORER */
> +#define I40E_VFINT_ICR0_ENA_MAX_INDEX 127
> +#define I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_SHIFT 25
> +#define I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_MASK I40E_MASK(0x1,
> I40E_VFINT_ICR0_ENA_LINK_STAT_CHANGE_SHIFT)
> +#define I40E_VFINT_ICR0_ENA_ADMINQ_SHIFT 30
> +#define I40E_VFINT_ICR0_ENA_ADMINQ_MASK I40E_MASK(0x1,
> I40E_VFINT_ICR0_ENA_ADMINQ_SHIFT)
> +#define I40E_VFINT_ICR0_ENA_RSVD_SHIFT 31
> +#define I40E_VFINT_ICR0_ENA_RSVD_MASK I40E_MASK(0x1,
> I40E_VFINT_ICR0_ENA_RSVD_SHIFT)

I don't see that all the new defines are being used. Can you remove the
unused ones?
