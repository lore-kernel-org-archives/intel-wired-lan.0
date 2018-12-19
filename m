From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Dec 2018 19:54:54 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Remove umem from VSI
In-Reply-To: <20181218134514.6388-2-jan.sokolowski@intel.com>
References: <20181218134514.6388-1-jan.sokolowski@intel.com>
 <20181218134514.6388-2-jan.sokolowski@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343804@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jan Sokolowski
> Sent: Tuesday, December 18, 2018 5:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Remove umem from VSI
> 
> As current implementation of netdev already contains and provides umems
> for us, we no longer have the need to contain these structures in i40e_vsi.
> 
> Refactor the code to operate on netdev-provided umems.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h     |  10 +-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 110 ++++-----------------
>  2 files changed, 21 insertions(+), 99 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


