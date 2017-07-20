From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 19:26:22 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 11/13] i40e: Fix
 unrecognized	PHY type warning message for 25G AOC/ACC
In-Reply-To: <20170714131019.52530-11-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB261C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Mogilappagari at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 11/13] i40e: Fix unrecognized
> PHY type warning message for 25G AOC/ACC
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> For 25G ACC and AOC PHY types a warning message appears like "Link is up
> but PHY type 0x23 is not recognized". This commit adds a case statement in
> i40e_get_link_settings_link_up() for 25G AOC/ACC PHY types to set correct
> parameters.
> 
> Signed-off-by: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


