Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620B5C98324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BA58812EC;
	Fri, 25 Sep 2026 13:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doXT2RlRTsgB; Fri, 25 Sep 2026 13:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 61437812F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342824;
	b=sobFxSJJDbggYpX1Zfda0Tb/miF/A9Vq6cYNcaSUIcVCDcdU70Zad/jllnbi110FrMuY
	 pdMzHeeIbpPsyta/HPe6tmJ1ByluTmnqah1HOgMs2iFm4/vRZgfuYbX7oNQLIsfW2RAmX
	 ksJQ/hklPja/K02MWQVCV/5PQIjYHpp91TiZoTbSf6cCVG2Aae+44SAdqVPCp27oG19Gk
	 YpKdSf9xMBWi3rFBthfh4B7knP8pW/DLAeJJYMNrXWriOFrgyr7BDCEMIANO5xmNZofFK
	 Xdy4BejpNCj0NLG/9WrPpqeCt0fX0LgEjw1B+fzgcPH0BW/P5RE37MLrMp1TePgjwew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342824;
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
	bh=4Ysdp6iRQCAf0I6g1QtpeOj6CWBreo0GjNJJ85zvNDI=;
	b=qeT9qbxKPf5mXXgqp03vqIZR25Xt/3/XJZmGKwB5TB4zzPmsYvty5QD0o6esUxQwJB52
	 7iKCKK2IsWAZbEXSUHBepXEtdf0NB5+kKs6Adjv4mOMdLlKlEYNbcaRrIpHGBaL0lSQ1P
	 osD7uvd7eDAo302asE7Z5hkebcNskmSwDrfc5WGHBii9WIQ31cHER5HJFDgIwnG4h/XwZ
	 5nyjEMjEVbMiKUNwnw3/WNfQhMMk8b/aAsW+ofJfzgmojAPUrPUWaSgGK15Q0KS1YAkuq
	 rKMm4iiRIfJoCOdAEl5voXG+xlav9OskJeWSfScoDq2o9etWTMiYdrBg7b/piwLCkVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342824;
	bh=4Ysdp6iRQCAf0I6g1QtpeOj6CWBreo0GjNJJ85zvNDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Of3XGNWgDsLhB3bNP4wycmZkvMEZt9qgIr/b201WPbt3DOpyY7fNCH7vmkws9+Oei
	 b0jwRFTwQYLlG/SV2x/xqqc1wW3oULgMQ2m6cFTZbdTYCh8yJW2qh8z8kA4Y6saN7f
	 gIwkDFiS7MF9sbiVcAXbUs915Dti4hH/hP4c4CFWwYef83dthmVKFvawkstxaPGDnZ
	 PIg7aihhloDAjQmBfUfTHxmW0WGijtUsSPN0WDWwaekbxbXN5K/bx2jlbcZQKZXG/H
	 jc6svfcAb4U2vuJRFmFT+f1nYRT7bXZy1MQT/nFLTkYcG7h1PlkVpDxkM76sn5H2Eu
	 sxHc7F0jakVCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61437812F2;
	Fri, 25 Sep 2026 13:27:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B54A334
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4827A40B9D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjyAEBaogzbC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4401C40B9B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342821;
 b=dSjYn32pDvWXbKhPXg6Qd5JEIBSoSYKFHc888Z2iqAO/QtrD9UPz3E8Mi0do0ZS22aJC
 KuAcOwrxIWf6HM+wdSKZ7aFGJ1hjaXv2bUa0EBM4u0THvNTCaMVOpBPESsm/uc4PItwfE
 Z20XnsW/S8pUImLMiCDouKikQLCimZUZelSrFuGTzB9dZWsrmc7ZtyzeRVYqblcfMMl35
 fvCGLwuuprdbSrSuDuwhRHiGa7hCD0uo13hbdAwy68uRRRN/H0xI/V7QSbQhBBkauN6PT
 pvCsg88rHC+BSWV8OJ9gxnc+n4yVyErEa7vNjf88TKMrabJi3Nn6HXvf561oaH3FJxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342821;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4Ysdp6iRQCAf0I6g1QtpeOj6CWBreo0GjNJJ85zvNDI=;
 b=e+T5yChtPKCSKvN2y7as8TZLSA/vsx+Ll7LxeVaGlY8B3kpahUz1kVAUprz8EC1Q+83+
 OEKI677SLI1RWdzQtRDKFz7LNOGGhhLuuM4m/jYnAbdjIavfNMuAaD8C1yohFw9haguLH
 A10FCZlN4d0vdi5kBUc0YB+iWEsWQq5DcEoBrNanfhliNvHOK5+eLvRIdE4pOAM6hG9qP
 R7YjQBv31Y4ZrYwcNd8XiFp/Z7ZYEcuqqCr6qfBguqA+7tcrwL7EBkuJS6jY2KxkwyrR6
 rIWj+drhnLWlEDvrjrz85UXDy5N6M4dcB5u4wWXwu9gPo+KQPg6a3ZZheolBoIsFerw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="W2snqyj/"; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W2snqyj/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4401C40B9B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342822; x=1821878822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LEzCYFgeUadabV2t5Leusuxox4hmHs2CPHTpzz+dv30=;
 b=W2snqyj/6pXq69ukNEMiQAvotIxLONs8tL8xRuWn4urDks52x459h8rO
 bWNaFe2nTNgkontFok1LyieCOn62OicxoO01iE2BJh0Zj/nz6EXO4/7P6
 2LZBWZViNTpACWbVvTCegq6PBvC+KReuehxO9y3edB3NQCStcnhrGw3oj
 JmxIBFCs4OC+GyN1QUIvGBSYsX/dcgUozLDcB98CrYkNM3FYZeZ9G3LjC
 XWgDw9VXFIgJ8Idi0uEY9x5APRJb3NDNl/fYd8XTJyi6MjaXyl+SRu4vN
 yV/5MGdoW8cDVB4K43ltFFqifiBbIKxqki/YJrITfQuFk1uhpL0vh8BXI w==;
X-CSE-ConnectionGUID: oR3ro+JtSSCsLau7aLi2Xg==
X-CSE-MsgGUID: SC3T1Xw6R3GLG73FeSfREg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508270"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:27:00 -0700
X-CSE-ConnectionGUID: oE33mZCQSbabuJp1YmSrsA==
X-CSE-MsgGUID: zXKMwclCTKWdfc/3rOTslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414743"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:56 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1916E2FC57;
 Fri, 25 Sep 2026 14:26:55 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 4/6] ice: extract ice_vsi_get_num_qs()
Date: Fri, 25 Sep 2026 15:15:46 +0200
Message-ID: <20260925132636.123300-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
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

While reshaping the whole body, drop the kernel-doc line promising a
return value; ice_vsi_set_num_qs() returns void.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 - drop the stale "Return 0 on success and a negative value on error"
   from the kernel-doc of the void ice_vsi_set_num_qs() (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice.h     |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 88 ++++++++++++++----------
 2 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fadfe94bf1c8..f1ba86d066be 100644
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
index ed32ae2667c5..134984077d5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -153,23 +153,61 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
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
  * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
  */
 static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 {
@@ -180,68 +218,44 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
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

