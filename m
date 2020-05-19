From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:38:05 +0000
Subject: [Intel-wired-lan] [PATCH S42 7/7] ice: Implement aRFS
In-Reply-To: <20200512010146.41303-7-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165915648FEE68955FB201498CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, May 11, 2020 6:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S42 7/7] ice: Implement aRFS
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Enable accelerated Receive Flow Steering (aRFS). It is used to steer Rx flows
> to a specific queue. This functionality is triggerred by the network stack
> through ndo_rx_flow_steer and requires Flow Director (ntuple on) to
> function.
> 
> The fltr_info is used to add/remove/update flow rules in the HW, the
> fltr_state is used to determine what to do with the filter with respect to HW
> and/or SW, and the flow_id is used in co-ordination with the network stack.
> 
> The work for aRFS is split into two paths: the ndo_rx_flow_steer operation
> and the ice_service_task. The former is where the kernel hands us an Rx SKB
> among other items to setup aRFS and the latter is where the driver
> adds/updates/removes filter rules from HW and updates filter state.
> 
> In the Rx path the following things can happen:
>         1. New aRFS entries are added to the hash table and the state is
>            set to ICE_ARFS_INACTIVE so the filter can be updated in HW
>            by the ice_service_task path.
>         2. aRFS entries have their Rx Queue updated if we receive a
>            pre-existing flow_id and the filter state is ICE_ARFS_ACTIVE.
>            The state is set to ICE_ARFS_INACTIVE so the filter can be
>            updated in HW by the ice_service_task path.
>         3. aRFS entries marked as ICE_ARFS_TODEL are deleted
> 
> In the ice_service_task path the following things can happen:
>         1. New aRFS entries marked as ICE_ARFS_INACTIVE are added or
>            updated in HW.
>            and their state is updated to ICE_ARFS_ACTIVE.
>         2. aRFS entries are deleted from HW and their state is updated
>            to ICE_ARFS_TODEL.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |  14 +
>  drivers/net/ethernet/intel/ice/ice_arfs.c     | 663 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_arfs.h     |  82 +++
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   8 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  48 +-
>  7 files changed, 805 insertions(+), 12 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_arfs.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_arfs.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


