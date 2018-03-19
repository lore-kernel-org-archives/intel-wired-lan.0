From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 22:12:53 +0000
Subject: [Intel-wired-lan] [next-queue v2 3/4] ixgbe: no need for esp
 trailer if gso
In-Reply-To: <1521223747-12018-4-git-send-email-shannon.nelson@oracle.com>
References: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
 <1521223747-12018-4-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CD64@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue v2 3/4] ixgbe: no need for esp trailer if
> gso
> 
> There is no need to calculate the trailer length if we're doing a GSO/TSO, as
> there is no trailer added to the packet data.
> Also, don't bother clearing the flags field as it was already cleared earlier.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 37 +++++++++++++++-----
> ------
>  1 file changed, 21 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


