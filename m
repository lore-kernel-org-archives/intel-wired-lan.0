From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Apr 2016 15:34:37 +0000
Subject: [Intel-wired-lan] [next PATCH S34 04/12] i40e: Remove HMC AQ
 API	implementation
In-Reply-To: <1460542112-20166-5-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-5-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D51EC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:08 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 04/12] i40e: Remove HMC AQ API
> implementation
> 
> From: Neerav Parikh <neerav.parikh@intel.com>
> 
> Remove the code that implements the HMC AQ APIs and call these APIs.
> This is done because these are obsolete APIs and are not supported by
> firmware.
> 
> Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> Change-ID: I5d771d8f37c3e16e7b0a972ff9b27e75aa2d05d4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  4 ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 25 ------------------
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 30 ----------------------
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 ---
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 25 ------------------
>  5 files changed, 88 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
HMC code gone from admin queue, code compiles correctly
