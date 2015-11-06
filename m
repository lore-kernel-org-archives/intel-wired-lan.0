From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 6 Nov 2015 17:51:53 +0000
Subject: [Intel-wired-lan] [next PATCH 2/2] i40e: remove unused argument
In-Reply-To: <1446771662-36705-2-git-send-email-jesse.brandeburg@intel.com>
References: <1446771662-36705-1-git-send-email-jesse.brandeburg@intel.com>
 <1446771662-36705-2-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060DD461@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, November 05, 2015 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 2/2] i40e: remove unused argument
> 
> With the final edition of the patches to remove sleeps from the driver's entry
> points, the grab_rtnl argument is no longer needed, so partially revert the
> commit that added it.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ib9778476242586cc9e58b670f5f48d415cb59003
> 
> ---
> Testing Hints (required if no HSD): add and remove vlan, over and under
> bonding and teaming driver, add and delete mac address, run debug kernel
> with lock validator.  The test that originally failed was with vlan add/remove
> while running a vlan as part of a bridge with dhclient over the top of it.
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 16 +++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++++----
>  4 files changed, 18 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied,  add/delete mac/vlan operations lock and unlock normally
