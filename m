From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 21:58:12 +0000
Subject: [Intel-wired-lan] [next PATCH S11 06/15] i40e: fix bad CEE
 status	shift value
In-Reply-To: <1440616461-110869-7-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A590C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 06/15] i40e: fix bad CEE status
> shift value
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Fix a shift value that was wrong, ending up with a bad bitmask.  Also add a
> blank line between two sets of #defines for better readability.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I3e41fa2a2ab904d3a4e6cbf13972ab0036a10601
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
