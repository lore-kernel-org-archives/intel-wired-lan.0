From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:46:54 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 7/9] i40e: check for
 invalid DCB config
In-Reply-To: <20171218101742.75920-1-alice.michael@intel.com>
References: <20171218101742.75920-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB51@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S83-V5 7/9] i40e: check for invalid DCB
> config
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The driver (and the entire netdev layer for that matter) assumes that TC0 will
> always be present in our DCB configuration.
> Unfortunately, this isn't always the case. Rather than fail to configure the VSI,
> let's go ahead and try to make it work, even though DCB will end up being
> disabled by the kernel.
> 
> If the driver fails to configure DCB, the driver queries what's valid, then
> writes that back to the hardware, always forcing TC0.
> 
> This fixes a bug where the driver could fail to adhere to ETS BW allocations if 8
> TCs were configured on the switch.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 34
> ++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


