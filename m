From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:15:03 +0000
Subject: [Intel-wired-lan] [next PATCH S25 03/16] i40e: AQ Add
	VXLAN-GPE	tunnel type
In-Reply-To: <1450901156-30904-4-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-4-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B524@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S25 03/16] i40e: AQ Add VXLAN-GPE
> tunnel type
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the new Cisco VXLAN-GPE cloud tunnel type for the Add Cloud Filter and
> UDP tunnel AQ commands.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I2c093c7d79726c7fca08a36e5c63581a905da3d2
> ---
> Testing-Hints:
> Apply and compile cleanly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 3 +++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
