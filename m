From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Jan 2018 20:03:11 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: use compiler constants in
 Rx path
In-Reply-To: <1515805815-2692-3-git-send-email-shannon.nelson@oracle.com>
References: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
 <1515805815-2692-3-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A92C699@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Friday, January 12, 2018 5:10 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: steffen.klassert at secunet.com; sowmini.varadhan at oracle.com;
> netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: use compiler constants in Rx
> path
> 
> Rather than swapping runtime bytes to compare to constants, let the
> compiler swap the constants and save a couple of runtuime cycles.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


