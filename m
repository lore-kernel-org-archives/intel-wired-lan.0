From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 27 Aug 2020 01:33:45 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ice: refactor devlink_port to be
 per-VSI
In-Reply-To: <20200819215838.3834786-4-jacob.e.keller@intel.com>
References: <20200819215838.3834786-1-jacob.e.keller@intel.com>
 <20200819215838.3834786-4-jacob.e.keller@intel.com>
Message-ID: <DM6PR11MB2890EAE695CEEEAB786F2986BC550@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob
> Keller
> Sent: Wednesday, August 19, 2020 2:59 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH 3/3] ice: refactor devlink_port to be per-VSI
> 
> Currently, the devlink_port structure is stored within the ice_pf. This
> made sense because we create a single devlink_port for each PF. This
> setup does not mesh with the abstractions in the driver very well, and
> led to a flow where we accidentally call devlink_port_unregister twice
> during error cleanup.
> 
> In particular, if devlink_port_register or devlink_port_unregister are
> called twice, this leads to a kernel panic. This appears to occur during
> some possible flows while cleaning up from a failure during driver
> probe.
> 
> If register_netdev fails, then we will call devlink_port_unregister in
> ice_cfg_netdev as it cleans up. Later, we again call
> devlink_port_unregister since we assume that we must cleanup the port
> that is associated with the PF structure.
> 
> This occurs because we cleanup the devlink_port for the main PF even
> though it was not allocated. We allocated the port within a per-VSI
> function for managing the main netdev, but did not release the port when
> cleaning up that VSI, the allocation and destruction are not aligned.
> 
> Instead of attempting to manage the devlink_port as part of the PF
> structure, manage it as part of the PF VSI. Doing this has advantages,
> as we can match the de-allocation of the devlink_port with the
> unregister_netdev associated with the main PF VSI.
> 
> Moving the port to the VSI is preferable as it paves the way for
> handling devlink ports allocated for other purposes such as SR-IOV VFs.
> 
> Since we're changing up how we allocate the devlink_port, also change
> the indexing. Originally, we indexed the port using the PF id number.
> This came from an old goal of sharing a devlink for each physical
> function. Managing devlink instances across multiple function drivers is
> not workable. Instead, lets set the port number to the logical port
> number returned by firmware and set the index using the VSI index
> (sometimes referred to as VSI handle).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  7 +--
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 54 ++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_devlink.h |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++-
>  5 files changed, 45 insertions(+), 33 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
