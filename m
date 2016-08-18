From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Aug 2016 20:59:18 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove XSTRINGIFY macro
 definitions	and uses
In-Reply-To: <2fcd71eb8b18415a020509e3ce116e3affa590b5.1471430183.git.joe@perches.com>
References: <2fcd71eb8b18415a020509e3ce116e3affa590b5.1471430183.git.joe@perches.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9212@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joe Perches
> Sent: Wednesday, August 17, 2016 3:38 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove XSTRINGIFY macro
> definitions and uses
> 
> Use __stringify instead.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 4 ----
>  drivers/net/ethernet/intel/i40e/i40e_client.h | 6 +++---
>  2 files changed, 3 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
