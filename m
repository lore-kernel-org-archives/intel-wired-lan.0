From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jul 2020 16:56:34 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ice: replace single-element array
 used for C struct hack
In-Reply-To: <20200630002746.64140-2-anthony.l.nguyen@intel.com>
References: <20200630002746.64140-1-anthony.l.nguyen@intel.com>
 <20200630002746.64140-2-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145D1DF056D08557ABF14058C6C0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, June 29, 2020 5:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ice: replace single-element array used
> for C struct hack
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Convert the pre-C90-extension "C struct hack" method (using a single-
> element array at the end of a structure for implementing variable-length
> types) to the preferred use of C99 flexible array member.
> 
> Additional code cleanups were done near areas affected by this change.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 23 +++---
>  drivers/net/ethernet/intel/ice/ice_base.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   | 74 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_dcb.h      |  4 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 35 +++++----
>  .../net/ethernet/intel/ice/ice_flex_type.h    | 39 +++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  4 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 36 ++++-----
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 +-
>  10 files changed, 111 insertions(+), 114 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


