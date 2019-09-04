From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:27:07 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 6/9] ice: Allow for delayed
 LLDP MIB change registration
In-Reply-To: <20190903083108.19593-6-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
 <20190903083108.19593-6-anthony.l.nguyen@intel.com>
Message-ID: <e1d04ac5e3af46089fa7ce16f77c17d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 6/9] ice: Allow for delayed LLDP MIB
> change registration
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Add an additional boolean parameter to the ice_init_dcb function.  This
> boolean controls if the LLDP MIB change events are registered for.  Also, add
> a new function defined ice_cfg_lldp_mib_change.  The additional function is
> necessary to be able to register for LLDP MIB change events after calling
> ice_init_dcb.  The net effect of these two changes is to allow a delayed
> registration for MIB change events so that the driver is not accepting events
> before it is ready for them.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c     | 39 ++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb.h     | 11 ++----
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  4 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++-
>  drivers/net/ethernet/intel/ice/ice_main.c    |  2 +
>  5 files changed, 51 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


