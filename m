Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E2EC25B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 13:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C351606D4;
	Fri, 31 May 2024 13:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h39PfAOax0gp; Fri, 31 May 2024 13:18:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EA816075D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717161493;
	bh=T6fvrEjVJfSqoxgRBve3k3aMO7sVj4wmfmXW/BSJC9c=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mdEdWu2gJGhiawAj5bQ/GzDMg3zxMn1+T1F4/IafhFIma5L4vol2/1wvseEhkSAG0
	 T51r1sEbFZfy40LYuXjs5XiL+eC4PBU13gD2Us+hpXW5IzLX+yBqux6AjEJQIRFOnr
	 YNfLn+VX4126eumM8ShsTttnEphZYFPB++58EUhy+O2cE/zv/8cJkYFtnK9zoBbUw/
	 GVMUeeu6Q2aHRLemztsSF7rWPPCsgcUa770rIMcCkifxj0PN/hZkCDx7fOyfXjNBp7
	 JCkPAtUItzDrlEQlyGVOGtP8IDVrgFBKqD3//kKIQIpj047eW/rg5CTeLIjVukZhoR
	 aZQpIb4E7rfuw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EA816075D;
	Fri, 31 May 2024 13:18:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3DF501D52B9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35A87423B7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRNeRNAGv4J8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 13:18:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9CE50417E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CE50417E0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CE50417E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:18:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A0257CE1B3D;
 Fri, 31 May 2024 13:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E00C116B1;
 Fri, 31 May 2024 13:18:04 +0000 (UTC)
Date: Fri, 31 May 2024 14:18:02 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240531131802.GG123401@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-12-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527185810.3077299-12-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717161486;
 bh=ccYr377cEwPSuGbW2X6NZwvsaM0OkIN44A0NOv2OZn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R/pLSpKPnORuFK/WmMuBa6OLi/EtMkBm6++1+VFf0oA9z1XGksZttKmjKbC1zzq2A
 qzLVbmk1/s5H6oPo84MubkpqVYP897+HVjmyRtbnj86Nhei3a/yzlHCm/8py2lzzoF
 vo2clPGXRN/ufeC1lZkPlzkhuU0RhKS1XtIlCVRy0i0/JRKCmWofPKQkn8b0OFyO5m
 ZD+/dpW8rSX7GLKLrq7op236QOYSBxU8Zbol5dpakx5zkFH8VwFxJsFDhsRW2MjSdS
 mpwPZoG08imKqbUGiTr6mUPML8N9H/buFTAfftYgt1IaQPpFnG7skWNkyBE+T9Y6YE
 9f+fDBVW9HCMA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=R/pLSpKP
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 11/13] ice: enable FDIR
 filters from raw binary patterns for VFs
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: Junfeng Guo <junfeng.guo@intel.com>, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, May 27, 2024 at 12:58:08PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Enable VFs to create FDIR filters from raw binary patterns.
> The corresponding processes for raw flow are added in the
> Parse / Create / Destroy stages.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c

...

> +/**
> + * ice_flow_set_parser_prof - Set flow profile based on the parsed profile info
> + * @hw: pointer to the HW struct
> + * @dest_vsi: dest VSI
> + * @fdir_vsi: fdir programming VSI
> + * @prof: stores parsed profile info from raw flow
> + * @blk: classification blk
> + */
> +int
> +ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> +			 struct ice_parser_profile *prof, enum ice_block blk)
> +{
> +	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> +	struct ice_flow_prof_params *params __free(kfree);
> +	u8 fv_words = hw->blk[blk].es.fvw;
> +	int status;
> +	int i, idx;
> +
> +	params = kzalloc(sizeof(*params), GFP_KERNEL);
> +	if (!params)
> +		return -ENOMEM;


params seems to be leaked when this function returns below,
in both error and non-error cases.

> +
> +	for (i = 0; i < ICE_MAX_FV_WORDS; i++) {
> +		params->es[i].prot_id = ICE_PROT_INVALID;
> +		params->es[i].off = ICE_FV_OFFSET_INVAL;
> +	}
> +
> +	for (i = 0; i < prof->fv_num; i++) {
> +		if (hw->blk[blk].es.reverse)
> +			idx = fv_words - i - 1;
> +		else
> +			idx = i;
> +		params->es[idx].prot_id = prof->fv[i].proto_id;
> +		params->es[idx].off = prof->fv[i].offset;
> +		params->mask[idx] = (((prof->fv[i].msk) << BITS_PER_BYTE) &
> +				      HI_BYTE_IN_WORD) |
> +				    (((prof->fv[i].msk) >> BITS_PER_BYTE) &
> +				      LO_BYTE_IN_WORD);
> +	}
> +
> +	switch (prof->flags) {
> +	case FLAG_GTPU_DW:
> +		params->attr = ice_attr_gtpu_down;
> +		params->attr_cnt = ARRAY_SIZE(ice_attr_gtpu_down);
> +		break;
> +	case FLAG_GTPU_UP:
> +		params->attr = ice_attr_gtpu_up;
> +		params->attr_cnt = ARRAY_SIZE(ice_attr_gtpu_up);
> +		break;
> +	default:
> +		if (prof->flags_msk & FLAG_GTPU_MSK) {
> +			params->attr = ice_attr_gtpu_session;
> +			params->attr_cnt = ARRAY_SIZE(ice_attr_gtpu_session);
> +		}
> +		break;
> +	}
> +
> +	status = ice_add_prof(hw, blk, id, (u8 *)prof->ptypes,
> +			      params->attr, params->attr_cnt,
> +			      params->es, params->mask, false, false);
> +	if (status)
> +		return status;
> +
> +	status = ice_flow_assoc_fdir_prof(hw, blk, dest_vsi, fdir_vsi, id);
> +	if (status)
> +		ice_rem_prof(hw, blk, id);
> +
> +	return status;
> +}

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 5635e9da2212..9138f7783da0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2022, Intel Corporation. */
>  
> -#include "ice_vf_lib_private.h"
>  #include "ice.h"
> +#include "ice_vf_lib_private.h"
>  #include "ice_lib.h"
>  #include "ice_fltr.h"
>  #include "ice_virtchnl_allowlist.h"

To me tweaking the order of includes seems to indicate
that something isn't quite right. Is there some sort of
dependency loop being juggled here?

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> index fec16919ec19..be4266899690 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> @@ -12,6 +12,7 @@
>  #include <net/devlink.h>
>  #include <linux/avf/virtchnl.h>
>  #include "ice_type.h"
> +#include "ice_flow.h"
>  #include "ice_virtchnl_fdir.h"
>  #include "ice_vsi_vlan_ops.h"
>  

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index 1c6ce0c4ed4e..886869648c91 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2022, Intel Corporation. */
>  
> +#include "ice.h"
>  #include "ice_virtchnl.h"
>  #include "ice_vf_lib_private.h"
> -#include "ice.h"
>  #include "ice_base.h"
>  #include "ice_lib.h"
>  #include "ice_fltr.h"

...

> @@ -784,6 +798,106 @@ ice_vc_fdir_config_input_set(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
>  	return ret;
>  }
>  
> +/**
> + * ice_vc_fdir_is_raw_flow
> + * @proto: virtchnl protocol headers
> + *
> + * Check if the FDIR rule is raw flow (protocol agnostic flow) or not.
> + * Note that common FDIR rule must have non-zero proto->count.
> + * Thus, we choose the tunnel_level and count of proto as the indicators.
> + * If both tunnel_level and count of proto are zeros, this FDIR rule will
> + * be regarded as raw flow.
> + *
> + * Returns wheater headers describe raw flow or not.
> + */
> +static bool
> +ice_vc_fdir_is_raw_flow(struct virtchnl_proto_hdrs *proto)
> +{
> +	return (proto->tunnel_level == 0 && proto->count == 0);

nit: Parentheses are not needed here.
     Likewise elsewhere.

> +
> +/**
> + * ice_vc_fdir_parse_raw
> + * @vf: pointer to the VF info
> + * @proto: virtchnl protocol headers
> + * @conf: FDIR configuration for each filter
> + *
> + * Parse the virtual channel filter's raw flow and store it in @conf
> + *
> + * Return: 0 on success, and other on error.
> + */
> +static int
> +ice_vc_fdir_parse_raw(struct ice_vf *vf,
> +		      struct virtchnl_proto_hdrs *proto,
> +		      struct virtchnl_fdir_fltr_conf *conf)
> +{
> +	u8 *pkt_buf, *msk_buf __free(kfree);
> +	struct ice_parser_result rslt;
> +	struct ice_pf *pf = vf->pf;
> +	struct ice_parser *psr;
> +	int status = -ENOMEM;
> +	struct ice_hw *hw;
> +	u16 udp_port = 0;
> +
> +	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> +	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);

msk_buf appears to be leaked both in when this function
returns for both error and non-error cases.

> +	if (!pkt_buf || !msk_buf)
> +		goto err_mem_alloc;
> +
> +	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
> +	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
> +
> +	hw = &pf->hw;
> +
> +	/* Get raw profile info via Parser Lib */
> +	psr = ice_parser_create(hw);
> +	if (IS_ERR(psr)) {
> +		status = PTR_ERR(psr);
> +		goto err_mem_alloc;
> +	}
> +
> +	ice_parser_dvm_set(psr, ice_is_dvm_ena(hw));
> +
> +	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
> +		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
> +
> +	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
> +	if (status)
> +		goto err_parser_destroy;
> +
> +	if (hw->debug_mask & ICE_DBG_PARSER)
> +		ice_parser_result_dump(hw, &rslt);
> +
> +	conf->prof = kzalloc(sizeof(*conf->prof), GFP_KERNEL);
> +	if (!conf->prof)
> +		goto err_parser_destroy;
> +
> +	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
> +					 proto->raw.pkt_len, ICE_BLK_FD,
> +					 conf->prof);
> +	if (status)
> +		goto err_parser_profile_init;
> +
> +	if (hw->debug_mask & ICE_DBG_PARSER)
> +		ice_parser_profile_dump(hw, conf->prof);
> +
> +	/* Store raw flow info into @conf */
> +	conf->pkt_len = proto->raw.pkt_len;
> +	conf->pkt_buf = pkt_buf;
> +	conf->parser_ena = true;
> +
> +	ice_parser_destroy(psr);
> +	return 0;
> +
> +err_parser_profile_init:
> +	kfree(conf->prof);
> +err_parser_destroy:
> +	ice_parser_destroy(psr);
> +err_mem_alloc:
> +	kfree(pkt_buf);
> +	return status;
> +}

...
