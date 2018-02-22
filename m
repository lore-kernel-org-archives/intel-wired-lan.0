From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Feb 2018 00:29:10 +0000
Subject: [Intel-wired-lan] [PATCH][V2] i40evf: remove redundant array
 comparisons to 0 checks
In-Reply-To: <20180219102330.22045-1-colin.king@canonical.com>
References: <20180219102330.22045-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94A788@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Monday, February 19, 2018 2:24 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][V2] i40evf: remove redundant array
> comparisons to 0 checks
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The checks to see if key->dst.s6_addr and key->src.s6_addr are null pointers
> are redundant because these are constant size arrays and so the checks
> always return true.  Fix this by removing the redundant
> checks.   Also replace filter->f with vf, allowing wide lines to be
> condensed and to rejoin some split wide lines.
> 
> Detected by CoverityScan, CID#1465279 ("Array compared to 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 61 ++++++++++------------
> ---
>  1 file changed, 25 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


