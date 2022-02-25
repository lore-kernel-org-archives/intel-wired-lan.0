From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:23:40 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 08/11] ice: convert
 ice_for_each_vf to include VF entry iterator
In-Reply-To: <20220216213738.3826664-9-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
 <20220216213738.3826664-9-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB56293CD88A500326787BB5F4AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH v2 08/11] ice: convert
> ice_for_each_vf to include VF entry iterator
> 
> The ice_for_each_vf macro is intended to be used to loop over all VFs.
> The current implementation relies on an iterator that is the index into the VF
> array in the PF structure. This forces all users to perform a look up
> themselves.
> 
> This abstraction forces a lot of duplicate work on callers and leaks the
> interface implementation to the caller. Replace this with an implementation
> that includes the VF pointer the primary iterator. This version simplifies
> callers which just want to iterate over every VF, as they no longer need to
> perform their own lookup.
> 
> The "i" iterator value is replaced with a new unsigned int "bkt"
> parameter, as this will match the necessary interface for replacing the VF
> array with a hash table. For now, the bkt is the VF ID, but in the future it will
> simply be the hash bucket index. Document that it should not be treated as a
> VF ID.
> 
> This change aims to simplify switching from the array to a hash table. I
> considered alternative implementations such as an xarray but decided that
> the hash table was the simplest and most suitable implementation. I also
> looked at methods to hide the bkt iterator entirely, but I couldn't come up
> with a feasible solution that worked for hash table iterators.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  63 ++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  21 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  44 +++---
>  drivers/net/ethernet/intel/ice/ice_repr.c     |  15 +-
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    |   6 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 141 +++++++++---------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  16 +-
>  8 files changed, 162 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index e47331e363ea..aa16ea15c5ca 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -210,11 +210,11 @@ static void

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
