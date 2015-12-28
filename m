From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:24:22 +0000
Subject: [Intel-wired-lan] [next PATCH S25 05/16] i40e: Bump AQ
	minor	version to 1.5 for new FW features
In-Reply-To: <1450901156-30904-6-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-6-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B541@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S25 05/16] i40e: Bump AQ minor
> version to 1.5 for new FW features
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Bump AQ minor version to 1.5 for new FW features.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I5a790f7f519a2a8921aaa1c5663727dd1897ffec
> ---
> Testing-Hints:
> Apply and compile cleanly on driver load with old NVMs, should see log
> message:
> The driver for the device detected an older version of the NVM image than
> expected. Please update the NVM image.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
