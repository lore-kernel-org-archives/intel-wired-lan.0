Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5D8C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCEC4065C;
	Fri, 11 Sep 2026 11:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tHOmPFPK-jUI; Fri, 11 Sep 2026 11:39:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CFDE4068B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126752;
	b=WdDTqhLuyebRJlQXPS7yZ+jTYWnDnySAH6F4WN9SuUPvUdIk1fhSLsxMQolL7PLLFcR+
	 25+9K+XH/5BDBoDsB8NoXsazkJZEDPqag89Tx4HwWVzPwqI5ntjCWS2PfPJxwmcq4r7iH
	 EsK+lvZBcl3/VOFeUMtQnPiXraO8/WJGE0c2cjX2WpdEk+buATJ/3v8N2UKp3tUcJXrEY
	 m3chH/kwqjraUtxtGMh38VkUfr1F/w3vAE5TYnrnXBzR/vOJeaN3LGk5Eb3e7FmeFxcVW
	 85wAp9U4qeGIUx8uUMfSWXB05lBi0hZZImd+ajKHMt7uY/oaqsXhJ58ES9v/YqTrasA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uw5m9NZVROsMt5ausyBHW/zz2kAsd57Cwg9nrsgsFAo=;
	b=lFQb/IGttQXCBV01JnSC9kzPKP/hAA6shn7muXOz0JcayDoktpgHIe9vkMKPygEKoj8E
	 VmSJXaYpBJVg9ZLzmiBxbcziXLTSBZRou7uTaTz3oTD25hPultSHHk9HecGSPrq162J+5
	 RljaHa3HP1jKS8haWpiyliS0GXTsU9Q1uB08Df0od6khgOA3tbix89pnxi3+JH6mJ7EkK
	 4XWcYKQT+uHTraST8FoVn1w04HF0zTqM1Z1t6OFDqEPplHRjyZYgMOkQIIYZwmrbW+N3Y
	 12bUvt/KWoW8brsEh35c8fWoWQY4FePn7meslyQIa5QbJwaNo9QNWx0PpLD0pkB8RNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126752;
	bh=Uw5m9NZVROsMt5ausyBHW/zz2kAsd57Cwg9nrsgsFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IErCVNRYmcvs0SN2WQ7gUnvSr+za1CZdPUTvHSpScGAg0kl/VfguNTfU64lfYyjo4
	 hBNQPhnU2bmaCwl2ALKQipq7klduOdTSknz3Sr0NAyomu/Fg4YkPvym6oVPXwmXTfx
	 F3I/0lODMEgT0YrlCIUubjuT18YxSWFpcLNNdcx7wTs6NRo9/wRp9FYeiKkuPelQrf
	 aYkS8PIQvY/FYEH7mDqLtA6ijHc0/ayoQaE6Y67RjoF10aGDRMxx9Ez8gx41h3cELQ
	 NRYc0HWlLEjcyc7zmY5T/0sGWKQEaF3XH2ar7DiT/+hiAy+Tzp74fzAEWsEOFiO49K
	 re2n6wYa9HFmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CFDE4068B;
	Fri, 11 Sep 2026 11:39:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AD882E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51743401DA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHcLMn51RwpC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 603B540469
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126749;
 b=dF6zg96mr2aln39evg4XeLUtTBU313gbqrTNLn3P7ZnwhznpHV2SoSzid561sdOaNB5W
 W0bUmYwWWonyigt96WsQ9u8WgiiMhxDFq7pywdfOM3Dn+O9d5rgzj8zifI7piue97RUiC
 vEf5JNHcW/llfUMln6QKmPaA2kdpMOO6qn9t4VHMU3z7/Sn1zt6OoNS+ZK3KFVy5oVn0+
 6zw9r4deE9dNrGi8Rk8N5fJKl4p6GNOitOKsdWU812sWGVzUTI7Jmt+v6Hc1X4+c0T2pN
 XRPmyb44ezYglh9+QGc9tb0tq8R1R+Bkyn4OUra75VztFR2evC0lnf326JPC6B2dgeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126749;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Uw5m9NZVROsMt5ausyBHW/zz2kAsd57Cwg9nrsgsFAo=;
 b=KWoZgMYoJxYIleoL9LpKVMozDNyl6hM8yCScRiZamwhkfxOdefGpvw8HU7dBs96hgKzW
 C0j1nWeRTpVuOLDE+47EbJ0Fm8WiXnCbI674hi4S3Zu+lNyXGGK08YqblyJiJr9VWDKlb
 4Wvc/2n7PTvX2ndyOcrD0T3G9kemT86vAotcovcH5gLuKVUmsP1qJ78xT6jZlumfpCrCS
 z9+7I09tM4p/U2+/2oAB+gYkYJtxt8IgXDOKBI6wcqHf3poHuCfwwBHnk3P6pMRPI4ZfW
 jfuPpBQm0bs2x2lBWaMy9Q9H46Fncu8VQ/8QNTMyCDFoR3lqh5M2Ris7cjGXYZmC3kg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ImoLqvCx; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ImoLqvCx
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 603B540469
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126749; x=1820662749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AuaOWD3jGMYAysDk1Aw30zB+BClJT8BRzZUW50HSm5U=;
 b=ImoLqvCxf0q8Svs3qecD9gMDP3p0KqxFrtEbdV8+pd85bHI9BYmLyydr
 lDgFHWPi/VQ6hTOiILixfNSGujdsiMyb3icJDgywKuZ5nzGbDyYhpetdL
 3xndWbxwqwNiQur53OAW8iUzg3suwsB5IF5HQ2O9lavLuJjgyLlZdWvfv
 kcqlhmTArtchLnr+CYUGl057QukiMUgdDtfPw+tukBJ+Zxb3d0hdbTtUD
 z6mTMKPoWBf26IBA8RX3RfSXp0gEH3BwfpYStM/tH9TsrXhZgJEIy9Nt9
 2CdxGZPVED/n/uD4WIW9N+0Lb8NYrh1kqrAH1OfwVGvwF6zWbT6wVInrq w==;
X-CSE-ConnectionGUID: Jx+EkKOAQtu4Z3sLYVoZKQ==
X-CSE-MsgGUID: yW0aHPTPRHycsbi6YNnong==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359904"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:07 -0700
X-CSE-ConnectionGUID: 0lrwuez5Rhm/SZ0o0nLzhQ==
X-CSE-MsgGUID: Qyt2asG6RCmbaOBJYSQfeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135862"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:04 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id B6A9728781;
 Fri, 11 Sep 2026 12:39:02 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 3/5] ice: extract ice_vsi_get_num_qs()
Date: Fri, 11 Sep 2026 13:26:18 +0200
Message-ID: <20260911113848.44086-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ice_vsi_set_num_qs() mixed two things: deciding how many queues a VSI
gets, and applying all the side effects of that decision. Split the
decision out into ice_vsi_get_num_qs(), returning both counts at once.

To make that possible, group alloc_txq and alloc_rxq in struct ice_vsi
with struct_group_tagged(), which gives the return type without adding
any new storage. Field order changes slightly, num_txq now follows
alloc_rxq, but nothing depends on it.

ice_vsi_get_num_qs() takes @held_txq and @held_rxq from the start, even
though the only caller so far passes zero for both. They let a caller
ask what the counts would be once the queues the VSI currently owns are
back in the PF pool. A later commit adds the caller that needs this: the
rebuild path has to size its ring stats arrays before ice_vsi_decfg()
releases the queues, yet the arrays must match what ice_vsi_set_num_qs()
computes afterwards.

No functional change intended.
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 86 ++++++++++++++----------
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cf1b0ba8dc29..48f4312df4a4 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -403,9 +403,11 @@ struct ice_vsi {
 	u8 rx_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
 	u16 *txq_map;			 /* index in pf->avail_txqs */
 	u16 *rxq_map;			 /* index in pf->avail_rxqs */
-	u16 alloc_txq;			 /* Allocated Tx queues */
+	struct_group_tagged(ice_vsi_alloc_queues_params, alloc_txq_rxq,
+		u16 alloc_txq;		 /* Allocated Tx queues */
+		u16 alloc_rxq;		 /* Allocated Rx queues */
+	);
 	u16 num_txq;			 /* Used Tx queues */
-	u16 alloc_rxq;			 /* Allocated Rx queues */
 	u16 num_rxq;			 /* Used Rx queues */
 	u16 req_txq;			 /* User requested Tx queues */
 	u16 req_rxq;			 /* User requested Rx queues */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9c2863fc696c..998b9eb6e9fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -153,16 +153,56 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	}
 }
 
-static u16 ice_get_rxq_count(struct ice_pf *pf)
+static u16 ice_get_rxq_count(struct ice_pf *pf, u16 held)
 {
-	return min(ice_get_avail_rxq_count(pf),
-		   netif_get_num_default_rss_queues());
+	return min_t(u16, ice_get_avail_rxq_count(pf) + held,
+		     netif_get_num_default_rss_queues());
 }
 
-static u16 ice_get_txq_count(struct ice_pf *pf)
+static u16 ice_get_txq_count(struct ice_pf *pf, u16 held)
 {
-	return min(ice_get_avail_txq_count(pf),
-		   netif_get_num_default_rss_queues());
+	return min_t(u16, ice_get_avail_txq_count(pf) + held,
+		     netif_get_num_default_rss_queues());
+}
+
+/* @held_txq, @held_rxq: queues the VSI still owns but is about to return to the
+ * PF pool, so that the result matches what it will be once they are back there.
+ */
+static struct ice_vsi_alloc_queues_params
+ice_vsi_get_num_qs(struct ice_vsi *vsi, u16 held_txq, u16 held_rxq)
+{
+	struct ice_vsi_alloc_queues_params qs = {};
+	struct ice_pf *pf = vsi->back;
+
+	switch (vsi->type) {
+	case ICE_VSI_PF:
+		qs.alloc_txq = vsi->req_txq ?: ice_get_txq_count(pf, held_txq);
+
+		/* only 1 Rx queue unless RSS is enabled */
+		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			qs.alloc_rxq = 1;
+		else
+			qs.alloc_rxq = vsi->req_rxq ?:
+				       ice_get_rxq_count(pf, held_rxq);
+		break;
+	case ICE_VSI_SF:
+	case ICE_VSI_CTRL:
+	case ICE_VSI_LB:
+		qs.alloc_txq = 1;
+		qs.alloc_rxq = 1;
+		break;
+	case ICE_VSI_VF:
+		qs.alloc_txq = vsi->vf->num_req_qs ?: vsi->vf->num_vf_qs;
+		qs.alloc_rxq = qs.alloc_txq;
+		break;
+	case ICE_VSI_CHNL:
+		break;
+	default:
+		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi->type);
+		return vsi->alloc_txq_rxq;
+	}
+
+	return qs;
 }
 
 /**
@@ -180,68 +220,44 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	if (WARN_ON(vsi_type == ICE_VSI_VF && !vf))
 		return;
 
+	vsi->alloc_txq_rxq = ice_vsi_get_num_qs(vsi, 0, 0);
+
 	switch (vsi_type) {
 	case ICE_VSI_PF:
-		if (vsi->req_txq) {
-			vsi->alloc_txq = vsi->req_txq;
+		if (vsi->req_txq)
 			vsi->num_txq = vsi->req_txq;
-		} else {
-			vsi->alloc_txq = ice_get_txq_count(pf);
-		}
+		if (vsi->req_rxq && test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			vsi->num_rxq = vsi->req_rxq;
 
 		pf->num_lan_tx = vsi->alloc_txq;
-
-		/* only 1 Rx queue unless RSS is enabled */
-		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
-			vsi->alloc_rxq = 1;
-		} else {
-			if (vsi->req_rxq) {
-				vsi->alloc_rxq = vsi->req_rxq;
-				vsi->num_rxq = vsi->req_rxq;
-			} else {
-				vsi->alloc_rxq = ice_get_rxq_count(pf);
-			}
-		}
-
 		pf->num_lan_rx = vsi->alloc_rxq;
 
 		vsi->num_q_vectors = max(vsi->alloc_rxq, vsi->alloc_txq);
 		break;
 	case ICE_VSI_SF:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		vsi->num_q_vectors = 1;
 		vsi->irq_dyn_alloc = true;
 		break;
 	case ICE_VSI_VF:
 		if (vf->num_req_qs)
 			vf->num_vf_qs = vf->num_req_qs;
-		vsi->alloc_txq = vf->num_vf_qs;
-		vsi->alloc_rxq = vf->num_vf_qs;
 		/* pf->vfs.num_msix_per includes (VF miscellaneous vector +
 		 * data queue interrupts). Since vsi->num_q_vectors is number
 		 * of queues vectors, subtract 1 (ICE_NONQ_VECS_VF) from the
 		 * original vector count
 		 */
 		vsi->num_q_vectors = vf->num_msix - ICE_NONQ_VECS_VF;
 		break;
 	case ICE_VSI_CTRL:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		vsi->num_q_vectors = 1;
 		break;
 	case ICE_VSI_CHNL:
-		vsi->alloc_txq = 0;
-		vsi->alloc_rxq = 0;
 		break;
 	case ICE_VSI_LB:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
 		/* A dummy q_vector, no actual IRQ. */
 		vsi->num_q_vectors = 1;
 		break;
 	default:
-		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
 		break;
 	}
 
-- 
2.51.1

