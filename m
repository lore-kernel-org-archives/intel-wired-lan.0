From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:33:56 +0000
Subject: [Intel-wired-lan] [PATCH S18 04/15] ice: Add more validation in
 ice_vc_cfg_irq_map_msg
In-Reply-To: <20190416172128.27184-5-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3998CC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 04/15] ice: Add more validation in
> ice_vc_cfg_irq_map_msg
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Add few checks to validate msg from iavf driver.
> 
> Test if we have got enough q_vectors allocated in VSI connected with VF.
> Add masks for itr_indx and msix_indx to avoid writing to reserved fieldi of
> QINT. Clear q_vector->num_ring_rx/tx, without it we can increment this
> value every time we send irq map msg from VF. So after second call this
> value will be incorrect.
> 
> Decrement num_vectors from msg, because last vector in iavf msg is misc
> vector (we don't set map for it).
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  4 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 32 +++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 26 +++++++--------
>  4 files changed, 36 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


