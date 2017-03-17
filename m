From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 17 Mar 2017 08:57:54 -0700
Subject: [Intel-wired-lan] [next PATCH S63 5/6] i40e/i40evf: Add
 legacy-rx private flag to allow fallback to old Rx flow
In-Reply-To: <1489511727-10959-5-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <CAKgT0UcRcspygmMMK68ZyDouVCu5tBmAd496vuUyYku3xb9jvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 14, 2017 at 10:15 AM, Bimmy Pujari <bimmy.pujari@intel.com> wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> This patch adds a control which will allow us to toggle into and out of the
> legacy Rx mode.  The legacy Rx mode is what we currently do when performing
> Rx.  As I make further changes what should happen is that the driver will
> fall back to the behavior for Rx as of this patch should the "legacy-rx"
> flag be set to on.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I0342998849bbb31351cce05f6e182c99174e7751
> ---
> Testing Hints:
>         This flag should not appear on kernels prior to 4.10.
>         On kernels 4.10 and later the "legacy-rx" flag should appear
>         and can be toggled between on and off. As we add more features the
>         behavior of the driver should change when this value is toggled.
>
>         Toggling this for now will only cause a reset of the interface.
>
>         For the VF we are specifically replacing the define that was
>         stripping the code for the flag needed for the "legacy-rx" flag
>         since it doesn't make sense to have the interface defined when
>         there are no flags present.  In the case of a kernel build the
>         #ifdefs should be stripped and the code will remain.
>
>  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   5 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 104 +++++++++++++++++++++
>  4 files changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index dcba258..561fe1f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -430,6 +430,7 @@ struct i40e_pf {
>  #define I40E_FLAG_TEMP_LINK_POLLING            BIT_ULL(55)
>  #define I40E_FLAG_CLIENT_L2_CHANGE             BIT_ULL(56)
>  #define I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE                BIT_ULL(57)
> +#define I40E_FLAG_LEGACY_RX                    BIT_ULL(57)

It looks like we lost sync between upstream and out-of-tree at some
point.  We are defining both of these using the same bit.  We need to
use a different value for the LEGACY_RX bit in the upstream it looks
like.
