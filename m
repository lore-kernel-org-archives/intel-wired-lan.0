From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 21:54:50 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix ixgbe TX hangs with XDP_TX
 beyond queue limit.
In-Reply-To: <1536130851-34357-1-git-send-email-radoslawx.tyl@intel.com>
References: <1536130851-34357-1-git-send-email-radoslawx.tyl@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE2A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Radoslaw Tyl
> Sent: Wednesday, September 5, 2018 12:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tyl, RadoslawX <radoslawx.tyl@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix ixgbe TX hangs with XDP_TX
> beyond queue limit.
> 
> We have Tx hang when number tx and xdp queues are more than 64.
> In XDP always is MTQC == 0x0 (64TxQs). We need more  space for Tx queues.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


