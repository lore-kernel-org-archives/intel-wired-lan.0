From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Mar 2019 20:31:12 +0000
Subject: [Intel-wired-lan] [PATCH S16 09/11] ice: Add code for DCB
 rebuild
In-Reply-To: <20190228232432.31659-10-anirudh.venkataramanan@intel.com>
References: <20190228232432.31659-1-anirudh.venkataramanan@intel.com>
 <20190228232432.31659-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368B75@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S16 09/11] ice: Add code for DCB rebuild
> 
> This patch introduces a new function ice_dcb_rebuild which reinitializes DCB
> after a reset.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 78
> ++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  5 ++
>  drivers/net/ethernet/intel/ice/ice_main.c    |  2 +
>  3 files changed, 85 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


