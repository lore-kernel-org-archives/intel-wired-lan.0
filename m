From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Mar 2017 23:41:32 +0000
Subject: [Intel-wired-lan] [next PATCH S65 03/13] i40e: display correct
	udp tunnel type
In-Reply-To: <20170327094759.58321-4-alice.michael@intel.com>
References: <20170327094759.58321-1-alice.michael@intel.com>
 <20170327094759.58321-4-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DE7A9B@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is incorrect. It doesn't contain most of the meat of the code. I think the error messages are fixed in a different way in the current upstream. I can create a separate patch to bring them in line or you can fix this one.

We need to change the code in i40e_sync_udp_filters_subtask so that it doesn't do a hard check against "non-zero udp_ports[i].type" means VXLAN and zero means Geneve.

Thanks,
Jake

> -----Original Message-----
> From: Michael, Alice
> Sent: Monday, March 27, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S65 03/13] i40e: display correct udp tunnel type
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Do not hardcode vxlan into the error message, and instead check to
> determine whether this is a geneve or a vxlan tunnel.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I1a8fcdbdb57f7cb9f3723aba2fff5036165f6dc3
> ---
> Testing-hints:
>   Partially upstream. The exact way of parsing the tunnel type to
>   a string was changed.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 9ce06e8..9e665fa 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7231,6 +7231,11 @@ static void i40e_handle_mdd_event(struct i40e_pf
> *pf)
>  	i40e_flush(hw);
>  }
> 
> +static const char * const tunnel_types[] = {
> +	[UDP_TUNNEL_TYPE_VXLAN] = "vxlan",
> +	[UDP_TUNNEL_TYPE_GENEVE] = "geneve",
> +};
> +
>  /**
>   * i40e_sync_udp_filters_subtask - Sync the VSI filter list with HW
>   * @pf: board private structure
> --
> 2.9.3

