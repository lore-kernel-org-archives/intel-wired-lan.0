From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:25:32 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 11/11] ice: convert VF
 storage to hash table with krefs and RCU
In-Reply-To: <20220216213738.3826664-12-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-12-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56293A38722D40F48CCD997AAB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 16, 2022 10:38 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 11/11] ice: convert VF storage
> to hash table with krefs and RCU
> 
> The ice driver stores VF structures in a simple array which is allocated once at
> the time of VF creation. The VF structures are then accessed from the array
> by their VF ID. The ID must be between 0 and the number of allocated VFs.
> 
> Multiple threads can access this table:
> 
>  * .ndo operations such as .ndo_get_vf_cfg or .ndo_set_vf_trust
>  * interrupts, such as due to messages from the VF using the virtchnl
>    communication
>  * processing such as device reset
>  * commands to add or remove VFs
> 
> The current implementation does not keep track of when all threads are
> done operating on a VF and can potentially result in use-after-free issues
> caused by one thread accessing a VF structure after it has been released
> when removing VFs. Some of these are prevented with various state flats
> and checks.
> 
> In addition, this structure is quite static and does not support a planned
> future where virtualization can be more dynamic. As we begin to look at
> supporting Scalable IOV with the ice driver (as opposed to just supporting
> Single Root IOV), this structure is not sufficient.
> 
> In the future, VFs will be able to be added and removed individually and
> dynamically.
> 
> To allow for this, and to better protect against a whole class of use-after-free
> bugs, replace the VF storage with a combination of a hash table and krefs to
> reference track all of the accesses to VFs through the hash table.
> 
> A hash table still allows efficient look up of the VF given its ID, but also allows
> adding and removing VFs. It does not require contiguous VF IDs.
> 
> The use of krefs allows the cleanup of the VF memory to be delayed until
> after all threads have released their reference (by calling ice_put_vf).
> 
> To prevent corruption of the hash table, a combination of RCU and the
> mutex table_lock are used. Addition and removal from the hash table use
> the RCU-aware hash macros. This allows simple read-only look ups that
> iterate to locate a single VF can be fast using RCU. Accesses which modify the
> hash table, or which can't take RCU because they sleep, will hold the mutex
> lock.
> 
> By using this design, we have a stronger guarantee that the VF structure can't
> be released until after all threads are finished operating on it.
> We also pave the way for the more dynamic Scalable IOV implementation in
> the future.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  16 +
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  13 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  24 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   8 +
>  drivers/net/ethernet/intel/ice/ice_repr.c     |   4 +
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   2 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 377 +++++++++++++-----
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  45 ++-
>  8 files changed, 364 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index c27013afcadb..9a84d746a6c4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -209,6 +209,8 @@ static void

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
