Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC83FC43458
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jun 2026 22:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 610D040F6C;
	Fri, 26 Jun 2026 22:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q_ZZWiGSDXPc; Fri, 26 Jun 2026 22:26:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2AA940ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782512801;
	bh=QHQe461p4IkD5U+veVeVXVjqS7KLHZKNF4AB25rlJAM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsplDOqkdQO4FainAzYcZzoQPz22+C8S7FVA7gSBSDS3rNXf93lcQHbAhoBvtbYC2
	 IH+n2UmG9AVSnB7CfSE/aKJ983WYbKzXvtC2g4p5d38HaJq4SRxTuEgwv1g5RPua/b
	 PxC4ToCT69b0R/lto3dgKKjB6LBB3Jr7GDCXu0qevb7p8z++Wb73ezYv+OANl7EU+G
	 g3Js1YCNuF1CeLP2J+PXnTJRje6DfNm72s6J/eqjtOB72NVqppmCktx/lprFveURQP
	 Yg8ljaMEaz4hWwNKVsXfpRgjAC2g2HiIZAgyd878laZeNoApEvewEH4w2qBbyujgan
	 lH+MssF9MMHPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2AA940ED7;
	Fri, 26 Jun 2026 22:26:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81D722F3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 22:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67775608EA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 22:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SkXWvvGXDDE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jun 2026 22:26:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 94CC2608E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94CC2608E8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94CC2608E8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 22:26:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0946241654;
 Fri, 26 Jun 2026 22:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CED1F000E9;
 Fri, 26 Jun 2026 22:26:37 +0000 (UTC)
Date: Fri, 26 Jun 2026 15:26:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260626152636.1e48330f@kernel.org>
In-Reply-To: <20260626054730.1126969-3-aleksandr.loktionov@intel.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
 <20260626054730.1126969-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782512797;
 bh=QHQe461p4IkD5U+veVeVXVjqS7KLHZKNF4AB25rlJAM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=iEDiDreC+JwYdSWT5JQyhazkoQEli4wbfGan4SzJiGK33qqLdADgFQFSLHBX886Kl
 R+Co/QJaQiDovSEx832olVkq7acq0rgTvwMtXpejKa9Grc2qn883nR2rIoJ7650S/3
 880WsP0CBiiWGWZBi9YrKV/up91Pk3MCvXcl30I163LhNPykD/qtzox6mRlRJvwn3T
 0L8HOxcMgrPsvu6w8AKvAuRHopQuU3rqdwBVNLCNSmM04BDdIPLxNns3447PyCWfpP
 nhLV3e+7YrYGuwNCXGowR2RKrFBEiDMwj1ve2WttaGLyOlSvtVPOZ93i4KH9Pk1L+1
 N7yOjs2J/PDdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iEDiDreC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/2] ice: implement
 symmetric RSS hash configuration
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

On Fri, 26 Jun 2026 07:47:30 +0200 Aleksandr Loktionov wrote:
> -	/* Update the VSI's hash function */
> -	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> -		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> +	/* Handle RSS symmetric hash transformation */
> +	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE) {
> +		u8 new_hfunc;

I think this is the very bad part. Please extract it out and send it as
a fix to net. Looks like any changes to RSS confing on ice randomly
enable xfrm sym. I isolated it to the ntuple.py test which just changes
the indir table, and the driver says:

  ice 0000:e1:00.0 ens1f0np0: Hash function set to: Symmetric Toeplitz

Which we never asked for. I drafted this before seeing your reply:

--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3692,10 +3692,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
             struct netlink_ext_ack *extack)
 {
        struct ice_netdev_priv *np = netdev_priv(netdev);
-       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
        struct ice_vsi *vsi = np->vsi;
        struct ice_pf *pf = vsi->back;
        struct device *dev;
+       u8 hfunc;
        int err;
 
        dev = ice_pf_to_dev(pf);
@@ -3714,9 +3714,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
                return -EOPNOTSUPP;
        }
 
-       /* Update the VSI's hash function */
-       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+               hfunc = vsi->rss_hfunc;
+       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
                hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+       else /* input_xfrm == 0; core rejects any other value */
+               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
        err = ice_set_rss_hfunc(vsi, hfunc);
