From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:47:29 +0000
Subject: [Intel-wired-lan] [PATCH S50 01/15] ice: Implement LFC
 workaround
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145160B8685DDC2C20408488C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 01/15] ice: Implement LFC workaround
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> There is a bug where the LFC settings are not being preserved through a link
> event.  The registers in question are the ones that are touched (and
> restored) when a set_local_mib AQ command is performed.
> 
> On a link-up event, make sure that a set_local_mib is being performed.
> 
> Move the function ice_aq_set_lldp_mib() from the DCB specific ice_dcb.c to
> ice_common.c so that the driver always has access to this AQ command.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c  |  33 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.h  |   3 +
>  drivers/net/ethernet/intel/ice/ice_dcb.c     |  33 ------
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |   4 -
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  11 ++
>  drivers/net/ethernet/intel/ice/ice_main.c    | 102 ++++++++++++++++++-
>  6 files changed, 148 insertions(+), 38 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


