From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 21 Aug 2018 09:27:52 -0700
Subject: [Intel-wired-lan] [next PATCH S95 01/12] i40e: Fix VF's link
 state notification
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <c74c8ae1-bdef-c5d1-ce66-715919409ba2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/20/2018 8:12 AM, Alice Michael wrote:
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> This patch moves saving old link status information after the call to
> i40e_get_link_status(). Mentioned function updates both old and the new
> link info, so reading it before results in not notifying VF about the
> PF link state change.

I see that this is removing one instance of saving the current status, 
not moving it to somewhere else.  I see that i40e_aq_get_link_info() is 
also doing the save, not i40e_get_link_status().  I don't see how this 
affects VF notification.  Can you clean up this description and 
elaborate on how the VF notification is involved?

> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 456c917..969fb93 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8446,14 +8446,9 @@ static void i40e_link_event(struct i40e_pf *pf)
>   	i40e_status status;
>   	bool new_link, old_link;
>   
> -	/* save off old link status information */
> -	pf->hw.phy.link_info_old = pf->hw.phy.link_info;
> -
>   	/* set this to force the get_link_status call to refresh state */
>   	pf->hw.phy.get_link_info = true;
> -
>   	old_link = (pf->hw.phy.link_info_old.link_info & I40E_AQ_LINK_UP);

Since link_info_old has not been refreshed yet by 
i40e_aq_get_link_info(), are you sure you are getting the old_link 
status that you want?

sln

> -
>   	status = i40e_get_link_status(&pf->hw, &new_link);
>   
>   	/* On success, disable temp link polling */
> 
