From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 19:02:01 +0000
Subject: [Intel-wired-lan] [PATCH v7 2/2] i40e: add support for XDP_TX
 action
In-Reply-To: <20170524055535.14155-3-bjorn.topel@gmail.com>
References: <20170524055535.14155-1-bjorn.topel@gmail.com>
 <20170524055535.14155-3-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA413B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Tuesday, May 23, 2017 10:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com
> Cc: daniel at iogearbox.net; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 2/2] i40e: add support for XDP_TX action
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This patch adds proper XDP_TX action support. For each Tx ring, an additional
> XDP Tx ring is allocated and setup. This version does the DMA mapping in the
> fast-path, which will penalize performance for IOMMU enabled systems.
> Further, debugfs support is not wired up for the XDP Tx rings.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  42 +++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 277
> +++++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 118 ++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  11 +
>  5 files changed, 373 insertions(+), 76 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


