From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:18:06 +0000
Subject: [Intel-wired-lan] [PATCH S35 04/15] ice: Add ice_for_each_vf()
 macro
In-Reply-To: <20191212111307.33566-4-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-4-anthony.l.nguyen@intel.com>
Message-ID: <38d6b3dee7014593aa36c2c3619f6c31@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 04/15] ice: Add ice_for_each_vf()
> macro
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we do "for (i = 0; i < pf->num_alloc_vfs; i++)" all over the place.
> Many other places use macros to contain this repeated for loop, So create
> the macro ice_for_each_vf(pf, i) that does the same thing.
> 
> There were a couple places we were using one loop variable and a VF
> iterator, which were changed to using a local variable within the
> ice_for_each_vf() macro.
> 
> Also in ice_alloc_vfs() we were setting pf->num_alloc_vfs after doing "for (i =
> 0; i < num_alloc_vfs; i++)". Instead assign pf->num_alloc_vfs right after
> allocating memory for the pf->vf array.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  7 ++++--
>  drivers/net/ethernet/intel/ice/ice_main.c     |  4 ++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 23 ++++++++++---------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  3 +++
>  4 files changed, 22 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


