From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Dec 2017 19:51:55 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 2/9] i40e: avoid divide by
 zero
In-Reply-To: <20171218101525.75683-1-alice.michael@intel.com>
References: <20171218101525.75683-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EBCF0A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:15 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S83-V5 2/9] i40e: avoid divide by zero
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some weird circumstances with DCB enabled, the firmware can fail to
> configure the VSI, leaving us with zero traffic classes. Check for this state
> when we configure RSS to avoid a panic.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


