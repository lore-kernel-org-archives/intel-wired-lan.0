From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Apr 2018 19:03:54 +0000
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix
 ixgbevf_xmit_frame()'s return type
In-Reply-To: <20180424131649.3955-1-luc.vanoostenryck@gmail.com>
References: <20180424131649.3955-1-luc.vanoostenryck@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976C4B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Luc Van Oostenryck
> Sent: Tuesday, April 24, 2018 6:17 AM
> To: linux-kernel at vger.kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Luc Van
> Oostenryck <luc.vanoostenryck@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix ixgbevf_xmit_frame()'s
> return type
> 
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t', which
> is a typedef for an enum type, but the implementation in this driver returns
> an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


