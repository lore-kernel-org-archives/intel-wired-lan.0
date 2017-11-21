From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Nov 2017 19:45:21 +0000
Subject: [Intel-wired-lan] [PATCH v2 3/7] ixgbevf: Use smp_rmb rather
 than read_barrier_depends
In-Reply-To: <1510938349-17608-4-git-send-email-brking@linux.vnet.ibm.com>
References: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
 <1510938349-17608-4-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF40C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Brian King
> Sent: Friday, November 17, 2017 9:06 AM
> Cc: muvic at linux.vnet.ibm.com; stable at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; brking at pobox.com
> Subject: [Intel-wired-lan] [PATCH v2 3/7] ixgbevf: Use smp_rmb rather than
> read_barrier_depends
> 
> The original issue being fixed in this patch was seen with the ixgbe driver, but
> the same issue exists with ixgbevf as well, as the code is very similar.
> read_barrier_depends is not sufficient to ensure loads following it are not
> speculatively loaded out of order by the CPU, which can result in stale data
> being loaded, causing potential system crashes.
> 
> Cc: stable<stable@vger.kernel.org>
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


