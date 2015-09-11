From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:37:08 +0000
Subject: [Intel-wired-lan] [next PATCH S12 05/15] i40e: fix erroneous
 WARN_ON
In-Reply-To: <1440690163-128213-6-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6453@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S12 05/15] i40e: fix erroneous
> WARN_ON
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was issuing a WARN_ON during ring size changes because the
> code was cloning the rx_ring struct but not zeroing out the pointers before
> allocating new memory.
> 
> Zero out the pointers in the cloned copy before allocating new memory for
> them.  In this case the code was correctly avoiding memory leaks but still
> triggering the warning.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I186dd493948e9b7254ab0593d4aad8b68808918d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, no WARN_ON when changing ring sizes.
