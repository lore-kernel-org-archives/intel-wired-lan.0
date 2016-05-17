From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:27:46 +0000
Subject: [Intel-wired-lan] [next PATCH S37 04/15] i40e: Add a call to
 set	the client interface down
In-Reply-To: <1463419605-30746-5-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D686D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S37 04/15] i40e: Add a call to set the
> client interface down
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> We were failing to set the client interface down when we put the vsi down.
> Add this call so that the client doesn't get an open called with no close.
> 
> Also remove an un-needed delay. The vf should not be affected at all by
> i40e_down.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I1135dffef534bf84e6fed57cf51bcf590e6cfaf7
> ---
> Testing Hints: See HSD
> HSD-number: 7662119
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Verified fixed per HSD
