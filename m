From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 22:20:10 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: Use le32_to_cpu
 before	evaluating HW desc fields
In-Reply-To: <1498149872-16623-1-git-send-email-tushar.n.dave@oracle.com>
References: <1498149872-16623-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DABFFB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tushar Dave
> Sent: Thursday, June 22, 2017 9:45 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: Use le32_to_cpu
> before evaluating HW desc fields
> 
> i40e hardware descriptor fields are in little-endian format. Driver must use
> le32_to_cpu while evaluating these fields otherwise on big-endian arch we
> end up evaluating incorrect values, cause errors
> like:
> i40evf 0000:03:0a.0: Expected response 24 from PF, received 402653184
> i40evf 0000:03:0a.1: Expected response 7 from PF, received 117440512
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
