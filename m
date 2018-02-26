From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Feb 2018 23:14:14 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 3/3] ixgbe: remove unneeded
 ipsec state free callback
In-Reply-To: <1519326597-7679-4-git-send-email-shannon.nelson@oracle.com>
References: <1519326597-7679-1-git-send-email-shannon.nelson@oracle.com>
 <1519326597-7679-4-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94AC4C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Thursday, February 22, 2018 11:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH next-queue 3/3] ixgbe: remove unneeded
> ipsec state free callback
> 
> With commit 7f05b467a735 ("xfrm: check for xdo_dev_state_free") we no
> longer need to add an empty callback function to the driver, so now let's
> remove the useless code.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 13 -------------
>  1 file changed, 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


