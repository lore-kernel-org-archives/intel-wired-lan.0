From: Shannon Nelson <snelson@pensando.io>
Date: Tue, 13 Jul 2021 08:16:48 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix error handling code of
 label err_set_queues
In-Reply-To: <20210713122028.463450-1-mudongliangabcd@gmail.com>
References: <20210713122028.463450-1-mudongliangabcd@gmail.com>
Message-ID: <58d854d9-a371-7689-d396-de1c26b34bfa@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/13/21 5:20 AM, Dongliang Mu wrote:
> If i40e_up_complete fails in i40e_vsi_open, it goes to err_up_complete.
> The label err_set_queues has an issue: if the else branch is executed,
> there is no need to execute i40e_vsi_request_irq.

This is unnecessary: if the else branch is executed then control will 
goto err_setup_rx, skipping over i40e_up_complete().

sln

>
> Fix this by adding a condition of i40e_vsi_free_irq.
>
> Reported-by: Dongliang Mu (mudongliangabcd at gmail.com)
> Fixes: 9c04cfcd4aad ("i40e: Fix error handling in i40e_vsi_open")
> Fixes: c22e3c6c7912 ("i40e: prep vsi_open logic for non-netdev cases")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 861e59a350bd..ae54468c7001 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8720,7 +8720,8 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
>   err_up_complete:
>   	i40e_down(vsi);
>   err_set_queues:
> -	i40e_vsi_free_irq(vsi);
> +	if ((vsi->netdev) || (vsi->type == I40E_VSI_FDIR))
> +		i40e_vsi_free_irq(vsi);
>   err_setup_rx:
>   	i40e_vsi_free_rx_resources(vsi);
>   err_setup_tx:

