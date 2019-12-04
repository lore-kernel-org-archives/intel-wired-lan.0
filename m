From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Dec 2019 18:25:53 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix calculation of queue with
 VFs and flow director on interface flap
In-Reply-To: <20191127090355.27708-1-cambda@linux.alibaba.com>
References: <20191127090355.27708-1-cambda@linux.alibaba.com>
Message-ID: <da48f1f5ff794532b951591f5406ca21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Cambda Zhu
> Sent: Wednesday, November 27, 2019 1:04 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Cambda Zhu <cambda@linux.alibaba.com>; Tyl, RadoslawX
> <radoslawx.tyl@intel.com>; netdev at vger.kernel.org; Joseph Qi
> <joseph.qi@linux.alibaba.com>; intel-wired-lan at lists.osuosl.org; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix calculation of queue with VFs
> and flow director on interface flap
> 
> This patch fixes the calculation of queue when we restore flow director filters
> after resetting adapter. In ixgbe_fdir_filter_restore(), filter's vf may be zero
> which makes the queue outside of the rx_ring array.
> 
> The calculation is changed to the same as ixgbe_add_ethtool_fdir_entry().
> 
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37
> +++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


