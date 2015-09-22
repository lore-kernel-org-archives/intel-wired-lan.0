From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Sep 2015 21:20:05 +0000
Subject: [Intel-wired-lan] [next PATCH S15 13/15] i40e: remove
 unnecessary	string copy operations
In-Reply-To: <1441315142-173025-14-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B170E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 13/15] i40e: remove unnecessary
> string copy operations
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Save a little stack space and remove unnecessary strncpy() with a little string
> pointer.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Id2719d34710bfc273d3bb445fec085cd04276e88
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
