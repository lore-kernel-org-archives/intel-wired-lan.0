From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 17:22:19 +0000
Subject: [Intel-wired-lan] [next PATCH S47 4/9] i40e: Remove unused
 function	i40e_vsi_lookup
In-Reply-To: <1473895479-23035-5-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E4FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S47 4/9] i40e: Remove unused
> function i40e_vsi_lookup
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The function is not used so there is no need to carry it forward.  I have plans
> to add a slightly different function that can be inlined to handle the same
> kind of functionality.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ie2dfcb189dc75e5fbc156bac23003e3b4210ae0f
> ---
> Testing Hints:
>         Verify driver builds without issues under various configurations.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h        |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 31 ---------------------------
>  2 files changed, 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


