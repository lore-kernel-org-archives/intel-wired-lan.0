From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Sep 2017 17:59:04 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 07/13] i40e: fix merge
 error
In-Reply-To: <20170829093242.41026-7-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA966C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 07/13] i40e: fix merge error
> 
> This patch removes some code that was accidentally added to the wrong
> function with a merge error.  Fixes: c53934c6d1b1
> ("i40e: fix: do not sleep in netdev_ops")
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


