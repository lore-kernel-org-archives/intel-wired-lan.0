Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28591109449E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Mar 2026 22:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E306184B63;
	Sat, 21 Mar 2026 22:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddJjNKn2HpN7; Sat, 21 Mar 2026 22:30:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA51784B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774132215;
	bh=IVN+9MgYzHXWHBnp5A0z9OzOgMtPKnVO2Arbr1lQRt4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LiLLGS3pyPl/rqJpBW3nLH0d61qo1qR970oFyD524l49wQOuz5Sr/+Au0uXDsb19W
	 kOoycTe1DXBY7DxI3aYvnb8kexeQgVflFFIWV9EMITtAQ1S0Fwc0MVVrJhseMYZ4db
	 0b3hBIiiM2QQFJiHTmGjg72Vyr/iUJYpkdXFnxFKuBLyMJOMKJZOhjjJxb8AYvlpRu
	 1146v3EVdb7fXrkupacz6PedpEEOD8IjBIsoXYV98k4CaWBcse9EKXs+S1ra3OuFam
	 w04wA5w6A+Fgqipf94fDj9+r2yoJnYBU7UHooAWv1OF+6IIQMv19Mi6KBJEk75gB9J
	 eAIFpBNA4nSpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA51784B61;
	Sat, 21 Mar 2026 22:30:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BD5834C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D93C40788
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlUz4Xc3cg46 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Mar 2026 22:30:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 44B104080A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44B104080A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44B104080A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Mar 2026 22:30:13 +0000 (UTC)
X-CSE-ConnectionGUID: oLMY8rW7TrWsz+MhI+7lww==
X-CSE-MsgGUID: f2J7ocJ3RoOzb8n9bxy6HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75150388"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="75150388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 15:30:12 -0700
X-CSE-ConnectionGUID: eyKSTOiXQd+v9+rgQhn4eA==
X-CSE-MsgGUID: imA/BRysR7qTDUh4Gkvk0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="261543929"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 21 Mar 2026 15:30:08 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Sat, 21 Mar 2026 23:26:20 +0100
Message-Id: <20260321222627.1193603-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774132213; x=1805668213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u+5dUgI9MeglTQJUE62U2wtjfkSu8FhYrvaGjK513KY=;
 b=Jy1H2gt7yocR1WQUG4U6QoaXpX6bsMHgwnXX57HuToQaxC1mkscmWulc
 6ZPNPu+zIqj8dxq+fB6c4fWwfjKrTUPjUdekC4TeEFhJr6qPBywnx9zJ0
 qH3IBVxqoY1bT5WXV20fmn6LD2zdIHAt0PyuWLylxEToukfJZfO4E/FNS
 cklcRa/k/ND9uo7nZP574ruNYDgYb739HyjT/HrqmwjgmXLqgiElXWyRK
 GWuNMHJEyez3OyV8QZYdr50ZuFtJmbHZIPcwa6RGUiJFFqOL3Azk74U+C
 J93VCl1uiZMKD9BJAOge8Pgw8PGqXQZrlkIslSEIR+r+fA6dyupQENWDH
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Jy1H2gt7
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/8] dpll: add new DPLL type
 for transmit clock (TXC) usage
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

Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
representing devices that drive a transmit reference clock. Certain
PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
link operation, and this clock domain is distinct from PPS- and
EEC-driven synchronization sources. Defining a dedicated type allows
user space and drivers to correctly classify and configure DPLLs
intended for TX clock generation.

The corresponding netlink specification is updated to expose "txc"

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dd48a32f783..2a2ee37a1fc0 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -138,6 +138,9 @@ definitions:
       -
         name: eec
         doc: dpll drives the Ethernet Equipment Clock
+      -
+        name: txc
+        doc: dpll drives Tx reference clock
     render-max: true
   -
     type: enum
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index a2b22d492114..4182bdbb6dbb 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -34,7 +34,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
 	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };
 
 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index de0005f28e5c..8f6db5d5bf0c 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_TXC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3

