From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:16:26 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 10/15] ice: update
 GLINT_DYN_CTL and GLINT_VECT2FUNC register access
In-Reply-To: <20190628150332.59155-10-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-10-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD173@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 10/15] ice: update GLINT_DYN_CTL
> and GLINT_VECT2FUNC register access
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Register access for GLINT_DYN_CTL and GLINT_VECT2FUNC should be within
> the PF space and not the absolute device space.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 24 +++++++++++--------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  3 ++-
>  2 files changed, 16 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


