From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jan 2018 19:17:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix && vs || typo
In-Reply-To: <20180111214601.4cyjpvmbsothnc23@mwanda>
References: <20180111214601.4cyjpvmbsothnc23@mwanda>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D8455@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Thursday, January 11, 2018 1:46 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Greenwalt, Paul
> <paul.greenwalt@intel.com>
> Cc: kernel-janitors at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix && vs || typo
> 
> "offset" can't be both 0x0 and 0xFFFF so presumably || was intended instead
> of &&.  That matches with how this check is done in other functions.
> 
> Fixes: 73834aec7199 ("ixgbe: extend firmware version support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


