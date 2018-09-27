From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Sep 2018 15:51:42 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: off by one in
 ixgbevf_ipsec_tx()
In-Reply-To: <20180919103529.GC9238@mwanda>
References: <20180919103529.GC9238@mwanda>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC86D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Wednesday, September 19, 2018 3:35 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Shannon Nelson
> <shannon.nelson@oracle.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: off by one in ixgbevf_ipsec_tx()
> 
> The ipsec->tx_tbl[] array has IXGBE_IPSEC_MAX_SA_COUNT elements so
> the > should be a >=.
> 
> Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


