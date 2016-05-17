From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:22:59 +0000
Subject: [Intel-wired-lan] [next PATCH S37 01/15] i40e: add functions
	to	control default VSI
In-Reply-To: <1463419605-30746-2-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D683C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 01/15] i40e: add functions to
> control default VSI
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Add functions to enable and disable default VSI on a VEB. This allows for
> configuration of limited promiscuous mode specifically for bridging purposes.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0cc5bd68b31c500fdff4d47e1f15d50d2739faf4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 56
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  2 +
>  2 files changed, 58 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
