From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:49:28 +0000
Subject: [Intel-wired-lan] [PATCH S21 02/14] ice: Add support for
 virtchnl_vector_map.[rxq|txq]_map
In-Reply-To: <20190416173503.29847-3-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AF5D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 02/14] ice: Add support for
> virtchnl_vector_map.[rxq|txq]_map
> 
> Add support for virtchnl_vector_map.[rxq|txq]_map to use bitmap to
> associate indicated queues with the specified vector. This support is needed
> since the Windows AVF driver calls VIRTCHNL_OP_CONFIG_IRQ_MAP for
> each vector and used the bitmap to indicate the associated queues.
> 
> Updated ice_vc_dis_qs_msg to not subtract one from
> virtchnl_irq_map_info.num_vectors, and changed the VSI vector index to
> the vector id. This change supports the Windows AVF driver which maps one
> vector at a time and sets num_vectors to one. Using vectors_id to index the
> vector array .
> 
> Add check for vector_id zero, and return VIRTCHNL_STATUS_ERR_PARAM if
> vector_id is zero and there are rings associated with that vector.
> Vector_id zero is for the OICR.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> squashed
> multiple commits]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 108 ++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   8 ++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  43 +++++--
>  3 files changed, 115 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


