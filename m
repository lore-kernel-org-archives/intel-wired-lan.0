From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:23:29 +0000
Subject: [Intel-wired-lan] [PATCH S49 15/15] ice: add 1G SGMII PHY type
In-Reply-To: <20200709161614.61098-15-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-15-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21455A794F9B7CFFC4A5228F8C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 15/15] ice: add 1G SGMII PHY type
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> There isn't a case for 1G SGMII in ice_get_media_type() so add the handling
> for it.
> 
> Also handle the special case where some direct attach cables may report that
> they support 1G SGMII, but that is erroneous since SGMII is supposed to be a
> backplane media type (between a MAC and a PHY). If the driver doesn't
> handle this special case then a user could see the 'Port' in ethtool change
> from 'Direct attach Copper' to 'Backplane' when they have forced the speed
> to 1G, but the cable hasn't changed.
> 
> Lastly, change ice_aq_get_phy_caps() to save the module_type info if the
> function was called with ICE_AQC_REPORT_TOPO_CAP. This call uses the
> media information to populate the module_type. If no media is present then
> the values in module_type will be 0.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c     | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


