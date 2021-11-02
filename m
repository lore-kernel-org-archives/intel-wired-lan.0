From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:03:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next 6/7] ice: refactor PTYPE
 validating
In-Reply-To: <20210716221644.45946-7-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
 <20210716221644.45946-7-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB422457026C8A375B4073C8C6828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, July 16, 2021 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 6/7] ice: refactor PTYPE validating
> 
> From: Jeff Guo <jia.guo@intel.com>
> 
> Since the capability of a PTYPE within a specific package could be negotiated
> by checking the HW bit map, it means that there's no need to maintain a
> different PTYPE list for each type of the package when parsing PTYPE. So
> refactor the PTYPE validating mechanism.
> 
> Signed-off-by: Jeff Guo <jia.guo@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  22 ++
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 274 +-----------------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 207 ++++++-------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   2 +
>  4 files changed, 133 insertions(+), 372 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


