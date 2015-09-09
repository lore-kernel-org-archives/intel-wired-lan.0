From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:50:30 +0000
Subject: [Intel-wired-lan] [next PATCH S13 05/15] i40e/i40evf: add get
 AQ	result command to nvmupdate utility
In-Reply-To: <1440798961-17326-6-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5EA5@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S13 05/15] i40e/i40evf: add get AQ
> result command to nvmupdate utility
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add a facility to recover the result of a previously run AQ command.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I21afec2c20c1a5e6ba60c7fbfcbedfff78c10e45
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 79
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 +
>  3 files changed, 81 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
