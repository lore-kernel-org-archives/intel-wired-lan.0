From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 20 Feb 2018 23:03:00 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: check that pointer vsi is not
 null before dereferencing it
In-Reply-To: <20180215195052.29037-1-colin.king@canonical.com>
References: <20180215195052.29037-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94A604@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, February 15, 2018 11:51 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: check that pointer vsi is not null
> before dereferencing it
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function i40e_find_vsi_from_id can potentially return null, hence vsi may be
> null, so defensively check it is non-null before dereferencing it to check the
> seid.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


