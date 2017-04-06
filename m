From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:44:11 +0000
Subject: [Intel-wired-lan] [next S66 v2 07/11] i40e:
	remove	I40E_FLAG_NEED_LINK_UPDATE
In-Reply-To: <20170405115103.67374-7-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B16E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 07/11] i40e: remove
> I40E_FLAG_NEED_LINK_UPDATE
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The I40E_FLAG_NEED_LINK_UPDATE was never used. Remove the flag
> definitions.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If59d0c6b4af85ca27281f3183c54b055adb439a4
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
> drivers/net/ethernet/intel/i40evf/i40evf.h  | 1 -
>  3 files changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
