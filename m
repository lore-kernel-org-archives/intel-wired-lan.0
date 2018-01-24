From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 23:33:39 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 11/12] i40evf: Add
 support to apply cloud filters
In-Reply-To: <20180123165106.28900-12-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
 <20180123165106.28900-12-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A2E3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Tuesday, January 23, 2018 8:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 11/12] i40evf: Add support
> to apply cloud filters
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch enables a tc filter to be applied as a cloud filter for the VF. This
> patch adds functions which parse the tc filter, extract the necessary fields
> needed to configure the filter and package them in a virtchnl message to be
> sent to the PF to apply them.
> 
> v3: Fixes for endian-ness.
> v2: made i40evf_print_cloud_filter function static.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  48 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 578
> ++++++++++++++++++++-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 187 +++++++
>  3 files changed, 809 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


