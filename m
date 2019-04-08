From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Apr 2019 19:41:50 +0000
Subject: [Intel-wired-lan] [2/2] ixgbe: fix AF_XDP tx packet count.
In-Reply-To: <20190404163655.27662-2-jeffrey.t.kirsher@intel.com>
References: <20190404163655.27662-1-jeffrey.t.kirsher@intel.com>
 <20190404163655.27662-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D389DC6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, April 4, 2019 9:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: William Tu <u9012063@gmail.com>
> Subject: [Intel-wired-lan] [2/2] ixgbe: fix AF_XDP tx packet count.
> 
> From: William Tu <u9012063@gmail.com>
> 
> The total_packets count at ixgbe_clean_xdp_tx_irq is always zero when
> testing with xdpsock -t -N. Set the gso_segs to 1 to make the tx packet count
> correct.
> 
> Signed-off-by: William Tu <u9012063@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


