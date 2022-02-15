From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 15 Feb 2022 13:08:50 +0100
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix interface init with
 MSI interrupts (no MSI-X)
In-Reply-To: <20220215133551.330076-1-michal.maloszewski@intel.com>
References: <20220215133551.330076-1-michal.maloszewski@intel.com>
Message-ID: <461aa065-347b-ef84-053a-00708f621d3a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Michal,


Am 15.02.22 um 14:35 schrieb Michal Maloszewski:


Just a note, that the time is from the future again. (Some Intel 
employee told me, the Intel firewall (in Poland offices?) blocks NTP, 
and you have to configure an internal NTP server, which should now also 
be documented your intranet.)

> Fix the inability to bring an interface up on a setup with
> only MSI interrupts enabled (no MSI-X).

Is there an error logged?

> Solution is to add a default number of QPs = 1. This is enough,
> since without MSI-X support driver enables only a basic feature set.

Please reflow for 75 characters per line (and maybe add a blank line 
between paragraphs).

> Fixes: bc6d33c8d93f ("i40e: Fix the number of queues available to be mapped for use")

Wow, that went into 4.16-rc1. Any idea, why it hasn?t been reported 
until now?

> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 8572993972ef..dfaa56235b60 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1840,6 +1840,9 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
>   			vsi->num_queue_pairs = vsi->req_queue_pairs;
>   		else if (pf->flags & I40E_FLAG_MSIX_ENABLED)
>   			vsi->num_queue_pairs = pf->num_lan_msix;
> +		else
> +			/* We need at least one queue pair for the interface to be usable */
> +			vsi->num_queue_pairs = 1;

Maybe you could rewrite the comment above the if statement (not in this 
diff), and integrate the information about MSI and MSI-X.

>   	}
>   
>   	/* Number of queues per enabled TC */


Kind regards,

Paul
