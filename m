From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 18:23:49 +0000
Subject: [Intel-wired-lan] [next PATCH S12 06/15] i40e: inline
	interrupt	enable
In-Reply-To: <1440690163-128213-7-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5D78@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 06/15] i40e: inline interrupt
> enable
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The interrupt enable function can be inlined by moving it to the header file,
> which decreases the function call overhead for a frequently called function.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I3214cc99593725768642680e7b8ce7e9bba7e44d
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 19 ++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ------------------
>  2 files changed, 18 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
