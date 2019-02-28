From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:45:36 +0000
Subject: [Intel-wired-lan] [PATCH S14 09/15] ice: change VF VSI tc info
 along with num_queues
In-Reply-To: <20190213185115.25877-10-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36720E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 09/15] ice: change VF VSI tc info along
> with num_queues
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Update VF VSI tc info along with vsi->num_txq/num_rxq when VF requests
> to configure queues.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


