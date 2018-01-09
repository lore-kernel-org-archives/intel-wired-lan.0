From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 9 Jan 2018 22:36:05 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: use ARRAY_SIZE for various
 array sizing calculations
In-Reply-To: <20180107145146.2934-1-colin.king@canonical.com>
References: <20180107145146.2934-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7FDC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Sunday, January 7, 2018 6:52 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: use ARRAY_SIZE for various array
> sizing calculations
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Use the ARRAY_SIZE macro on various arrays to determine size of the arrays.
> Improvement suggested by coccinelle.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


