From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 19:05:07 +0000
Subject: [Intel-wired-lan] [next PATCH S21 06/14] i40evf: don't use
 atomic	allocation
In-Reply-To: <1446852372-25480-7-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-7-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1842@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 06/14] i40evf: don't use atomic
> allocation
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> These allocations don't need to be at atomic level. GFP_KERNEL is fine and
> they'll reduce stress on the allocator when the system is starved for memory.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I3561d0399a681de0ad25291b6c848b224c1fde12
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
