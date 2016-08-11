From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 18:59:40 +0000
Subject: [Intel-wired-lan] [patch] i40e: remove a stray unlock
In-Reply-To: <20160803190107.GC775@mwanda>
References: <20160803190107.GC775@mwanda>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F89D9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Wednesday, August 03, 2016 12:01 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Catherine Sullivan
> <catherine.sullivan@intel.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [patch] i40e: remove a stray unlock
> 
> We shifted the locking around a bit but forgot to delete this unlock so now it
> can unlock twice.
> 
> Fixes: cd3be169a5ff ('i40e: Move the mutex lock in i40e_client_unregister')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


