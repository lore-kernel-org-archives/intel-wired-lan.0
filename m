From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 20:49:23 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 10/10] i40e: refactor
	FW	version checking
In-Reply-To: <20170714132709.52657-10-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB27BA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S77-V3 10/10] i40e: refactor FW
> version checking
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The i40e driver now supports two different devices with two different
> firmware versions. So be smart about how we handle these. Move the FW
> version macros to the appropriate header file, and add a convenience macro
> that checks the version based on the device. Then use this macro to check
> whether or not the driver can use the new link info API.
> 
> Testing Hints (required if no HSD): Compile, load on both X710 and X722 and
> make sure it doesn't complain about API version on latest FW.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 10 +++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c       |  6 ++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c         |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 10 +++++++++-
>  4 files changed, 23 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


