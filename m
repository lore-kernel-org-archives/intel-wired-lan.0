From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Jul 2018 21:26:48 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: Off by one in
 ixgbe_ipsec_tx()
In-Reply-To: <20180704095337.nqiczkkd5r6k755v@kili.mountain>
References: <20180704095337.nqiczkkd5r6k755v@kili.mountain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2D4700@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Wednesday, July 4, 2018 2:54 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Shannon Nelson
> <shannon.nelson@oracle.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: Off by one in ixgbe_ipsec_tx()
> 
> The ipsec->tx_tbl[] has IXGBE_IPSEC_MAX_SA_COUNT elements so the >
> needs to be changed to >= so we don't read one element beyond the end of
> the array.
> 
> Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


