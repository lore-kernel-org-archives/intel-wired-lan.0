From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 23:41:39 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 06/15] i40e: Refactor
 force_wb	and WB_ON_ITR functionality code
In-Reply-To: <1452732712-12248-7-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-7-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98097B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 06/15] i40e: Refactor force_wb
> and WB_ON_ITR functionality code
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Now that the Force-WriteBack functionality in X710/XL710 devices has been
> moved out of the clean routine and into the service task, we need to make
> sure WriteBack-On-ITR is separated out since it is still called from clean.
> 
> In the X722 devices, Force-WriteBack implies WriteBack-On-ITR but without
> the interrupt, which put the driver into a missed interrupt scenario and a
> potential tx-timeout report.
> 
> With this patch, we break the two functions out, and call the appropriate
> ones at the right place. This will avoid creating missed interrupt like scenarios
> for X722 devices.
> 
> Also update copyright year in file headers.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Iacbde39f95f332f82be8736864675052c3583a40
> ---
> Testing Hints: Stress test X722 devices for tx_timeout, see that the
> tx_lost_interrupt stat count goes down with the patch applied.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 57 ++++++++++++++----------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 63 +++++++++++++++-------
> -----  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  3 +-
>  3 files changed, 72 insertions(+), 51 deletions(-)

[v2 next PATCH S27 06/15] i40e: Refactor force_wb and WB_ON_ITR functionality code
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, stats decrease with patch applied
