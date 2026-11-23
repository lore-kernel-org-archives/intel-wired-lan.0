Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34406606A332
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CsEeiwsE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wl040Y4S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12C2480ED1;
	Mon, 23 Nov 2026 20:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0WkYW4ROeEE; Mon, 23 Nov 2026 20:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7829F80DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467369;
	b=i/oeoP08Xe85SroSr+Bm0I+Z7nbjIsSRMFKlsRllWQXQ1ZOjHPu6kD7kiyZA5rNRber0
	 rK5eOEORjsu1AqUzkZv/k8Mr0kVRJIfLsML3DnmevwCqGibUA9YoDyAoosq2zwpv89umW
	 evF8JbMtw1/syy4psnCia/jvNbi6RPLv6X0YvDHf6485oVrqEMnezraepCWpzn+zdzUR+
	 0FBYPCr5ktLCklliU8H6hr/ovLt5rSKDbetlPtGLCrWst6vUzmiMhWUbs5ikfUbYe3ZxG
	 FixVikYfLb2iqLCo4uMdgBEzwKPyTwu7rlygVOqHLe2uqnhyR2lJy7wlxfUfOit6A/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WPZXnFL2dxCsHKLyRCX5HTJ7jpEYoJWDerjYBwz6GzY=;
	b=idD/aYUI2KQuqSPR1KqlIQ+nTvwhGqMw3B91BFHkUCaEpnWckVR4ZBd4cuee5oPLmyxh
	 TSu9fVvnxTvQLp+25UtAJbrBDDDueDRxIdvUpNbm0CaxwyzXq3lW53UtCVYLDgVY2xt5k
	 tjyLfxlpLQERYQgBicQJDvPCYUHX0ZAjl5dY3GlKd1iTpSLbFQZtoXkdKcc3n0UbzHj8V
	 l005/opaC5gGhQJQ/GZksCKBDlJMrGU4uTuZ73NSCZyFb3sQHLeQa3i2jDVca4BPd48tN
	 ES32WF7dKjmGPmp9zDmP+VWlQmaXQv4HQWcuz7xQsz8um5cCfBgBoDpGQQtzw7YDOsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wl040Y4S;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795467369;
	bh=WPZXnFL2dxCsHKLyRCX5HTJ7jpEYoJWDerjYBwz6GzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsEeiwsEK7E7RUHKPurnd6afSJc0j05qYfEL4ELFyQJCpXzFyiWRRO+zB9a6qZ23T
	 SC30xNt10SfhQYuaM16bGpXs74bPwU4HXWht3G8D736Ly8v2HwMrDQHfZTXQKlZU58
	 dBy6dfMRz/ScxL2hLjTo2QVtXSvlp/9DUTcK/NN7aX1Ox2C7/CLqJAGXrqDg4dBiI9
	 Cnu8jDjsbi6sg4Y4cHbnWhX0LvrrR0dJ66ku7NHHDbYIRrgDY0wL/LqIvjwLLGYYvR
	 MDT4zFJdnk8dxcbpMvruzKUGNXwaTbHuhehxI+uDcG8M2QPOWMP02CpSAHmQUHAgzC
	 /gIxsq1vbWY1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7829F80DC5;
	Mon, 23 Nov 2026 20:56:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58685311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EC1480E29
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ucUEojhHFX1L for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91B9E80D8A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Wl040Y4S
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91B9E80D8A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6A5344822;
 Mon, 23 Nov 2026 20:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F351F000E1;
 Mon, 23 Nov 2026 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795467364;
 bh=WPZXnFL2dxCsHKLyRCX5HTJ7jpEYoJWDerjYBwz6GzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wl040Y4SnoATIo+6LbctZXVaSCB3N0b84Ffa1bd0+t3ZVsKrOuFN7lKQ+m2LSB1dn
 Hplt7Kmaxncg27V5jllxDLHNcImNogb0C2Bf5dXPu75galxViHR7kng/MF24QC0fdj
 AwezSANldUR0+XPBm2yKpsdXOvyGW7ov+V3Dp2rPOgUIyIOxcdKnvbNBGfhCSNg6ZV
 nETvX8vuJrGfDuQx0QuO48Q5mQ4CZR+7IJRUpG9yCKiSF7vk7qAcJjq2weA1f/dygk
 ZkeJ69kjeA61PPECMCyovjJwK+9vdd56m3bnQgvirnOuRDE2A2vpM1/uqln/NXidST
 T7mzy1PbuOr4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ahmed.zaki@intel.com,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] ice: don't unintentionally switch to symmetric RSS
 hash
Date: Mon, 23 Nov 2026 12:55:59 -0800
Message-ID: <20261123205600.1794292-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123205600.1794292-1-kuba@kernel.org>
References: <20261123205600.1794292-1-kuba@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RXH_XFRM_NO_CHANGE is 0xff, ice looks at this field to check if
RXH_XFRM_SYM_XOR bit is set, without first checking for the
special NO_CHANGE value.

This causes any ethtool -X invocation without explicitly
specifying input_xfrm to enable symmetric-hashing.
NIPA HW tests catch this, and we have been carrying
this fix in NIPA test branches for months.

Fixes: 0dd415d15505 ("net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dffa213734f1..8f13b7607c9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3681,10 +3681,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	     struct netlink_ext_ack *extack)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
+	u8 hfunc;
 	int err;
 
 	dev = ice_pf_to_dev(pf);
@@ -3703,9 +3703,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 		return -EOPNOTSUPP;
 	}
 
-	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+	if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+		hfunc = vsi->rss_hfunc;
+	else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
 		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+	else /* input_xfrm == 0; core rejects any other value */
+		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
 	err = ice_set_rss_hfunc(vsi, hfunc);
 	if (err)
-- 
2.56.1

