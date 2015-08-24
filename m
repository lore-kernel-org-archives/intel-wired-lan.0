From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Mon, 24 Aug 2015 15:00:50 -0700
Subject: [Intel-wired-lan] [RFC v1 1/4] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1440453891-214878-1-git-send-email-anjali.singhai@intel.com>
References: <1440453891-214878-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <55DB9412.1020507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/24/2015 03:04 PM, Anjali Singhai Jain wrote:
> If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is true,
> enable VXLAN offload in the driver.
>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>   drivers/net/ethernet/intel/Kconfig          | 11 -----------
>   drivers/net/ethernet/intel/i40e/i40e.h      |  4 ----
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++----------
>   3 files changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 4163b16..061e4e0 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -269,17 +269,6 @@ config I40E
>   	  To compile this driver as a module, choose M here. The module
>   	  will be called i40e.
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
>   config I40E_DCB
>   	bool "Data Center Bridging (DCB) Support"
>   	default n
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index c9fa289..257f7d8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -274,11 +274,9 @@ struct i40e_pf {
>   	u32 fd_atr_cnt;
>   	u32 fd_tcp_rule;
>
> -#ifdef CONFIG_I40E_VXLAN
>   	__be16  vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
>   	u16 pending_vxlan_bitmap;
>
> -#endif
>   	enum i40e_interrupt_policy int_policy;
>   	u16 rx_itr_default;
>   	u16 tx_itr_default;
> @@ -316,9 +314,7 @@ struct i40e_pf {
>   #define I40E_FLAG_FD_ATR_ENABLED		BIT_ULL(22)
>   #define I40E_FLAG_PTP				BIT_ULL(25)
>   #define I40E_FLAG_MFP_ENABLED			BIT_ULL(26)
> -#ifdef CONFIG_I40E_VXLAN
>   #define I40E_FLAG_VXLAN_FILTER_SYNC		BIT_ULL(27)
> -#endif
>   #define I40E_FLAG_PORT_ID_VALID			BIT_ULL(28)
>   #define I40E_FLAG_DCB_CAPABLE			BIT_ULL(29)
>   #define I40E_FLAG_RSS_AQ_CAPABLE		BIT_ULL(31)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index aef0a4c..05081d1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -28,7 +28,7 @@
>   #include "i40e.h"
>   #include "i40e_helper.h"
>   #include "i40e_diag.h"
> -#ifdef CONFIG_I40E_VXLAN
> +#if defined(CONFIG_VXLAN) || defined(CONFIG_VXLAN_MODULE)

This should probably just be replaced with:
#if IS_ENABLED(CONFIG_VXLAN)

Same goes for the other spots in this patch as well.

- Alex
