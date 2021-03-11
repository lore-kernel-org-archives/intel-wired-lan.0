From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Mar 2021 00:02:34 +0000
Subject: [Intel-wired-lan] [PATCH S55 05/14] ice: Update to use package
 info from ice segment
In-Reply-To: <20210302181213.51718-5-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-5-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51057CFF8FF377AD5CB890A1FA909@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 05/14] ice: Update to use package info
> from ice segment
> 
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> There are two package versions in the package binary. Today, these two
> version numbers are the same. However, in the future that may change.
> 
> Update code to use the package info from the ice segment metadata
> section, which is the package information that is actually downloaded to the
> firmware during the download package process.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 40 ++++++++++---------
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  9 +++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |  8 ++--
>  4 files changed, 36 insertions(+), 22 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


