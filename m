Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77689109449D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 22:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3748641FB3;
	Sat, 21 Mar 2026 22:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYMevNBHPogb; Sat, 21 Mar 2026 22:30:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F1E741F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774132221;
	bh=Jfz95w7096a2jhtFdSmdlKGK7p6KMrfmcG0iEwkgrZ4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=z1Zywf+swvdMDP4RFIzQXf/z9Xm32mUKNirgaANqsrz875LyvUm9xAzN8PpXBkIg0
	 RSPCtjzp+KzZKpVRhwzN1j4Ik/bmjMeW3wrEQQ6JD+RKwHg9i4Dxwbrx/X2ykxeEBZ
	 ioA/CdqcEFqJfdMd49rJu3BuJdfNi3ghu+zULLTwG64IUIZoWi3Z783K2Cgo/j1Qt5
	 Mg5OqrYOd0kYJy+AuQHVXrJk3GCVwjh9n8lJ/gRr0UzhaFaek9P9ILkUgzS9tlJoxt
	 SnrZhOK1gQWygKIbeJn1WpC+c3TaljXJFmHyVFdZbt3fySbh/Ihyzebs2XFKNDc3qG
	 tk3gXVpn12nOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F1E741F2D;
	Sat, 21 Mar 2026 22:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5A4265
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B01084080A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnR3rwOzLyTG for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 22:30:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ADD1D40788
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADD1D40788
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADD1D40788
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:19 +0000 (UTC)
X-CSE-ConnectionGUID: v2xVzQ5kSeWblvB4SlDP+w==
X-CSE-MsgGUID: OEzUZG9CTvSlnP3Dym5Zvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75150400"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="75150400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 15:30:18 -0700
X-CSE-ConnectionGUID: iHMrUULUS/ChliilFda4lw==
X-CSE-MsgGUID: 1DggN3p/RTKee2n8lJT6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="261543945"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 21 Mar 2026 15:30:14 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Sat, 21 Mar 2026 23:26:21 +0100
Message-Id: <20260321222627.1193603-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774132219; x=1805668219;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hYTA8iUKl0X+UOSv4rV5POwDjvdL2+lTdynEuwcEsbk=;
 b=UPKCB8fI9ev1QAG3kKWP0JhYp0gBsj/34dBqsryIEvMb88MRkydJngc7
 bt4UXTnhKXgBBUbU0mHqoAqQb22T9RWl7YiMcaF11mU3nQB/l6uft+8DI
 vaOCXChnitSaRmObkmmoK3xFDaQTX3CjtNCNBqr1owVtfZ1/beHG5KDqJ
 jrxK5wmsnRMQNBZFKDeJ2xrEw/iWMGjixeOonNlJO0PceCzihAIOkRx94
 PkZYbakFVAFFl/Pgny4OMSrY4uMin9D9wzs5Oq51rW9vwUSq0wjDwQU0L
 aDhL0EAi+tUXG11NChOUSExtOOCJVXr3ymtHJbeGjDx3RaEPrS6D/saFT
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UPKCB8fI
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/8] dpll: allow registering
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

