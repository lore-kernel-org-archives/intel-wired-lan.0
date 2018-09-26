From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:10:43 +0000
Subject: [Intel-wired-lan] [PATCH v2 08/16] ice: Notify VF of link
 status change
In-Reply-To: <20180920004308.13772-9-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC65E@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 08/16] ice: Notify VF of link status
> change
> 
> When PF gets a link status change event, notify the VFs of the same.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c        |  2 ++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  3 +++
>  3 files changed, 17 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


