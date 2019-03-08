From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:49:12 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 03/17] ice: Fix issue
 reconfiguring VF queues
In-Reply-To: <20190227003523.28733-4-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F4C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 03/17] ice: Fix issue reconfiguring VF
> queues
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> When VF requested for queues changes, we need to update LAN Tx queue
> with correct number of VF queue pairs and re-allocate VF resources based on
> this new requested number of queues, which is constraint within maximum
> queue supported per VF.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 33 +++++++++++---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 58
> ++++++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  1 +
>  3 files changed, 76 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


