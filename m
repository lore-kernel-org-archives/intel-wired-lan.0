Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE63BC5516E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Feb 2026 09:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C528D41840;
	Fri, 20 Feb 2026 09:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yk5efS2wbslc; Fri, 20 Feb 2026 09:26:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FFD84087A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771579597;
	bh=6Y0wu0m2S+xmvajj4wnruotNKsfdEgel5Qle4IIau5c=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3ZlJtEIV7OEbpK1k7OxlrXm7xtVrZUFb6ZaPx+FEJsoumG8TbuTtvmSIONVROnob
	 V+i40VcVvj+qnvZTpt5uQnvcPmP+hzIAl/UsnjB30tp9unUVx7S4NQ+9sMilxeZm4i
	 9ZFuZfXrUvnDoKejPjMnVq/JUuIc+aGnlrBKLYaiYlOv4YLQ+h7w5bC/bkpRUkj5wn
	 HERc3Q+TwFNkI3Czj05nEUN3EKadoEAemJG9lJ5gSFoeKvl+uD95GfTHC0qmk1CE+N
	 afhOOnM8tbDh/YSDg1uMXhOx2/VyWBUutl8K6fmZP2MQSgt9gwXcrcXi6ZI+CutBX4
	 IKJQwQx7f3N8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FFD84087A;
	Fri, 20 Feb 2026 09:26:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E0D11CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 09:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A327C406E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 09:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpVp_wX7YTJE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Feb 2026 09:26:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 19D76405CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19D76405CE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19D76405CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 09:26:34 +0000 (UTC)
X-CSE-ConnectionGUID: VYTNlHV5QVuV2XHy3m8T2A==
X-CSE-MsgGUID: /Yd+ifYQS66rHJFF6W2YMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72373469"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="72373469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 01:26:34 -0800
X-CSE-ConnectionGUID: WXoSYEXDT8KOXIWb+Z/aew==
X-CSE-MsgGUID: J00DuDWmQIuvHIVF/iRJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214030009"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 01:26:33 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Fri, 20 Feb 2026 10:26:29 +0100
Message-ID: <20260220092630.720082-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220092630.720082-1-aleksandr.loktionov@intel.com>
References: <20260220092630.720082-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771579594; x=1803115594;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=t0chq214HkHrpgpq/8q/aGOsHgiMN8Wk/jEfJVeixCU=;
 b=f4YlB/AMPMb4FZ7GGYzOuCvSRSX5TdZ40UGtkC4VbCRSAC4KexEaS9Gd
 w5WKK7npIyRus+xsqYjB06EQLcPusV02MDmi8Dk9/d68DrDwLxUDOdjks
 fELyTPVR5ZUvS7CrfnzgqIFGXcv1Se+mr0LGvArX1uGx8JqeUXrodVKkh
 ZKEAUSaEjvsXdjZyf6wZpvP6//A2xOMygmGbRnrbpHJ1upcnz1mM4P3wQ
 grCaGBMSy/V7A2jL45JA+aZ3OHAkd93NrAlN2BRdPVDmA7wddJHipn9Pj
 5umMxpazaM92pdi8/cth8DKC5S72xbM+KVkwYW8XTaUoLXVGqIiFuRs57
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=f4YlB/AM
Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~(u64)RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

