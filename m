Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B9CCD8C8C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  7 Jun 2026 18:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E87A61B39;
	Sun,  7 Jun 2026 18:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BTi0OFS0y52d; Sun,  7 Jun 2026 18:35:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E65961B30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780857342;
	bh=KAsEQdu4J4FFCnQRbGXYtMh3MwJNO5xrDzgXUHeI0ck=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PIjEGLP6yDeWAA52CAzyP+KAh+xM4lrQLBASLvYlM2aA+LJqn/tmp7rHY3Vn+IZUp
	 xxvPE3a7C88e+wFuWWk1XbkA2hjVgoR7hfhqUdgif+tOxhBykkK0mi6PYQeCdYcEO4
	 vGDpWH3P3q0jhj3awu3W8WXOD3AsZF0tCLCLHJRsUNUa+RRdWA3y2RjeMfvILMKxqF
	 +Z8IosOK7kAsNEWma5SpJ4GX+eiAsv5gZvTW+5sgyeWijrGECaf57QanxQYtqKiMIi
	 Q2F9SJMArNMDhpT+p2m3xxmoGqn7hf5rfOZKnxNUvkc8hH6ZpGsP5ZRSdNGfni4qk8
	 F7uYGjSo27Nuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E65961B30;
	Sun,  7 Jun 2026 18:35:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51A03345
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E66584B28
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Mjmu6QrzGKB for <intel-wired-lan@lists.osuosl.org>;
 Sun,  7 Jun 2026 18:35:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6009684B0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6009684B0B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6009684B0B
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:35:40 +0000 (UTC)
X-CSE-ConnectionGUID: 55KCNhlAT1Su8ZznAticoA==
X-CSE-MsgGUID: +YSAsrkaSMSbVI3yTatY0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602055"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="81602055"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 11:35:40 -0700
X-CSE-ConnectionGUID: AwFymosaQk6saXFOIEREXA==
X-CSE-MsgGUID: GwQjfwa+Q9+SBIMRsi3Lkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="245171379"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:35:35 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Sun,  7 Jun 2026 20:30:36 +0200
Message-Id: <20260607183045.1213735-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780857340; x=1812393340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7SLLTaGR04kcGW6NFlVhrv/kbAI3IG9DGTQq1xYnrM8=;
 b=NkYL9FvsikkEmot+h+/ChIluBBC6J7DJ9CN+bccK+ymaRqDKNYPY4OvV
 nEFYVbzBJoVVC++zHfFF49dl5nIAIQHNh2c6masl4Pv7+GW95ORiWpC4f
 ZlJ4Tp/SWJuRHQsIlPsaB//goWi0ggiaqVwl2dodiIo4okk+hZeSLJjwz
 /ST0XjAaOUpfZyQgpTrn2dOHiwKv5lvKi1tBrBgaNyqBDBGrEPcwqwtd/
 wGSWat1Yss6/RjlzUtC16AvdDgvp4w4SrIOjIAODbwg3Kqd7rPvXdyD/7
 Lyz6dZdY2qfaOsIX1KNTcX4KewAFHliEpwgp/e6TWU7YxxWGXfLzE+xds
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NkYL9Fvs
Subject: [Intel-wired-lan] [PATCH v14 net-next 04/13] dpll: send delete
 notification before unregister in on-pin rollback
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
 andrew+netdev@lunn.ch, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Prathosh.Satish@microchip.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The rollback path in dpll_pin_on_pin_register() called
__dpll_pin_unregister() before dpll_pin_delete_ntf(). When the
unregister dropped the pin's last DPLL reference it cleared the
DPLL_REGISTERED mark in dpll_pin_xa, so the subsequent
dpll_pin_event_send() failed dpll_pin_available() and aborted with
-ENODEV. As a result userspace was never notified of the rollback
deletion and remained out of sync with the kernel.

Send the delete notification first, matching the order used by
dpll_pin_unregister() and dpll_pin_on_pin_unregister().

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cea7e2be2cbc..80195f3a84f3 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1007,9 +1007,9 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 dpll_unregister:
 	xa_for_each(&parent->dpll_refs, i, ref)
 		if (i < stop) {
+			dpll_pin_delete_ntf(pin);
 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
 					      parent);
-			dpll_pin_delete_ntf(pin);
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
-- 
2.39.3

