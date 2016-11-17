From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 21:55:58 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V2 4/5] i40e: Add functions
 which	apply correct PHY access method for read and write operation
In-Reply-To: <1479157609-30812-4-git-send-email-bimmy.pujari@intel.com>
References: <1479157609-30812-1-git-send-email-bimmy.pujari@intel.com>
 <1479157609-30812-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA380A5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 14, 2016 1:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S53-V2 4/5] i40e: Add functions which
> apply correct PHY access method for read and write operation
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> Depending on external PHY type, register access method should be
> different. Clause22 or Clause45 can be chosen for different PHYs.
> Implemented functions apply correct access method for used device.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Change-ID: If39d5f0da9c0b905a8cbdc1ab89885535e7d0426
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 72
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 ++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |  4 ++
>  3 files changed, 80 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


