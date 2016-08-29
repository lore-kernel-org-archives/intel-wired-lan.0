From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Aug 2016 17:36:40 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: avoid potential null
	pointer	dereference when assigning len
In-Reply-To: <20160828174101.9671-1-colin.king@canonical.com>
References: <20160828174101.9671-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAF49@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Sunday, August 28, 2016 10:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: avoid potential null pointer
> dereference when assigning len
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a sanitcy check for desc being null in the first line of function
> i40evf_debug_aq.  However, before that, aq_desc is cast from desc, and
> aq_desc is being dereferenced on the assignment of len, so this could be a
> potential null pointer deference.  Fix this by moving the initialization of len to
> the code block where len is being used and hence at this point we know it is
> OK to dereference aq_desc.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

