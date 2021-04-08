From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 19:54:22 +0000
Subject: [Intel-wired-lan] [PATCH S58 01/13] ice: refactor interrupt
 moderation writes
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105A4A7F6C5B0C0BB7091B7FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 01/13] ice: refactor interrupt
> moderation writes
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Introduce several new helpers for writing ITR and GLINT_RATE registers, and
> refactor the code calling them.  This resulted in removal of several duplicate
> functions and rolled a bunch of simple code back into the calling routines.
> 
> In particular this removes some code that was doing both a store and a set in
> a helper function, which seems better done as separate tasks in the caller
> (and generally takes less lines of code even with a tiny bit of repetition).
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  22 +--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  17 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 171 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   3 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c     |   3 -
>  5 files changed, 112 insertions(+), 104 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


