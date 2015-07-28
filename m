From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:17:17 +0000
Subject: [Intel-wired-lan] [next PATCH S9 11/15] i40e: Strip VEB stats
 if	they are disabled in HW
In-Reply-To: <1437684884-222825-12-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE546@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [next PATCH S9 11/15] i40e: Strip VEB stats if they
> are disabled in HW
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Due to performance reasons, VEB stats have been disabled in the hw. This
> patch adds code to check for that condition before accumulating these stats.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I7d805669476fedabb073790403703798ae5d878e
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  9 ++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++++++----
>  3 files changed, 16 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree.
