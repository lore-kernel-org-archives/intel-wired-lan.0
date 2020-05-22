From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 20:07:00 +0000
Subject: [Intel-wired-lan] [PATCH S43 11/15] ice: set VF default LAN
 address
In-Reply-To: <20200516003644.4658-11-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-11-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16596E2F32D98ECD15F5A6218CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 11/15] ice: set VF default LAN address
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Remove is_zero_ether_add() check when setting the VF default LAN
> address.
> This check assumed that the address had been delete and zeroed before
> calling ice_vc_add_mac_addr(). Now the default LAN address will be set to
> the last unicast MAC address added by the VF.
> 
> The default LAN address is reported by the PF via ndo_get_vf_config.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


