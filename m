From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Mar 2019 22:38:13 +0000
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix a missing check of
 ixgbevf_write_msg_read_ack
In-Reply-To: <20190309033123.30001-1-kjlu@umn.edu>
References: <20190309033123.30001-1-kjlu@umn.edu>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D376ADC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kangjie Lu
> Sent: Friday, March 8, 2019 7:31 PM
> To: kjlu at umn.edu
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; pakki001 at umn.edu; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: fix a missing check of
> ixgbevf_write_msg_read_ack
> 
> If ixgbevf_write_msg_read_ack fails, return its error code upstream
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


