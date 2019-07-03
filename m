From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:19:38 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 13/15] ice: Move VF resources
 definition to SR-IOV specific file
In-Reply-To: <20190628150332.59155-13-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-13-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD1A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 13/15] ice: Move VF resources
> definition to SR-IOV specific file
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> In order to use some of the VF resources definition in the SR-IOV specific
> virtchnl header file, this patch moves applicable code to ice_virtchnl_pf.h file
> accordingly... and they should have been defined in the destination file
> originally.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             | 10 ----------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


