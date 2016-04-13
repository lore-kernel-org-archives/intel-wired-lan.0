From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:43:34 +0000
Subject: [Intel-wired-lan] [next PATCH S33 01/13] i40e: Add support
	for	configuring VF RSS
In-Reply-To: <1460475052-6348-2-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-2-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D06F8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S33 01/13] i40e: Add support for
> configuring VF RSS
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Add support for configuring RSS on behalf of the VFs. This removes the
> burden of dealing with different hardware interfaces from the VF drivers,
> allowing for better future compatibility.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Icea75d3f37241ee8e447be5779e5abb53ddf04c0
> ---
> Testing Hints : Use ethtool to configure RSS key and LUT, test traffic spreads
> to different queues.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  35 +++-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 193
> ++++++++++++++++++++-
>  3 files changed, 217 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF traffic spreads among queues as expected
