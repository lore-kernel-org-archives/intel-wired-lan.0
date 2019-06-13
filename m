From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 13 Jun 2019 21:30:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero
 in ixgbevf_update_itr
In-Reply-To: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
References: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3ED68F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Young Xiao
> Sent: Tuesday, May 28, 2019 4:58 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Cc: Young Xiao <92siuyang@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero in
> ixgbevf_update_itr
> 
> The next call to ixgbevf_update_itr will continue to dynamically update ITR.
> 
> Copy from commit bdbeefe8ea8c ("ixgbe: fix possible divide by zero in
> ixgbe_update_itr")
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


