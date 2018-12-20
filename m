From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:38:35 +0000
Subject: [Intel-wired-lan] [PATCH S10 08/15] ice: Rework queue
 manangement code for reuse
In-Reply-To: <20181219180334.1104-9-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A48@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 08/15] ice: Rework queue
> manangement code for reuse
> 
> This patch reworks the queue management code to allow for reuse with the
> XDP feature (to be added in a future patch).
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  11 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 234 ++++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_lib.h         |   5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c        |   6 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  24 ++-
>  5 files changed, 157 insertions(+), 123 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


