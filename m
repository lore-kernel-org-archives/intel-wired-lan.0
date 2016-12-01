From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 18:54:19 +0000
Subject: [Intel-wired-lan] [next PATCH S55 03/14] i40e: Remove FPK
 HyperV VF	device ID
In-Reply-To: <1480377971-23412-4-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38EF4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S55 03/14] i40e: Remove FPK HyperV
> VF device ID
> 
> From: Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
> 
> Requirement for VFs to use the VMBus has been removed that's why
> removing Hyper-V VF device ID.
> 
> Signed-off-by: Jayaprakash Shanmugam
> <jayaprakash.shanmugam@intel.com>
> Change-ID: I84f0964f443ee0db3e5e444b5ace996eb71b8280
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 -
> drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 -
>  2 files changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


