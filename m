From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Mar 2017 19:37:45 +0000
Subject: [Intel-wired-lan] [next-queue v6 PATCH 3/7] i40e: Sync link
 state	between PF/VFs and Port representor netdevs
In-Reply-To: <1490833375-2788-4-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A9F8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, March 29, 2017 5:23 PM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Duyck,
> Alexander H <alexander.h.duyck@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; jakub.kicinski at netronome.com;
> gerlitz.or at gmail.com; jiri at resnulli.us; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Subject: [Intel-wired-lan] [next-queue v6 PATCH 3/7] i40e: Sync link state
> between PF/VFs and Port representor netdevs
> 
> This patch enables
> - reflecting the link state of port netdev based on PF/VF admin state &
>   link state of PF/VF based on admin state of the associated port netdev.
> - bringing up/down the VF port netdev sends a notification to update VF
>   link state.
> - bringing up/down the VF will cause the link state update of VF port
>   netdev.
> - enable/disable VF link state via ndo_set_vf_link_state will update the
>   admin state of associated VF port netdev.
> - bringing up/down the PF port netdev updates the link state of PF based on
>   the hw link info.
> - bringing up/down the PF will update the link state of PF port netdev.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 106
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  21 +++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
>  3 files changed, 122 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
