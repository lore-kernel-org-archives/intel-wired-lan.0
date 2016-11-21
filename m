From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 17:49:22 +0000
Subject: [Intel-wired-lan] [next PATCH S54 03/15] i40e:
	refactor	i40e_update_filter_state to avoid passing aq_err
In-Reply-To: <1478896779-13697-4-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA383B3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 03/15] i40e: refactor
> i40e_update_filter_state to avoid passing aq_err
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The current caller of i40e_update_filter_state incorrectly passes aq_ret, an
> i40e_status variable, instead of the expected aq_err. This happens to work
> because i40e_status is actually just a typedef integer, and 0 is still the
> successful return. However i40e_update_filter_state has special handling for
> ENOSPC which is currently being ignored.
> 
> Also notice that firmware does not update the per-filter response for many
> types of errors, such as EINVAL. Thus, modify the filter setup so that the
> firmware response memory is pre-set with I40E_AQC_MM_ERR_NO_RES.
> 
> This enables us to refactor i40e_update_filter_state, removing the need to
> pass aq_err and avoiding a need for having 3 different flows for checking the
> filter state.
> 
> The resulting code for i40e_update_filter_state is much simpler, only a single
> loop and we always check each filter response value every time.
> Since we pre-set the response value to match our expected error this
> correctly works for all success and error flows.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ie292c9511f34ee18c6ef40f955ad13e28b7aea7d
> ---
> Testing-hints:
>   This shouldn't have any visible side effects, but it may help detect
>   some errors from firmware more accurately. Ensure that adding and
>   deleting many MAC/VLAN filters works as expected without issue and
>   that the added filters function correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++---------------
> ---
>  1 file changed, 21 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


