Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C673B109449D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 22:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E36D41FB6;
	Sat, 21 Mar 2026 22:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IOFWzftlZR4; Sat, 21 Mar 2026 22:30:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDAB741D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774132234;
	bh=CAvoYLvW68d1U+cPGr7Po8BAjlhkgT7fcwSzz+LnFBM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yWMP2f6y002neki9F3s6Ei5ptU/dKc7bHRczwMaTjfcX/b4woXceQMdLirfdQ29FJ
	 fqdNAgeNjTzJq98MexeesLXwwDwISbQTG86ZfC8vvwn/E/7XAl8gN8zvZydfY57QjG
	 hYAvyHzoW7uWnnheYFiH26Nlcve34oAi1NREqMyYDtOQAigmKk7l3rSTySPyN6/0MB
	 o2NhK7iPWOk8lXYj3GJu9h4SHddbXgxGqs0g9Luz1X2Slm3A5zSMl2CTrCkorHJO52
	 AN9yJSbQkflei3HTibWiN+507ZRUm56ZO7aljByUwBTcMjWkcs9AtryDMEShGoQLml
	 0r0WD1nnGmi2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDAB741D34;
	Sat, 21 Mar 2026 22:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 955A3265
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86DE141F6C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpI4sy7VZ_p6 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 22:30:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8B6B541F2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B6B541F2D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B6B541F2D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:32 +0000 (UTC)
X-CSE-ConnectionGUID: r8dBecpoSdqLAoqQ3dFq3Q==
X-CSE-MsgGUID: 08eY7iFERbWrURmfDi5bDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75150426"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="75150426"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 15:30:32 -0700
X-CSE-ConnectionGUID: /ayHjL5XS42qSsaPwo7RLg==
X-CSE-MsgGUID: 4xPuHQRNTuOjHNqaYaUdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="261543963"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 21 Mar 2026 15:30:28 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Sat, 21 Mar 2026 23:26:23 +0100
Message-Id: <20260321222627.1193603-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774132232; x=1805668232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
 b=R/Uqwa/wzzMIHf8GPFjq73fydZDK5+xIN169yWdcr+lBmTWJntXcPLmL
 uVh3DOWMolqY8kPG16Q6pfclgeLnXixDS5VAj7r1EUgw5Aqg32qZ5b0P2
 nmLebMrE29I6Zh6W9vK2/bxelAcJ0xNtWk4qTg5G00C5wtxDW5zZ+4s0K
 TvdQld4U1q4ybho5tqczSm5wPTYY9hpO5ABz8fK0OSDjQTloTRXCJNaHh
 CEJYLNsTEiUKRVsnZ+1PtjGxUcenyypiJsekoV9yLbi1VO7sIxNOTl0Y6
 AZuno+BX1dPf/D/nbxRTCLU92IVJyO8Yxnkp50FLkob0vfetGjzbHUikj
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R/Uqwa/w
Subject: [Intel-wired-lan] [PATCH v2 net-next 4/8] dpll: zl3073x: allow
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

