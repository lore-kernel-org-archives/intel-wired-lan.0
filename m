Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AEAF4613F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 22:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA95A40D35;
	Mon, 23 Mar 2026 22:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7sdDPA729DVa; Mon, 23 Mar 2026 22:25:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE33040D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774304723;
	bh=Jfz95w7096a2jhtFdSmdlKGK7p6KMrfmcG0iEwkgrZ4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FyFD9S7X+2yxo/VPgpqHfBtMdWSbKW86/cHSu/1UvCVvtX8L5LHYMOApVM94quVdx
	 6upRN9OZFX7aQwuTNjIKOhqd1Zl2VAsuU3TMQNpCq5mMCw2KpLzPd/6tPvYhm42Q3l
	 sakHePj9+H4+r4JooFjKpVzf5+5H+Dm+14nY/y7sJzhrXNy7PrhaSwR893+133Hv5d
	 Bi7T2GrrNKaL1rdzYrBLCFioInweE4BZW8ZuD0QORIA6v4EnTqoU8FGm/r/C0iBOgv
	 jy85qi+7mMm0AgBKLKKCwq1ossxxu4Om+KbPKQB7knU2LXgS5TlJ0i7HkKMZ+go4RZ
	 nMY44+r3i4/Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE33040D37;
	Mon, 23 Mar 2026 22:25:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 451B21D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A9A5608B9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydR9NX70tzwA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 22:25:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 24C26608B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24C26608B4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24C26608B4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:20 +0000 (UTC)
X-CSE-ConnectionGUID: lrk6ZEAOQ927hQc7CxQHhQ==
X-CSE-MsgGUID: P1vfCK+WRb+nQSVNsLNCXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221871"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75221871"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 15:25:20 -0700
X-CSE-ConnectionGUID: UV/DVek1QU6h/J6UhIZbEQ==
X-CSE-MsgGUID: /7GSf6gzTUGIwtwIDt6syA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="247207317"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:16 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Mon, 23 Mar 2026 23:21:27 +0100
Message-Id: <20260323222133.1796997-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774304721; x=1805840721;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hYTA8iUKl0X+UOSv4rV5POwDjvdL2+lTdynEuwcEsbk=;
 b=ERO0tLC1oZCYTRsM6V4/qQSgf5SlNhPRkkKD0ijPirCRtMZM11uytqAO
 KFdnCqwYWyvCkHbwBLjYPZ7vf5hZulWqqaPoJyzks/DJI0w+D0z+yA/Nz
 L5QEHoWS0WkcjGADdvU8kLP/SmVCOM+0qV8trhOQo/ENVzMulX/0F644k
 VSPD6M4El3GZSJ/wbz3/mBwYzON1sXnrFFcwsqYNQb3DwXJVIDGwo4FvP
 ZtvYeb3/HsfErox4r2gJ3FXnFALmJiskXu6qzjXVY1Wz/DqwL22qrA+Gy
 vnElTfv/Y7ZOEf26UQ4lSagxy7BkkfjTYrAiWcEqj/piGFCe/FYBUIcaZ
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ERO0tLC1
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/8] dpll: allow registering
 FW-identified pin with a different DPLL
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 jiri@resnulli.us, edumazet@google.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Prathosh.Satish@microchip.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Relax the (module, clock_id) equality requirement when registering a
pin identified by firmware (pin->fwnode). Some platforms associate a
FW-described pin with a DPLL instance that differs from the pin's
(module, clock_id) tuple. For such pins, permit registration without
requiring the strict match. Non-FW pins still require equality.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3f54754cdec4..55ad03977d6d 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -880,11 +880,21 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	if (WARN_ON(!(dpll->module == pin->module &&
-		      dpll->clock_id == pin->clock_id)))
+
+	/*
+	 * For pins identified via firmware (pin->fwnode), allow registration
+	 * even if the pin's (module, clock_id) differs from the target DPLL.
+	 * For non-fwnode pins, require a strict (module, clock_id) match.
+	 */
+	if (!pin->fwnode &&
+	    WARN_ON_ONCE(dpll->module != pin->module ||
+			 dpll->clock_id != pin->clock_id)) {
 		ret = -EINVAL;
-	else
-		ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+		goto out_unlock;
+	}
+
+	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+out_unlock:
 	mutex_unlock(&dpll_lock);
 
 	return ret;
-- 
2.39.3

