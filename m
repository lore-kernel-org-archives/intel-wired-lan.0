From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 22:12:22 +0000
Subject: [Intel-wired-lan] [next-queue v2 2/4] ixgbe: remove unneeded
 ipsec test in TX path
In-Reply-To: <1521223747-12018-3-git-send-email-shannon.nelson@oracle.com>
References: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
 <1521223747-12018-3-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CD54@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Friday, March 16, 2018 11:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue v2 2/4] ixgbe: remove unneeded
> ipsec test in TX path
> 
> Since the ipsec data fields will be zero anyway in the non-ipsec case, we can
> remove the conditional jump.
> 
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


