From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:46:04 +0000
Subject: [Intel-wired-lan] [next PATCH S13 04/15] i40e/i40evf: add
 exec_aq	command to nvmupdate utility
In-Reply-To: <1440798961-17326-5-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5E95@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S13 04/15] i40e/i40evf: add exec_aq
> command to nvmupdate utility
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add a facility to run AQ commands through the nvmupdate utility in order to
> allow the update tools to interact with the FW and do special commands
> needed for updates and configuration changes.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I5c41523e4055b37f8e4ee479f7a0574368f4a588
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   |  3 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c      | 83
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h     |  2 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c |  3 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h   |  2 +
>  5 files changed, 93 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
