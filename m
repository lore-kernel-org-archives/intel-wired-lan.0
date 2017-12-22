From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:47:23 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 8/9] i40e: simplify
 pointer dereferences
In-Reply-To: <20171218101802.75967-1-alice.michael@intel.com>
References: <20171218101802.75967-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB62@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:18 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S83-V5 8/9] i40e: simplify pointer
> dereferences
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Now that i40e_vsi_config_tc() has the pf and hw variable defined, use them,
> instead of dereferencing vsi->back. Much easier to read.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


