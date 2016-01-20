From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 22:41:44 +0000
Subject: [Intel-wired-lan] [next PATCH S28 07/15] i40e: Removal of
	code	which relies on BASE VEB SEID
In-Reply-To: <1452897202-15204-8-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-8-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F989C8E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 07/15] i40e: Removal of code
> which relies on BASE VEB SEID
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Fixed mapping of SEID is removed from specification. Hence this patch
> removes code which was using hardcoded base VEB SEID.
> 
> Changed FCoE code to use "hw->pf_id" to obtain correct "idx"
> and verified.
> 
> Removed defines for BASE VSI/VEB SEID and BASE_PF_SEID since it is not
> used anymore.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Id507cf4b1fae1c0145e3f08ae9ea5846ea5840de
> ---
> Testing Hints:
> 	Please test using debugfs hook for "dump veb <seid>".
> 		echo "dump veb [seid]" > command
> 	Here "seid" is VEB seid and it is optional argument. If "seid"
> 	is not specified, it dumps all VEBs.
> 
> 	After this patch, user shall see output in dmesg. Without this patch,
> 	if SEID is not in range, user will see error like
> 		"<seid>: bad seid"
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 16 +++-------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  2 +-
>  3 files changed, 4 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, debugfs dump veb command works as expected per patch
