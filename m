Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370CED730A5
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02FD340CA8;
	Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yj4tSqlB8klt; Fri,  3 Apr 2026 05:40:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3940140ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194840;
	bh=tuhVHjNNUwVTvvuqe3K+maGUslAAwVNBdsF8CFSz+8c=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xlwLGqt74FSAukS0BTOE9SSWeJnnKYyU5iTwNOuyk+XflBDMC5oiOtTDa3NpMvm+v
	 i8CurD40sf/EtYW4EBrxCvKs9kbcTs5Sh3GEUVBQ5dOYKcZLpxzDOSXlvEGkAZC3uE
	 PfWa1DrIVFXCMnjQtO3g1+8L2UGrL/VwVtpZn2ysAxWixvtXMRudlvhKu+8POu/5p4
	 voTv29xZ1vcmcGCZ+G1VKgmDaYkzUcpUZrQgUrQup01L47eJRhRpxxHaJarh+/m99P
	 xp1P3uEyYyBMd0B5hXzbS3ZJ+pibhv0a0OOZ5MK2jVBbmTstpBVr170QmYlxgxdjoC
	 x6hGUlSKILlew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3940140ED8;
	Fri,  3 Apr 2026 05:40:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BF5B2CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 423E94008E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlfJNZYVMRTH for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2FB3F40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FB3F40071
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FB3F40071
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
X-CSE-ConnectionGUID: x0Shqk14R1eFqGSMO3jPEQ==
X-CSE-MsgGUID: N4sEt93TSaWQsXsTTWy6Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981745"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:37 -0700
X-CSE-ConnectionGUID: 9Mmf++qdReenl9xkMEe10A==
X-CSE-MsgGUID: SovLiNVwSDW+zN7A6aLDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904925"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri,  3 Apr 2026 07:40:22 +0200
Message-ID: <20260403054029.3789616-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194838; x=1806730838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bicA5KRrQzPR+gjJoc2RHFUbFtJrc8hacy54rrQ0fXI=;
 b=HAqWOnmGvJhF/7MHgumgJn4pVqagysxvcbxKNysS37QJhgtpgzwObXFJ
 T2UvhgeicdHQoClnXAXj125jpJzjI6PpX+AG7+M4JrRaRU3FQXUw3rNRz
 /c3qCwLnCtRkS4fik+krX9tVm3/gVsnplz0tfft6duWDnTif2J7EHgQ+c
 2PbiJvJ8+vfL70UNfr3HHQdeP/FwNxRqT/XtOnQ/AmpG4Vc/OIeX+YpTw
 9tgzoKk37k/csH4pfYmlYqoZ53dWpcEWIny4vs9EdXjv7YQfLcGzo4czN
 7SGxRCa9Le9gUX7YQHioIL0JC/7uy3quZrOIV6bqAYS2XDUAl34IX3QTw
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HAqWOnmG
Subject: [Intel-wired-lan] [PATCH iwl-net 4/10] ice: error out on CONNECTED
 state for input pin
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

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

DPLL's directly connected input pins must not allow the user to use the
CONNECTED state. DPLL_MODE_AUTOMATIC only allows SELECTABLE/DISCONNECTED
states. The current implementation silently treats CONNECTED as
DISCONNECTED instead of rejecting it.

Return -EINVAL if the user tries to set DPLL_PIN_STATE_CONNECTED on an
input pin.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Cc: stable@vger.kernel.org
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 397d16c..6a1465f 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -904,6 +904,8 @@ ice_dpll_input_state_set(const struct dpll_pin *pin, void *pin_priv,
 {
 	bool enable = state == DPLL_PIN_STATE_SELECTABLE;
 
+	if (state == DPLL_PIN_STATE_CONNECTED)
+		return -EINVAL;
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
-- 
2.52.0
