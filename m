From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 16:58:24 +0000
Subject: [Intel-wired-lan] [next PATCH S25 01/16] i40e: AQ Shared
 resource	flags
In-Reply-To: <1450901156-30904-2-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-2-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F979505@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S25 01/16] i40e: AQ Shared resource
> flags
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add flags to MAC allocation requests to signify that the macvlan filters should
> come from the shared resource pool rather than the dedicated PF resource
> pools.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I4c2da64c01856edcb0982bc4aab75c5a91047a7a
> ---
> Testing-Hints:
> Apply and compile cleanly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 5 +++++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 5 +++++
>  2 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
