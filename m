From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Feb 2016 00:40:48 +0000
Subject: [Intel-wired-lan] [next PATCH S29 11/14] i40e: Use the new rx
 ctl	register helpers. Don't use AQ calls from clear_hw.
In-Reply-To: <1455754344-6372-12-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-12-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F431@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 11/14] i40e: Use the new rx ctl
> register helpers. Don't use AQ calls from clear_hw.
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Use the new AdminQ functions for safely accessing the Rx control registers
> that may be affected by heavy small packet traffic.
> 
> We can't use AdminQ calls in i40e_clear_hw() because the HW is being
> initialized and the AdminQ is not alive.  We recently added an AQ related
> replacement for reading PFLAN_QALLOC, and this patch puts back the
> original register read.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ib027168c954a5733299aa3a4ce5f8218c6bb5636
> ---
> Testing Hints:
> 	Please be sure that flow director and RSS configuration changes
> 	work as expected both with and without stress traffic.
> 	Make sure the driver Loads.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  8 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |  8 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 20 ++++++++++----------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  7 ++++---
>  5 files changed, 23 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
AQ-RSS functions work properly and change under load without error
