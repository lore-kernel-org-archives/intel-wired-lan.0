From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Oct 2015 21:53:22 +0000
Subject: [Intel-wired-lan] [next PATCH S17 08/11] i40e/i40evf: Fix
	an	accidental error with BIT_ULL replacement
In-Reply-To: <1443464220-148318-9-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2EE3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 08/11] i40e/i40evf: Fix an
> accidental error with BIT_ULL replacement
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> A mask value of 0x1FF was accidentally replaced with a bit mask causing flow
> director sideband to be broken.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Id3387f67dd1b567b41692b570b383c58671e1eae
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
