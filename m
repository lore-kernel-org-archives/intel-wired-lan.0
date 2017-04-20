From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Apr 2017 23:00:17 +0000
Subject: [Intel-wired-lan] [next PATCH S71 01/10] i40e: rename index to
 port	to avoid confusion
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1161@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 01/10] i40e: rename index to port
> to avoid confusion
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The .index field of i40e_udp_port_config represents the udp port number.
> Rename this variable to port so that it is more obvious.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


