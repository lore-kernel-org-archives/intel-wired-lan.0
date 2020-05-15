From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:46:28 +0000
Subject: [Intel-wired-lan] [PATCH S41 10/15] ice: refactor filter
 functions
In-Reply-To: <20200508004113.39725-10-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-10-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659FD33B92AB9733E4DD3868CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 10/15] ice: refactor filter functions
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Move filter functions to separate file.
> 
> Add functions that prepare suitable ice_fltr_info struct depending on the
> filter type and add this struct to earlier created
> list:
> - ice_fltr_add_mac_to_list
> - ice_fltr_add_vlan_to_list
> - ice_fltr_add_eth_to_list
> This functions are used in adding and removing filters.
> 
> Create wrappers for functions mentioned above that alloc list, add suitable
> ice_fltr_info to it and call add or remove function.
> - ice_fltr_prepare_mac
> - ice_fltr_prepare_mac_and_broadcast
> - ice_fltr_prepare_vlan
> - ice_fltr_prepare_eth
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  13 +-
>  drivers/net/ethernet/intel/ice/ice_fltr.c     | 397 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fltr.h     |  39 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 212 +---------
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   9 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  53 +--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  34 +-
>  8 files changed, 494 insertions(+), 264 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_fltr.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_fltr.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


