From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 20 Feb 2018 23:00:30 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: pass struct virtchnl_filter
 by reference rather than by value
In-Reply-To: <20180215192605.28350-1-colin.king@canonical.com>
References: <20180215192605.28350-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94A5F5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, February 15, 2018 11:26 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40evf: pass struct virtchnl_filter by
> reference rather than by value
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Passing struct virtchnl_filter f by value requires a 272 byte copy on x86_64, so
> instead pass it by reference is much more efficient. Also adjust some lines
> that are over 80 chars.
> 
> Detected by CoverityScan, CID#1465285 ("Big parameter passed by value")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 32 ++++++++++++----------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


