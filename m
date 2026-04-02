Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517AD6AB17
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Apr 2026 23:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 353A640834;
	Thu,  2 Apr 2026 23:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eb34AVHJhkGJ; Thu,  2 Apr 2026 23:10:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5385C4050D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775171439;
	bh=CAvoYLvW68d1U+cPGr7Po8BAjlhkgT7fcwSzz+LnFBM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PZH6asQ7MA2VWDUzbPR/G6v5EwRo1HQenvoMMPtHY6g8ZA0WeJWko1W4z+tl9qHV9
	 k6Q/G7pOPMZPKDujhfKRN2sXZvCxMpPRmfFRvi+WhX9GgVJ8TIgWHk0H+uQRaippS/
	 knA1YySSA4iLOmiItKp9nV+xvgB0YIRGYRcQMGcbHPinmOFu2qIiNodqL5jz5ziiTQ
	 w7AvYOAxjItlXs9VllEZaauHUKaVDfetZRQvwLkL3TIMvjzxHrsDzxi55eIoHSvhq/
	 /stq/a/I02UHCeNKsNDNBF/3wulmW/HkF5znvrku7fZaPpMAmU7iWf/ZEMbGPnCr21
	 8l0oIc3fE8fPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5385C4050D;
	Thu,  2 Apr 2026 23:10:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2091F2CC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11C096080A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSdmzjryTrMl for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Apr 2026 23:10:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C1B260664
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C1B260664
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C1B260664
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:36 +0000 (UTC)
X-CSE-ConnectionGUID: 13I4zkeGSgyXgjlOC5mS6w==
X-CSE-MsgGUID: YfnDR+3TREOws7RuUPjhjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76123102"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="76123102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 16:10:37 -0700
X-CSE-ConnectionGUID: zn4o8IXFSYeGhwfXaibKyg==
X-CSE-MsgGUID: 6rWA4cGyQMGl/Fmfwh3p9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="227044442"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa008.jf.intel.com with ESMTP; 02 Apr 2026 16:10:33 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Fri,  3 Apr 2026 01:06:22 +0200
Message-Id: <20260402230626.3826719-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775171437; x=1806707437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
 b=ZpbKuyumb/TKQUgNqoZ5ATmeq/0SzabKU3gHna8aV253xRIwP7sjp6we
 AKRMACBFzDsBgbX+vBP8zDjacWlMwRZvy/6Plj+xYuKnaZ8UKmn1yXFsc
 D0VrLP9MsgHKfxL3eyK7hscMx6f2sPDkXB72XGGedteySw1qlzSXbMZW+
 0KtPgLSDvnJAam6Pe3xPr+U+Fx587SiCSmZaLPRGpcYzcwWLtZizcPHcI
 IzFL1o1cDcC9RDw/nz0PybbON4ZGwnjTLE+mkwpANsh/WhJMVynjYw5mD
 vSdjU5MtC+1G042O4JMeqUkoE6Gd7GKXspiZaMtM5xGccAVBRrBmL2tGe
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZpbKuyum
Subject: [Intel-wired-lan] [PATCH v5 net-next 4/8] dpll: zl3073x: allow
 SyncE_Ref pin state change
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

The SyncE_Ref pin may operate as either an active or inactive reference
depending on board design and system configuration. Some platforms need
to disable the SyncE reference dynamically (e.g., when selecting a
different recovered clock input). The hardware supports toggling this
pin, therefore advertise the STATE_CAN_CHANGE capability.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/zl3073x/prop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..acd7061a741a 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
 
+	       /*
+		* The SyncE_Ref pin supports enabling/disabling dynamically.
+		* Some platforms may choose to expose this through firmware
+		* configuration later. For now, advertise this capability
+		* universally since the hardware allows state toggling.
+		*/
+		props->dpll_props.capabilities |=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+
 		/* The output pin phase adjustment granularity equals half of
 		 * the synth frequency count.
 		 */
-- 
2.39.3

