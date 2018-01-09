From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 9 Jan 2018 19:50:40 +0000
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: clarify action when
 updating the VLAN table
In-Reply-To: <20171201190024.5547-7-jacob.e.keller@intel.com>
References: <20171201190024.5547-1-jacob.e.keller@intel.com>
 <20171201190024.5547-7-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B421EE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Friday, December 1, 2017 11:00 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>; Jacob Keller
> <jacob.e.keller@gmail.com>
> Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: clarify action when updating the
> VLAN table
> 
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> 
> Clarify the comment for when entering promiscuous mode that we update
> the VLAN table. Add a comment distinguishing the case where we're
> exiting promiscuous mode and need to clear the entire VLAN table.
> 
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@gmail.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> index ec91eabbb723..f1cfa1a1586a 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> @@ -1165,10 +1165,12 @@ static void fm10k_set_rx_mode(struct net_device
> *dev)
> 
>  	/* update xcast mode first, but only if it changed */
>  	if (interface->xcast_mode != xcast_mode) {
> -		/* update VLAN table */
> +		/* update VLAN table when entering promiscuous mode */
>  		if (xcast_mode == FM10K_XCAST_MODE_PROMISC)
>  			fm10k_queue_vlan_request(interface,
> FM10K_VLAN_ALL,
>  						 0, true);
> +
> +		/* clear VLAN table when exiting promiscuous mode */
>  		if (interface->xcast_mode == FM10K_XCAST_MODE_PROMISC)
>  			fm10k_clear_unused_vlans(interface);
> 
> --
> 2.15.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

