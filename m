Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A81EDF172
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 15:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA14540677;
	Fri, 13 Feb 2026 15:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTgF_TxL3vXc; Fri, 13 Feb 2026 15:06:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AECE40636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770995181;
	bh=360ZQPLfzJK0j7b1sfAIjsEyWaC0+pX3R+Wbko8T84I=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=73KBJOTTEymYz+nzk+yOxzrAwpfsaFmC8VqR7JCpS15gDDpWIBTlyjLeJoOOBZVhZ
	 DjYAAG6ICFgL3bbeK1GmjSoEvby+nIAUcA7n7zkZjW01S8vGx6V0x4/rksS2rpJUK3
	 WFj8S3wV9ynJOIgFlmSvPib7/Qhk7LdzlfpaFpyxA+kdje0aSeDjRWgOnSxCGjSwxc
	 zjADQDDAfYC5JZxODQ9mrgacvtcPAZ3DAPJXe6fnBA8QHV1fNTqy6J16GFSTnV2EFR
	 llU9yXNK7c9jieYarIgL4eJho96hfWTrZAfBUI5knO2E4d+aEr7RA5/9zchDKDpxLv
	 7uOHt7rWK4MBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AECE40636;
	Fri, 13 Feb 2026 15:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 543E9EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3575E84461
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JlVh8wX9Za7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 15:06:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 53BBC84467
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53BBC84467
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53BBC84467
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 15:06:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90B4F4422A;
 Fri, 13 Feb 2026 15:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4959AC116C6;
 Fri, 13 Feb 2026 15:06:17 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Date: Fri, 13 Feb 2026 15:01:31 +0000
Message-ID: <20260213150130.2513644-2-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213034429.1830480-1-aleksandr.loktionov@intel.com>
References: <20260213034429.1830480-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770995178;
 bh=zcMl5ICj6tdjHRVUkCNQNcsPrdeSaI9/cjs1ydke4eQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QEeTxv6ZuBwOwbN7qo9vYzzusnmQUVrOe6ZG8wSxEdDpcj2IZkGRRuoBBF/6Yvhrm
 ishuCbSCgUcjOx5TbAOdMo50GH9TjfF9cb877Ne+8KOHGkqnKbN1ELt5/ZbrbhmetJ
 do41jgPrsAjbs8uh9C4FALFk3ggZEXLa5+SwD/TmvYx3noxvco0AF23v3tGJXmLvqi
 OWojZqHtEo/uYrlI9Gkc0beGd4n9ffY3EU1rhY2LP1qo4m0J6htYv5492ccL5jvaku
 p2dKjgNyzas25SBdcSergQNhHlLakpABdgj6ys+/hGyjM4p3gJpM1BgGXTM4RPUny5
 HAXcVA8MoWa3g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QEeTxv6Z
Subject: Re: [Intel-wired-lan] [iwl-next,
 v1] ice: implement symmetric RSS hash configuration
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: implement symmetric RSS hash configuration

The driver advertises symmetric RSS support via supported_input_xfrm
but ice_set_rxfh() ignored the input_xfrm parameter, making it
impossible to configure symmetric hashing. This patch fixes
ice_set_rxfh() to check the input_xfrm parameter and configure
symmetric hashing appropriately, modifies ice_set_rss_vsi_ctx() to use
vsi->rss_hfunc instead of hardcoding values, and updates
ice_get_rxfh_fields() to report symmetric field configurations.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index c6bc29cfb8e6..6dc37f96b57e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3037,8 +3037,10 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>
>  	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
>  	if (hash_flds == ICE_HASH_INVALID) {
> -		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
> +		/* Provide default symmetric hash fields when no config exists */
> +		dev_dbg(dev, "No RSS config for this flow, using symmetric defaults, vsi num = %d\n",
>  			vsi->vsi_num);
> +		nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
>  		return 0;
>  	}
>
> @@ -3067,6 +3069,7 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>  	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
>  		nfc->data |= (u64)RXH_GTP_TEID;
>
> +	nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
                  ^^^^^^^

Does this unconditional assignment at the end of ice_get_rxfh_fields()
overwrite the actual hardware configuration that was just computed?

The hash fields are carefully decoded from the hardware configuration
returned by ice_get_rss_cfg() and built up in nfc->data through the series
of bitwise OR operations. Then this line uses assignment (=) rather than
bitwise OR (|=), replacing all those computed values with a fixed set of
hash fields.

This would make the entire per-field computation from the hardware state
become dead code. The function would always report the same fixed hash
fields (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3) regardless
of what is actually configured in hardware. GTP TEID hash fields would
never be reported even when configured.

Was this intended to be an additional |= operation, or should this line
be removed entirely?

> @@ -3667,7 +3670,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>  	     struct netlink_ext_ack *extack)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>  	struct ice_vsi *vsi = np->vsi;
>  	struct ice_pf *pf = vsi->back;
>  	struct device *dev;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index d921269e1fe7..31f2757cf7fa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1155,7 +1155,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>   * @ctxt: the VSI context being set
>   * @vsi: the VSI being configured
>   */
> -static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
> +void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  {
>  	u8 lut_type, hash_type;
>  	struct device *dev;
> @@ -1181,7 +1181,9 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  		return;
>  	}
>
> -	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
> +        if (!vsi->rss_hfunc)
> +		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
> +	hash_type = vsi->rss_hfunc;
>  	vsi->rss_hfunc = hash_type;
>
>  	ctxt->info.q_opt_rss =

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 49454d98dcfe..29ba335dcc54 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -46,6 +46,7 @@ void ice_vsi_delete(struct ice_vsi *vsi);
>  int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
>
>  int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
> +void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi);
>
>  void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
>
