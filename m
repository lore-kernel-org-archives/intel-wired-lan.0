From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 9 Jan 2018 19:48:23 +0000
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: stop adding VLAN 0 to the
 VLAN table
In-Reply-To: <20171201190024.5547-4-jacob.e.keller@intel.com>
References: <20171201190024.5547-1-jacob.e.keller@intel.com>
 <20171201190024.5547-4-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B421B2@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: stop adding VLAN 0 to the VLAN
> table
> 
> Currently, when the driver loads, it sends a request to add VLAN 0 to the
> VLAN table. For the PF, this is honored, and VLAN 0 is indeed set. For
> the VF, this request is silently converted into a request for the
> default VLAN as defined by either the switch vid or the PF vid.
> 
> This results in the odd behavior that the VLAN table doesn't appear
> consistent between the PF and the VF.
> 
> Furthermore, setting a MAC filter with VLAN 0 is generally considered an
> invalid configuration by the switch, and since commit 856dfd69e84f
> ("fm10k: Fix multicast mode synch issues", 2016-03-03) we've had code
> which prevents us from ever sending such a request.
> 
> Since there's not really a good reason to keep VLAN 0 in the VLAN table,
> stop requesting it in fm10k_restore_rx_state().
> 
> This might seem to indicate that we would no longer properly configure
> the MAC and VLAN tables for the default vid. However, due to the way
> that fm10k_find_next_vlan() behaves, it will always return the
> default_vid as enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> index f8e2d1804a17..d79bff7c23f7 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
> @@ -1221,9 +1221,6 @@ void fm10k_restore_rx_state(struct fm10k_intfc
> *interface)
>  	fm10k_queue_vlan_request(interface, FM10K_VLAN_ALL, 0,
>  				 xcast_mode ==
> FM10K_XCAST_MODE_PROMISC);
> 
> -	/* Add filter for VLAN 0 */
> -	fm10k_queue_vlan_request(interface, 0, 0, true);
> -
>  	/* update table with current entries */
>  	for (vid = hw->mac.default_vid ? fm10k_find_next_vlan(interface, 0) :
> 1;
>  	     vid < VLAN_N_VID;
> --
> 2.15.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

