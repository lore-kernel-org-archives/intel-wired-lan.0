From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Nov 2015 22:50:14 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 01/12] i40e: chomp
	the	BIT(_ULL)
In-Reply-To: <1447961665-12344-2-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-2-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F8929AD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [V3: next PATCH S22 01/12] i40e: chomp the
> BIT(_ULL)
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> BIT_ULL was used on a u32 or less where it can simply be BIT. This fixes some
> trivial static analyzer warnings. Chomp, chomp.
> 
> Tested with objdump of binary before and after, no changes to code.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I6245e9abd447192dbde1669c747aeb2878126c7d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 30 ++++++++++++++----------
> -----
>  1 file changed, 15 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
