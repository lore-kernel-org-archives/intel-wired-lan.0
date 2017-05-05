From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 May 2017 18:09:08 +0000
Subject: [Intel-wired-lan] [net-next v2 04/13] virtchnl: rename i40e
	to	generic virtchnl
In-Reply-To: <20170504093528.76047-5-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
 <20170504093528.76047-5-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA2880@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, May 4, 2017 2:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next v2 04/13] virtchnl: rename i40e to generic
> virtchnl
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This morphs all the i40e and i40evf references to/in virtchnl.h
> to be generic, using only automated methods. Updates all the
> callers to use the new names.  A followup patch provides separate
> clean ups for messy line conversions from these "automatic"
> changes, to make them more reviewable.
> 
> Was executed with the following sed script:
> sed -i -f transform_script drivers/net/ethernet/intel/i40e/i40e_client.c
> sed -i -f transform_script drivers/net/ethernet/intel/i40e/i40e_prototype.h
> sed -i -f transform_script drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> sed -i -f transform_script drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> sed -i -f transform_script drivers/net/ethernet/intel/i40evf/i40e_common.c
> sed -i -f transform_script
> drivers/net/ethernet/intel/i40evf/i40e_prototype.h
> sed -i -f transform_script drivers/net/ethernet/intel/i40evf/i40evf.h
> sed -i -f transform_script drivers/net/ethernet/intel/i40evf/i40evf_client.c
> sed -i -f transform_script drivers/net/ethernet/intel/i40evf/i40evf_main.c
> sed -i -f transform_script drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
> sed -i -f transform_script include/linux/avf/virtchnl.h
> 
> transform_script:
> ----8<----
> s/I40E_VIRTCHNL_SUPPORTED_QTYPES/SAVE_ME_SUPPORTED_QTYPES/g
> s/I40E_VIRTCHNL_VF_CAP/SAVE_ME_VF_CAP/g
> 
> s/I40E_VIRTCHNL_/VIRTCHNL_/g
> s/i40e_virtchnl_/virtchnl_/g
> s/I40E_QUEUE_TYPE_PE_AEQ/QUEUE_TYPE_PE_AEQ/g
> s/I40E_QUEUE_INVALID_IDX/QUEUE_INVALID_IDX/g
> s/i40e_vfr_/virtchnl_vfr_/g
> s/I40E_VFR_/VIRTCHNL_VFR_/g
> 
> s/VIRTCHNL_OP_ADD_ETHER_ADDRESS/VIRTCHNL_OP_ADD_ETH_ADDR/g
> s/VIRTCHNL_OP_DEL_ETHER_ADDRESS/VIRTCHNL_OP_DEL_ETH_ADDR/g
> s/VIRTCHNL_OP_FCOE/VIRTCHNL_OP_RSVD/g
> 
> s/SAVE_ME_SUPPORTED_QTYPES/I40E_VIRTCHNL_SUPPORTED_QTYPES/g
> s/SAVE_ME_VF_CAP/I40E_VIRTCHNL_VF_CAP/g
> ----8<----
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


