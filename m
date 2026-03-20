Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AACE109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 519CC617A3;
	Fri, 20 Mar 2026 05:05:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJuOpKY8nRdQ; Fri, 20 Mar 2026 05:05:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34646617A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983138;
	bh=8nFyx1DXvCjok0uH7GLT9XHH5IswmDvdbN6h5xh4qVk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7Gg3zxZBKR0p0LqKf9dUo+uq3J/9qYldy7dp67cVj2MuH8BtQ3M9dDrK/99P8mOit
	 IszW988a55NWlMkF/muZ4yokGJY3hyDp3p2wmm3S91lm+q80FKqfq8BCFwTh+RrKbp
	 KA3ylmVY/IOb8k0C5MzJ5FZJYXKDfUxMG8ar5C8/m0FUbF110rPfk4KJ0IJq5KgUc0
	 mRxDdnz5rFqiM6XEeTQVloqFFarUAMJEbcxEx8FLTFDqshKMutWb41TJngu52x7NBV
	 rnkPzbZ9LA6iL5m4FAO2XwvqOY+nOTfKZQnasiKIz9IGkXx0HMfkTmpQbhMOfi83ns
	 7nhPVuT3ebtYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34646617A2;
	Fri, 20 Mar 2026 05:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD45725C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2C9541398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IF5R0hmdwnMI for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AABF040176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AABF040176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AABF040176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:35 +0000 (UTC)
X-CSE-ConnectionGUID: 94fKlyI1T8GTZBifsWwuNQ==
X-CSE-MsgGUID: I21Tm0xuSBOdF5jsFO0t7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522715"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:35 -0700
X-CSE-ConnectionGUID: 2wmL25AVRJ+lna9GUs3hCg==
X-CSE-MsgGUID: 6yPA7/OrQQmIWEpUs/aFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307296"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Jakub Staniszewski <jakub.staniszewski@intel.com>
Date: Fri, 20 Mar 2026 06:05:33 +0100
Message-ID: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983136; x=1805519136;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zPbmu2h3dYcVfoZeyIIRECebdDh3IS+lQz8XJwFWoRc=;
 b=h00viKmuZPthn7iPaVw3vRolNi5h3ulBuCi4dlBhr3sF++S3dZMKCTtt
 f4/vCx/M4ijRF5QxxMS+J4PyzfIjtjP31nUf84btT6OiFA0cmeQaDuKkS
 5o2hHC/e/R7RRuBRkVixl6ZDCbFN2e/UQHdyCI9fN4sbWZBFkmY9bt0IY
 BoinLgot9+tnuKbeJyb00QGJX4CF/PbCGgcDpXfoyug8s68GBVDMymZei
 gLzATRjB3pdFl3l3uOELYtB9cWFtdK3Kv2YWENyd/pxi+FnDho7uPt5kd
 9SNhvxX/uJ8bHIH1f+cfFUXsQV0Fw/rJodD/Vpn4J8FySqbkm/wZfmBp8
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=h00viKmu
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix FDB deletion
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

From: Jakub Staniszewski <jakub.staniszewski@intel.com>

Correct the logic in ndo_fdb_del() to align with other drivers in 
upstream. The condition was inverted — it was rejecting permanent
(NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
deleted, which is the opposite of the intended behavior.

The correct logic is to reject deletion of non-permanent entries,
mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").

Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 348c86b..7692403 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6200,7 +6200,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 {
 	int err;
 
-	if (ndm->ndm_state & NUD_PERMANENT) {
+	if (!(ndm->ndm_state & NUD_PERMANENT)) {
 		netdev_err(dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
-- 
2.52.0

