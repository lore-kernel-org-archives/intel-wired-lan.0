From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 22:11:55 +0000
Subject: [Intel-wired-lan] [next-queue v2 1/4] ixgbe: no need for ipsec
 csum feature check
In-Reply-To: <1521223747-12018-2-git-send-email-shannon.nelson@oracle.com>
References: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
 <1521223747-12018-2-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CD44@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Friday, March 16, 2018 11:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue v2 1/4] ixgbe: no need for ipsec csum
> feature check
> 
> With the patch
> commit f8aa2696b4af ("esp: check the NETIF_F_HW_ESP_TX_CSUM bit
> before segmenting") we no longer need to protect ourself from checksum
> offload requests on IPsec packets, so we can remove the check in our
> .ndo_features_check callback.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


