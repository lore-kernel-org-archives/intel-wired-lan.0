From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:45:03 +0000
Subject: [Intel-wired-lan] [PATCH S41 07/15] ice: Fix casting issues
In-Reply-To: <20200508004113.39725-7-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-7-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659DCC5B18488B59BC1B7DE8CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S41 07/15] ice: Fix casting issues
> 
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Change min() macros to min_t() which has compare type specified and it
> helps avoid precision loss.
> 
> In some cases there was precision loss during calls or assignments.
> Some fields in structs were unnecessarily large and gave multiple warnings.
> 
> There were also some minor type differences which are now fixed as well as
> some cases where a simple cast was needed.
> 
> Callers were were passing data that is a u16 to
> ice_sched_cfg_node_bw_alloc() but the function was truncating that to a u8.
> Fix that by changing the function to take a u16.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 10 +++----
>  drivers/net/ethernet/intel/ice/ice_base.c     | 24 ++++++++-------
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  2 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  6 ++--
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 13 +++++----
>  drivers/net/ethernet/intel/ice/ice_idc.c      |  5 ++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 29 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 13 +++++----
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 12 ++++----
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 ++++++------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |  4 +--
>  14 files changed, 77 insertions(+), 66 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


