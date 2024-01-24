Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7C2C46CD2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jan 2024 23:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4612541C51;
	Wed, 24 Jan 2024 23:10:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4612541C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706137821;
	bh=yE+mC0sHr2XIAYpzgG9iaKSXMcCVcDzV7Xk8xUKWoSo=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oz88ixXGjGvpJ7Pr3EsWnmeHKJkf6CbvVMPGf8TkvQhXkEeW4IyXg4ZMgilfbluJX
	 JIlhlq5QPJ52wCT0Q6J/lUP9PqKVDO59uActHxqv1GeXtF5yE1+CtEcnHRUh1mWbtl
	 YrZDzA5yJLSib0O6lX60SRh9ldAqKspBGxf7las5Tu9v6tbv9qp21KXkooX2BA+ymr
	 pmSRrEkRRQ7tAGIgJnaBj+ye0mUaAcRXP7FfrQkPFLRf910VhRxsbInF4XmS8QK2h3
	 kEbpf7AxIJ2F55d3n21WHA3edor0egR7qrU1ooeLeygsjNxxWXCbXNSW5IUGNok/yM
	 q7FN8okpKExwA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RU9RPm_MXD61; Wed, 24 Jan 2024 23:10:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1690B41BF2;
	Wed, 24 Jan 2024 23:10:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1690B41BF2
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 3B7921BF82F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 23:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0939060E08
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 23:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0939060E08
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EITMjoSn3PAl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jan 2024 23:10:16 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CD1860E4E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 23:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CD1860E4E
Received: from [192.168.0.224] (ip5f5ae9a6.dynamic.kabel-deutschland.de
 [95.90.233.166])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF63C61E5FE03;
 Thu, 25 Jan 2024 00:09:34 +0100 (CET)
Message-ID: <ebe86644-46f1-4d42-a40f-835853358691@molgen.mpg.de>
Date: Thu, 25 Jan 2024 00:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lukasz Plachno <lukasz.plachno@intel.com>,
 Jakub Buchocki <jakubx.buchocki@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
References: <20240124152141.15077-1-lukasz.plachno@intel.com>
 <20240124152141.15077-3-lukasz.plachno@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240124152141.15077-3-lukasz.plachno@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 2/2] ice: Implement
 'flow-type ether' rules
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
Cc: brett.creeley@amd.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Lukasz, dear Jakub, dear Mateusz,


Thank you for your patch.

Am 24.01.24 um 16:21 schrieb Lukasz Plachno:
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.

Can you please elaborate on the implementation?

> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.

It’d be great, if you gave an example, how you tested this.


Kind regards,

Paul


> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 140 +++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
>   drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>   4 files changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index 9a1a04f5f146..d6fadc65a7a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -41,6 +41,8 @@ static struct in6_addr zero_ipv6_addr_mask = {
>   static int ice_fltr_to_ethtool_flow(enum ice_fltr_ptype flow)
>   {
>   	switch (flow) {
> +	case ICE_FLTR_PTYPE_NONF_ETH:
> +		return ETHER_FLOW;
>   	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
>   		return TCP_V4_FLOW;
>   	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
> @@ -72,6 +74,8 @@ static int ice_fltr_to_ethtool_flow(enum ice_fltr_ptype flow)
>   static enum ice_fltr_ptype ice_ethtool_flow_to_fltr(int eth)
>   {
>   	switch (eth) {
> +	case ETHER_FLOW:
> +		return ICE_FLTR_PTYPE_NONF_ETH;
>   	case TCP_V4_FLOW:
>   		return ICE_FLTR_PTYPE_NONF_IPV4_TCP;
>   	case UDP_V4_FLOW:
> @@ -137,6 +141,15 @@ int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd)
>   	memset(&fsp->m_ext, 0, sizeof(fsp->m_ext));
>   
>   	switch (fsp->flow_type) {
> +	case ETHER_FLOW:
> +		fsp->h_u.ether_spec.h_proto = rule->eth.type;
> +		fsp->m_u.ether_spec.h_proto = rule->eth_mask.type;
> +		ether_addr_copy(fsp->h_u.ether_spec.h_dest, rule->eth.dst);
> +		ether_addr_copy(fsp->m_u.ether_spec.h_dest, rule->eth_mask.dst);
> +		ether_addr_copy(fsp->h_u.ether_spec.h_source, rule->eth.src);
> +		ether_addr_copy(fsp->m_u.ether_spec.h_source,
> +				rule->eth_mask.src);
> +		break;
>   	case IPV4_USER_FLOW:
>   		fsp->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
>   		fsp->h_u.usr_ip4_spec.proto = 0;
> @@ -1193,6 +1206,111 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
>   	return 0;
>   }
>   
> +/**
> + * ice_fdir_vlan_valid - validate VLAN data for Flow Director rule
> + * @fsp: pointer to ethtool Rx flow specification
> + *
> + * Return: true if vlan data is valid, false otherwise
> + */
> +static bool ice_fdir_vlan_valid(struct ethtool_rx_flow_spec *fsp)
> +{
> +	if (fsp->m_ext.vlan_etype && !eth_type_vlan(fsp->h_ext.vlan_etype))
> +		return false;
> +
> +	if (fsp->m_ext.vlan_tci &&
> +	    ntohs(fsp->h_ext.vlan_tci) >= VLAN_N_VID)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * ice_set_ether_flow_seg
> + * @seg: flow segment for programming
> + * @eth_spec: mask data from ethtool
> + *
> + * Return: 0 on success and errno in case of error.
> + */
> +static int ice_set_ether_flow_seg(struct device *dev,
> +				  struct ice_flow_seg_info *seg,
> +				  struct ethhdr *eth_spec)
> +{
> +	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_ETH);
> +
> +	/* empty rules are not valid */
> +	if (is_zero_ether_addr(eth_spec->h_source) &&
> +	    is_zero_ether_addr(eth_spec->h_dest) &&
> +	    !eth_spec->h_proto)
> +		return -EINVAL;
> +
> +	/* Ethertype */
> +	if (eth_spec->h_proto == htons(0xFFFF)) {
> +		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_TYPE,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL, false);
> +	} else if (eth_spec->h_proto) {
> +		dev_warn(dev, "Only 0x0000 or 0xffff proto mask is allowed for flow-type ether");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Source MAC address */
> +	if (is_broadcast_ether_addr(eth_spec->h_source))
> +		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_SA,
> +				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL, false);
> +	else if (!is_zero_ether_addr(eth_spec->h_source))
> +		goto err_mask;
> +
> +	/* Destination MAC address */
> +	if (is_broadcast_ether_addr(eth_spec->h_dest))
> +		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_DA,
> +				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL, false);
> +	else if (!is_zero_ether_addr(eth_spec->h_dest))
> +		goto err_mask;
> +
> +	return 0;
> +
> +err_mask:
> +	dev_warn(dev, "Only 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff MAC address mask is allowed for flow-type ether");
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * ice_set_fdir_vlan_seg
> + * @seg: flow segment for programming
> + * @ext_masks: masks for additional RX flow fields
> + */
> +static int
> +ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
> +		      struct ethtool_flow_ext *ext_masks)
> +{
> +	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_VLAN);
> +
> +	if (ext_masks->vlan_etype) {
> +		if (ext_masks->vlan_etype != htons(0xFFFF))
> +			return -EOPNOTSUPP;
> +
> +		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_S_VLAN,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL, false);
> +	}
> +
> +	if (ext_masks->vlan_tci) {
> +		if (ext_masks->vlan_tci != htons(0xFFFF))
> +			return -EOPNOTSUPP;
> +
> +		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_C_VLAN,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL,
> +				 ICE_FLOW_FLD_OFF_INVAL, false);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
>    * @pf: PF structure
> @@ -1209,7 +1327,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>   	struct device *dev = ice_pf_to_dev(pf);
>   	enum ice_fltr_ptype fltr_idx;
>   	struct ice_hw *hw = &pf->hw;
> -	bool perfect_filter;
> +	bool perfect_filter = false;
>   	int ret;
>   
>   	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
> @@ -1262,6 +1380,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>   		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
>   					       &perfect_filter);
>   		break;
> +	case ETHER_FLOW:
> +		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
> +		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
> +			if (!ice_fdir_vlan_valid(fsp)) {
> +				ret = -EINVAL;
> +				break;
> +			}
> +			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
> +		}
> +		break;
>   	default:
>   		ret = -EINVAL;
>   	}
> @@ -1823,6 +1951,16 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
>   		input->mask.v6.tc = fsp->m_u.usr_ip6_spec.tclass;
>   		input->mask.v6.proto = fsp->m_u.usr_ip6_spec.l4_proto;
>   		break;
> +	case ETHER_FLOW:
> +		ether_addr_copy(input->eth.dst, fsp->h_u.ether_spec.h_dest);
> +		ether_addr_copy(input->eth.src, fsp->h_u.ether_spec.h_source);
> +		ether_addr_copy(input->eth_mask.dst,
> +				fsp->m_u.ether_spec.h_dest);
> +		ether_addr_copy(input->eth_mask.src,
> +				fsp->m_u.ether_spec.h_source);
> +		input->eth.type = fsp->h_u.ether_spec.h_proto;
> +		input->eth_mask.type = fsp->m_u.ether_spec.h_proto;
> +		break;
>   	default:
>   		/* not doing un-parsed flow types */
>   		return -EINVAL;
> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
> index 1f7b26f38818..5fe0bad00fd7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
> @@ -4,6 +4,8 @@
>   #include "ice_common.h"
>   
>   /* These are training packet headers used to program flow director filters. */
> +static const u8 ice_fdir_eth_pkt[22] = {0};
> +
>   static const u8 ice_fdir_tcpv4_pkt[] = {
>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>   	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x45, 0x00,
> @@ -416,6 +418,11 @@ static const u8 ice_fdir_ip6_tun_pkt[] = {
>   
>   /* Flow Director no-op training packet table */
>   static const struct ice_fdir_base_pkt ice_fdir_pkt[] = {
> +	{
> +		ICE_FLTR_PTYPE_NONF_ETH,
> +		sizeof(ice_fdir_eth_pkt), ice_fdir_eth_pkt,
> +		sizeof(ice_fdir_eth_pkt), ice_fdir_eth_pkt,
> +	},
>   	{
>   		ICE_FLTR_PTYPE_NONF_IPV4_TCP,
>   		sizeof(ice_fdir_tcpv4_pkt), ice_fdir_tcpv4_pkt,
> @@ -914,6 +921,22 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
>   	 * perspective. The input from user is from Rx filter perspective.
>   	 */
>   	switch (flow) {
> +	case ICE_FLTR_PTYPE_NONF_ETH:
> +		ice_pkt_insert_mac_addr(loc, input->eth.dst);
> +		ice_pkt_insert_mac_addr(loc + ETH_ALEN, input->eth.src);
> +		if (input->ext_data.vlan_tag ||
> +		    input->ext_data.vlan_type) {
> +			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_F_OFFSET,
> +					   input->ext_data.vlan_type);
> +			ice_pkt_insert_u16(loc, ICE_ETH_VLAN_TCI_OFFSET,
> +					   input->ext_data.vlan_tag);
> +			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_VLAN_OFFSET,
> +					   input->eth.type);
> +		} else {
> +			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_F_OFFSET,
> +					   input->eth.type);
> +		}
> +		break;
>   	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
>   		ice_pkt_insert_u32(loc, ICE_IPV4_DST_ADDR_OFFSET,
>   				   input->ip.v4.src_ip);
> @@ -1201,6 +1224,10 @@ ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
>   	 * same flow_type.
>   	 */
>   	switch (flow_type) {
> +	case ICE_FLTR_PTYPE_NONF_ETH:
> +		if (!memcmp(&a->eth, &b->eth, sizeof(a->eth)))
> +			return true;
> +		break;
>   	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
>   	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
>   	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
> index 1b9b84490689..0c90865a36c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.h
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
> @@ -8,6 +8,9 @@
>   #define ICE_FDIR_MAX_RAW_PKT_SIZE	(512 + ICE_FDIR_TUN_PKT_OFF)
>   
>   /* macros for offsets into packets for flow director programming */
> +#define ICE_ETH_TYPE_F_OFFSET		12
> +#define ICE_ETH_VLAN_TCI_OFFSET		14
> +#define ICE_ETH_TYPE_VLAN_OFFSET	16
>   #define ICE_IPV4_SRC_ADDR_OFFSET	26
>   #define ICE_IPV4_DST_ADDR_OFFSET	30
>   #define ICE_IPV4_TCP_SRC_PORT_OFFSET	34
> @@ -97,6 +100,12 @@ struct ice_rx_flow_userdef {
>   	u16 flex_fltr;
>   };
>   
> +struct ice_fdir_eth {
> +	u8 dst[ETH_ALEN];
> +	u8 src[ETH_ALEN];
> +	__be16 type;
> +};
> +
>   struct ice_fdir_v4 {
>   	__be32 dst_ip;
>   	__be32 src_ip;
> @@ -159,6 +168,8 @@ struct ice_fdir_fltr {
>   	struct list_head fltr_node;
>   	enum ice_fltr_ptype flow_type;
>   
> +	struct ice_fdir_eth eth, eth_mask;
> +
>   	union {
>   		struct ice_fdir_v4 v4;
>   		struct ice_fdir_v6 v6;
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 6df7c4487ad0..391e48d2bb92 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -203,6 +203,7 @@ struct ice_phy_info {
>   enum ice_fltr_ptype {
>   	/* NONE - used for undef/error */
>   	ICE_FLTR_PTYPE_NONF_NONE = 0,
> +	ICE_FLTR_PTYPE_NONF_ETH,
>   	ICE_FLTR_PTYPE_NONF_IPV4_UDP,
>   	ICE_FLTR_PTYPE_NONF_IPV4_TCP,
>   	ICE_FLTR_PTYPE_NONF_IPV4_SCTP,
