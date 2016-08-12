From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Aug 2016 22:46:27 +0000
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Re-enable ability to
 toggle	VLAN filtering
In-Reply-To: <147102081932.18173.913316945879981638.stgit@ahduyck-desk.amr.corp.intel.com>
References: <147102081932.18173.913316945879981638.stgit@ahduyck-desk.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8B89@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, August 12, 2016 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] ixgbe: Re-enable ability to toggle
> VLAN filtering
> 
> Back when I submitted the GSO code I messed up and dropped the support
> for disabling the VLAN tag filtering via the feature bit.  This patch re-enables
> the use of the NETIF_F_HW_VLAN_CTAG_FILTER to enable/disable the
> VLAN filtering independent of toggling promiscuous mode.
> 
> Fixes: b83e30104b ("ixgbe/ixgbevf: Add support for GSO partial")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


