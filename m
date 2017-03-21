From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 21 Mar 2017 00:12:21 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: initialize params before
 notifying of l2_param_changes
In-Reply-To: <20170320234535.27900-1-jacob.e.keller@intel.com>
References: <20170320234535.27900-1-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DB7899@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Monday, March 20, 2017 4:46 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Colin Ian King
> <colin.king@canonical.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH] i40e: initialize params before notifying of l2_param_changes
> 
> Probably due to some mis-merging fix a bug associated with commits
> d7ce6422d6e6 ("i40e: don't check params until after checking for client
> instance", 2017-02-09) and 3140aa9a78c9 ("i40e: KISS the client
> interface", 2017-03-14)
> 
> The first commit tried to move the initialization of the params
> structure so that we didn't bother doing this if we didn't have a client
> interface. You can already see that it looks fishy because of the
> indentation. The second commit refactors a bunch of the interface, and
> incorrectly drops the params initialization.
> 
> I believe what occurred is that internally the two patches were
> re-ordered, and the merge conflicts as a result were performed
> incorrectly.
> 
> Fix the use of an uninitialized variable by correctly initializing the
> params variable via i40e_client_get_params().
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Jeff,

This patch fixes a pretty serious bug with the i40e client interface and probably should be prioritized if possible.

Thanks,
Jake

>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 191580ed946d..725017892f4f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -147,6 +147,8 @@ void i40e_notify_client_of_l2_param_changes(struct
> i40e_vsi *vsi)
>  		dev_dbg(&vsi->back->pdev->dev, "Client is not open, abort l2
> param change\n");
>  		return;
>  	}
> +	memset(&params, 0, sizeof(params));
> +	i40e_client_get_params(vsi, &params);
>  	memcpy(&params, &cdev->lan_info.params, sizeof(struct
> i40e_params));
>  	cdev->client->ops->l2_param_change(&cdev->lan_info, cdev->client,
>  					   &params);
> --
> 2.12.0.rc1.272.g5157a0d593b8

