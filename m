From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Mar 2018 18:12:13 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] ixgbevf: Add support for XDP_TX
 action
In-Reply-To: <20180316223406.7295-3-anthony.l.nguyen@intel.com>
References: <20180316223406.7295-1-anthony.l.nguyen@intel.com>
 <20180316223406.7295-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94D26A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, March 16, 2018 3:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 2/5] ixgbevf: Add support for XDP_TX
> action
> 
> This implements the XDP_TX action which is modeled on the ixgbe
> implementation. However instead of using CPU id to determine which XDP
> queue to use, this uses the received RX queue index, which is similar to i40e.
> Doing this eliminates the restriction that number of CPUs not exceed number
> of XDP queues that ixgbe has.
> 
> Also, based on the number of queues available, the number of TX queues
> may be reduced when an XDP program is loaded in order to accommodate
> the XDP queues.
> 
> Based largely on commit 33fdc82f0883 ("ixgbe: add support for XDP_TX
> action")
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  35 ++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  20 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 271
> +++++++++++++++++++---
>  3 files changed, 294 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


