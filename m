From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:44:54 +0000
Subject: [Intel-wired-lan] [PATCH S45 15/15] ice: Update
 ICE_PHY_TYPE_HIGH_MAX_INDEX value
In-Reply-To: <20200516005121.4963-15-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-15-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165992EB445D0679C4E7F3488C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 15/15] ice: Update
> ICE_PHY_TYPE_HIGH_MAX_INDEX value
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> As currently, we are supporting only 5 PHY_SPEEDs for phy_type_high.
> Thus, we should adjust the value of ICE_PHY_TYPE_HIGH_MAX_INDEX to 5.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


