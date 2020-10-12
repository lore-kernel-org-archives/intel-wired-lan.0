From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 21:16:42 +0000
Subject: [Intel-wired-lan] [PATCH S53 11/15] ice: Remove vlan_ena from
 vsi structure
In-Reply-To: <20200917201347.81570-11-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-11-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890AC3143581E14B25AC761BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 11/15] ice: Remove vlan_ena from vsi
> structure
> 
> From: Nick Nunley <nicholas.d.nunley@intel.com>
> 
> vlan_ena was introduced to track whether VLAN filters are enabled on
> the device, but
> 1) checking for num_vlan > 1 already gives us this information, and is
> currently used in this way throughout the code
> 2) the logic for vlan_ena is broken when multiple VLANS are active
> 
> Just remove vlan_ena and use num_vlan instead.
> 
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 -
>  drivers/net/ethernet/intel/ice/ice_main.c | 11 ++++-------
>  2 files changed, 4 insertions(+), 8 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
