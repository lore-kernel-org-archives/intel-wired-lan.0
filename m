From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:20:27 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 02/11] ice: store VF
 pointer instead of VF ID
In-Reply-To: <20220216213738.3826664-3-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-3-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5629E9B911D5B88E567D8ED0AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 16, 2022 10:37 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 02/11] ice: store VF pointer
> instead of VF ID
> 
> The VSI structure contains a vf_id field used to associate a VSI with a VF. This
> is used mainly for ICE_VSI_VF as well as partially for ICE_VSI_CTRL associated
> with the VFs.
> 
> This API was designed with the idea that VFs are stored in a simple array that
> was expected to be static throughout most of the driver's life.
> 
> We plan on refactoring VF storage in a few key ways:
> 
>   1) converting from a simple static array to a hash table
>   2) using krefs to track VF references obtained from the hash table
>   3) use RCU to delay release of VF memory until after all references
>      are dropped
> 
> This is motivated by the goal to ensure that the lifetime of VF structures is
> accounted for, and prevent various use-after-free bugs.
> 
> With the existing vsi->vf_id, the reference tracking for VFs would become
> somewhat convoluted, because each VSI maintains a vf_id field which will
> then require performing a look up. This means all these flows will require
> reference tracking and proper usage of rcu_read_lock, etc.
> 
> We know that the VF VSI will always be backed by a valid VF structure,
> because the VSI is created during VF initialization and removed before the VF
> is destroyed. Rely on this and store a reference to the VF in the VSI structure
> instead of storing a VF ID. This will simplify the usage and avoid the need to
> perform lookups on the hash table in the future.
> 
> For ICE_VSI_VF, it is expected that vsi->vf is always non-NULL after
> ice_vsi_alloc succeeds. Because of this, use WARN_ON when checking if a
> vsi->vf pointer is valid when dealing with VF VSIs. This will aid in
> debugging code which violates this assumption and avoid more disastrous
> panics.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 178 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |  19 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   5 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   6 +-
>  10 files changed, 142 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index b562128e7024..9041b4428af0 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -109,7 +109,6 @@

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
