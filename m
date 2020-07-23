From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:24:00 +0000
Subject: [Intel-wired-lan] [PATCH S49 10/15] ice: add
 ice_aq_get_phy_caps() debug logs
In-Reply-To: <20200709161614.61098-10-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-10-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145066E9FB6204CAAAA6C4D8C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S49 10/15] ice: add ice_aq_get_phy_caps()
> debug logs
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add debug logs for ice_aq_get_phy_caps(), and format
> ice_aq_set_phy_cfg() and ice_aq_get_link_info() debug logs to make them
> more readable.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 68 +++++++++++++++------
>  1 file changed, 50 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


