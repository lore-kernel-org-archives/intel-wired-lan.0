Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8344BC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 11:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 394D280C76;
	Thu, 20 Aug 2026 11:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GNBIBsXHTUrY; Thu, 20 Aug 2026 11:43:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787226200;
	bh=WytQXIBxAhJ5rNfiKDsmGGr7KOYuZMTUGN8s7EZ4ru0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OZb+2qs3jTV+qlYKkxLinNbJ5oHq3CGIRsu9ISWJkDXvO+Pl/T+uxcnMl1+AbcSRo
	 vICGAaKBhErMkII6UebwQSZZs8DpiEL3S+aYbNnrQHz9vIkAVJGIXw+S+RBUu1yR1s
	 uxc9StNsqiYuJBy48jZ7AKk0MFiwLUor7L7TZ91ND+/lguajnWMDP64whgTPAlnbkl
	 poSgI6bvT/VaZ0JXVtCMm6emJxUqTZuU8Sd7IZ8mygynFL+EhAfgPW1sTokZIfDefP
	 l8SeqbNsSXjROZc1lORjCkoUEXkbcPXMrFW7xgYUAmkrLpg2INRA5AfZOc97JZpycl
	 rG0GcK7j/8R/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B7C80C95;
	Thu, 20 Aug 2026 11:43:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5AAB39E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 11:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B73F36077C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 11:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id re0VxnK85CZR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 11:43:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XlGyABYX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD007605EF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787226199; x=1818762199;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GbUEeQgHO4G6iYdMPK95ntbU1AsgYQoXrK38tX4cEdw=;
 b=XlGyABYXxuQaOaiUQobxxycFbmaSz8ZKzlxUNpCKLhTevSX1xvm/4Vm7
 y1x6yNLVHDfQP7HlyttvljMkWTsMsOmEt5Xhaw9U5/iOdKnnEqCcTSytl
 ePYsmJOUuPB/SAdxKMWvd9LgTNt7/i6zgsnS/EMzDNn58v0pPwiRTLEGK
 wA/lqv0SkylGNuysQTHOy3oa/+4wcs/MOCIK/y+KV7wmWLwDG3UWe/6dM
 Sf7khCnhfPYKcAENDdmBi35T3169QpAaS1FFqbJOQiVrL/jkgltSEt+oh
 gfLGYiJ9pG3GMsY/+v3iDqbvIlC/5MNtFBwheUcMPz479hWfB/bko6v1P A==;
X-CSE-ConnectionGUID: 0Im7UfxHSR+iaj+Q9brpiQ==
X-CSE-MsgGUID: uPrfeLOBRqGzAO4Iub8FBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113297129"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="113297129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 04:43:17 -0700
X-CSE-ConnectionGUID: /SfVVEWYTJu2USIPJDbvyQ==
X-CSE-MsgGUID: pk3qe8pNToCvLlip5EM2Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264207473"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 04:43:16 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Date: Thu, 20 Aug 2026 13:43:14 +0200
Message-ID: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

ice_rt_ho_set() uses the HO register as the starting offset of an
ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
be advanced by user-controlled data reachable through
ice_parse_raw_rss_pattern() -> ice_parser_run() ->
ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
size of pkt_buf.

Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
so it stays correct if the packet buffer layout changes.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index 3995d66..bfdb50b 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
 
 static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
 {
+	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
+	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
 	rt->gpr[ICE_GPR_HO_IDX] = ho;
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
-- 
2.52.0

