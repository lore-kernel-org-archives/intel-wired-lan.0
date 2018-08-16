From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 22:27:13 +0000
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbe: don't clear ipsec
 sa counters on hw clearing
In-Reply-To: <1533929050-15326-1-git-send-email-shannon.nelson@oracle.com>
References: <1533929050-15326-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E9202@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Friday, August 10, 2018 12:24 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH next-queue] ixgbe: don't clear ipsec sa
> counters on hw clearing
> 
> The software SA record counters should not be cleared when clearing the
> hardware tables.  This causes the counters to be out of sync after a driver
> reset.
> 
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


