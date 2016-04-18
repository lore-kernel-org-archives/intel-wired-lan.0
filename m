From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 17:30:25 +0000
Subject: [Intel-wired-lan] [next PATCH S33 07/13] i40e: Add
	device	capability which defines if update is available.
In-Reply-To: <1460475052-6348-8-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-8-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0E8A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S33 07/13] i40e: Add device capability
> which defines if update is available.
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> Add device capability which defines if update is available and security check is
> needed during update process.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Change-ID: I380787c878275e1df18b39198df3ee3666342282
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_common.c       | 6 ++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h         | 5 +++++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h       | 5 +++++
>  5 files changed, 18 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
nvmupdate works as expected
