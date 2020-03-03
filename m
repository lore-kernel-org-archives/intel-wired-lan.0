From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:04:15 +0000
Subject: [Intel-wired-lan] [PATCH S40 02/15] ice: allow bigger VFs
In-Reply-To: <20200227181505.61720-2-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-2-anthony.l.nguyen@intel.com>
Message-ID: <6ff907bc96344255b6fee7b967def5d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 02/15] ice: allow bigger VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Unlike the XL710 series, 800-series hardware can allocate more than 4 MSI-X
> vectors per VF. This patch enables that functionality. We dynamically allocate
> vectors and queues depending on how many VFs are enabled. Allocating the
> maximum number of VFs replicates XL710 behavior with 4 queues and 4
> vectors. But allocating a smaller number of VFs will give you 16 queues and 16
> vectors.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   9 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 279 +++++++++---------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  15 +-
>  4 files changed, 146 insertions(+), 158 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


