From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:58:00 +0000
Subject: [Intel-wired-lan] [next PATCH] iavf: allow permanent MAC
 address to change
In-Reply-To: <20190725094743.20861-1-alice.michael@intel.com>
References: <20190725094743.20861-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA2B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, July 25, 2019 2:48 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] iavf: allow permanent MAC address
> to change
> 
> Allow the VF to override the "permanent" MAC address set by the host.
> This allows bonding to work in the case where the administrator has set the
> VF MAC.
> 
> Note that the VF must still be set to Trusted on the host if this change is to be
> accepted by the PF driver.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      | 1 -
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ----
>  2 files changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


