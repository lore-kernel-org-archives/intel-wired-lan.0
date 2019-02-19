From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 19 Feb 2019 22:27:41 +0000
Subject: [Intel-wired-lan] [next-queue] fm10k: add missing field
 initializers to TLV attributes)
In-Reply-To: <20190219171704.2852-1-jacob.e.keller@intel.com>
References: <20190219171704.2852-1-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB589230613F@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Tuesday, February 19, 2019 9:17 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; nosbuild <nosbuild@intel.com>
> Subject: [next-queue] fm10k: add missing field initializers to TLV attributes)
> 
> From: "nosbuild (Code Review)" <nosbuild@intel.com>
> 

Not quite sure how the authorship got screwed up here. I've sent a v2 with this corrected.

Thanks,
Jake

> Add the missing field initializers for a couple of the TLV attribute
> macros. This resolves the last few -Wmissing-field-initializers warnings
> for the fm10k Linux driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
> b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
> index 160bc5b78f99..ceb9b791f799 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2013 - 2018 Intel Corporation. */
> +/* Copyright(c) 2013 - 2019 Intel Corporation. */
> 
>  #ifndef _FM10K_TLV_H_
>  #define _FM10K_TLV_H_
> @@ -76,8 +76,8 @@ struct fm10k_tlv_attr {
>  #define FM10K_TLV_ATTR_S32(id)		    { id, FM10K_TLV_SIGNED, 4 }
>  #define FM10K_TLV_ATTR_S64(id)		    { id, FM10K_TLV_SIGNED, 8 }
>  #define FM10K_TLV_ATTR_LE_STRUCT(id, len)   { id, FM10K_TLV_LE_STRUCT, len }
> -#define FM10K_TLV_ATTR_NESTED(id)	    { id, FM10K_TLV_NESTED }
> -#define FM10K_TLV_ATTR_LAST		    { FM10K_TLV_ERROR }
> +#define FM10K_TLV_ATTR_NESTED(id)	    { id, FM10K_TLV_NESTED, 0 }
> +#define FM10K_TLV_ATTR_LAST		    { FM10K_TLV_ERROR, 0, 0 }
> 
>  struct fm10k_msg_data {
>  	unsigned int		    id;
> --
> 2.18.0.219.gaf81d287a9da

