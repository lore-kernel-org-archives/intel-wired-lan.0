From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:02:35 +0000
Subject: [Intel-wired-lan] [next PATCH S25 02/16] i40e: AQ
	Add	set_switch_config
In-Reply-To: <1450901156-30904-3-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-3-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B515@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 02/16] i40e: AQ Add
> set_switch_config
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the new Set Switch Config AdminQ command, and mark the L2 Filter bit
> as deprecated in the Add VEB command.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I5b24790f14c56f0ddf3f70df1e486844146b039f
> ---
> Testing-Hints:
> Apply and compile cleanly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 15
> ++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 15
> ++++++++++++++-
>  2 files changed, 28 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
