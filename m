From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jun 2016 16:06:48 +0000
Subject: [Intel-wired-lan] [next PTACH S38-v2 4/7] i40e: Remove device
 ID	0x37D4
In-Reply-To: <1466439039-16378-5-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
 <1466439039-16378-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E8EC5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, June 20, 2016 9:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PTACH S38-v2 4/7] i40e: Remove device ID
> 0x37D4
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> This device ID is not needed, so take it out.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I148d29f68a1f58b03980ecd83047a1b440f4f74d
> ---
> Testing Hints: Make sure device ID does not appear in devids.h and we
> compile, note that the ID will remain in the upstream pciid database.
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 -
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 -
> drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 -
>  5 files changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Device ID does not appear in .h file or in modinfo
