From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Wed, 11 Nov 2015 00:24:50 +0000
Subject: [Intel-wired-lan] [next PATCH S21 10/14] i40e:
	remove	CONFIG_I40E_VXLAN
In-Reply-To: <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
Message-ID: <C40BE8378EF49C44B9184714DBC8EF2992FC9D11@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Please revert this patch, since it breaks the build when I40E is in built in the kernel and VXLAN is a module due to the fact the vxlan_get_rx_port is not defined.


The GENEVE/VXLAN patch series takes care of this issue by generalizing the call to udp_offload_get_port which is always defiend.

Anjali

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 10/14] i40e: remove
> CONFIG_I40E_VXLAN
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Instead of having our own custom symbol, we can just rely on whether or
> not the kernel has the feature enabled.
> 
> In this case use IS_ENABLED(CONFIG_VXLAN) in order to handle built-in or
> module in the current BKM way.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I5890fbb518ff8ed6bb07c3362fb0a8a829f9b241
> ---
>  drivers/net/ethernet/intel/Kconfig          | 11 -----------
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 +---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
>  3 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index 4163b16..061e4e0 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -269,17 +269,6 @@ config I40E
>  	  To compile this driver as a module, choose M here. The module
>  	  will be called i40e.
> 
> -config I40E_VXLAN
> -	bool "Virtual eXtensible Local Area Network Support"
> -	default n
> -	depends on I40E && VXLAN && !(I40E=y && VXLAN=m)
> -	---help---
> -	  This allows one to create VXLAN virtual interfaces that provide
> -	  Layer 2 Networks over Layer 3 Networks. VXLAN is often used
> -	  to tunnel virtual network infrastructure in virtualized environments.
> -	  Say Y here if you want to use Virtual eXtensible Local Area Network
> -	  (VXLAN) in the driver.
> -
>  config I40E_DCB
>  	bool "Data Center Bridging (DCB) Support"
>  	default n
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 050fc0f..adfc450 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -282,7 +282,7 @@ struct i40e_pf {
>  	u32 fd_atr_cnt;
>  	u32 fd_tcp_rule;
> 
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
>  	u16 pending_vxlan_bitmap;
> 
> @@ -323,9 +323,7 @@ struct i40e_pf {
>  #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
>  #define I40E_FLAG_PTP				BIT_ULL(25)
>  #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
> -#ifdef CONFIG_I40E_VXLAN
>  #define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
> -#endif
>  #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
>  #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
>  #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index c6d4da4..4db7966 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -27,7 +27,7 @@
>  /* Local includes */
>  #include "i40e.h"
>  #include "i40e_diag.h"
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  #include <net/vxlan.h>
>  #endif
> 
> @@ -5357,7 +5357,7 @@ int i40e_open(struct net_device *netdev)
>  						       TCP_FLAG_CWR) >> 16);
>  	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L,
> be32_to_cpu(TCP_FLAG_CWR) >> 16);
> 
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  	vxlan_get_rx_port(netdev);
>  #endif
> 
> @@ -7053,7 +7053,7 @@ static void i40e_handle_mdd_event(struct i40e_pf
> *pf)
>  	i40e_flush(hw);
>  }
> 
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  /**
>   * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list with HW
>   * @pf: board private structure
> @@ -7120,7 +7120,7 @@ static void i40e_service_task(struct work_struct
> *work)
>  	i40e_watchdog_subtask(pf);
>  	i40e_fdir_reinit_subtask(pf);
>  	i40e_sync_filters_subtask(pf);
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  	i40e_sync_vxlan_filters_subtask(pf);
>  #endif
>  	i40e_clean_adminq_subtask(pf);
> @@ -8496,7 +8496,7 @@ static int i40e_set_features(struct net_device
> *netdev,
>  	return 0;
>  }
> 
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  /**
>   * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx UDP port
>   * @pf: board private structure
> @@ -8816,7 +8816,7 @@ static const struct net_device_ops
> i40e_netdev_ops = {
>  	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
>  	.ndo_set_vf_link_state	= i40e_ndo_set_vf_link_state,
>  	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
> -#ifdef CONFIG_I40E_VXLAN
> +#if IS_ENABLED(CONFIG_VXLAN)
>  	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
>  	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
>  #endif
> --
> 2.1.0
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
