From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Oct 2019 19:06:46 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove duplicate clear_bit()
 call
In-Reply-To: <20191004065357.19138-1-igor.pylypiv@gmail.com>
References: <20191004065357.19138-1-igor.pylypiv@gmail.com>
Message-ID: <0c4651b2f0824c4386f4b8e4c3ec5580@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Igor Pylypiv
> Sent: Thursday, October 3, 2019 11:54 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Igor Pylypiv
> <igor.pylypiv@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove duplicate clear_bit() call
> 
> __IXGBE_RX_BUILD_SKB_ENABLED bit is already cleared.
> 
> Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


