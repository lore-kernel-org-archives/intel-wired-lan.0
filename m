From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Dec 2015 19:42:41 +0000
Subject: [Intel-wired-lan] [next PATCH S24 11/12] i40e: AQ Add
	external	power class to get link status
In-Reply-To: <1450823114-29514-12-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-12-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F92F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 11/12] i40e: AQ Add external
> power class to get link status
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the new External Device Power Ability field to the get_link_status data
> structure, using space from the reserved field at the end of the struct.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> Testing-Hints:
> Apply and compile cleanly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 7 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
