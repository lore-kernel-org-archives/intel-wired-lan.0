From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:30:41 +0000
Subject: [Intel-wired-lan] [next PATCH S13 02/15] i40e/i40evf: add
 GetStatus	command for nvmupdate
In-Reply-To: <1440798961-17326-3-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 02/15] i40e/i40evf: add GetStatus
> command for nvmupdate
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> This adds a new GetStatus command so that the NVM update tool can query
> the current status instead of doing fake write requests to probe for
> readiness.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I671ec6ccd4dfc9dbac3a03b964589d693fda5cd8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 42
> ++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  2 ++
>  3 files changed, 35 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
