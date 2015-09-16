From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Sep 2015 17:47:20 +0000
Subject: [Intel-wired-lan] [next PATCH S13 01/15] i40e/i40evf: add
 handling	of writeback descriptor
In-Reply-To: <1440798961-17326-2-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6D32@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S13 01/15] i40e/i40evf: add handling
> of writeback descriptor
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> If the writeback descriptor buffer was previously created, this gives it to the
> AQ command request to be used to save the results.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I8c8a1af81e6ebed6d0a15ed31697fe1a6c4e3708
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 26
> ++++++++++++++++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h |  1 +
>  3 files changed, 24 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, admin queue data written and read correctly.
