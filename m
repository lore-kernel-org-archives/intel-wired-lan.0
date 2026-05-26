Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3ECD5BD0
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 May 2026 09:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FC5B40F5E;
	Tue, 26 May 2026 09:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id as5PnDaZdYEQ; Tue, 26 May 2026 09:39:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 473B840593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779788381;
	bh=uouPZr+jOh6vgbPc99MYMpiIJ/jIg3nHlwuM77XNR04=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=St02xsNSHSAu+FfJKdNhrYMW5Cj7GkBpjLDJRH8/AKi6ogvwIWpV493UaUVysmBoz
	 1TtswhTaXWSnJRNYaaiAfztUhyjxZyCTQCyhRp3Lzl189LKEO5tgHTGF4JzGfewPRR
	 brq2WN3rwFyTMnW/w66Z4ysoJ6xAU9P//1YdMxaZw9iQNZWhPwFKpBIXQgvem9Vv3d
	 hkvTtBeTbT8LazFamq0Pk7lp2YjjHbehTMjIVIg7sPDUqH3YKAHojquQjU38WhIdvW
	 YzAHJDpIFPH+r5ZaZJcduweK/xw8wseEWlG8/PrAmTLEXV5kJNa9RFuoLxRQ8AGyqO
	 o1e27KfIig/kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 473B840593;
	Tue, 26 May 2026 09:39:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DA5C21F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 09:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 331F840786
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 09:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVbPIDQqcIbB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 May 2026 09:39:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F8CD40183
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F8CD40183
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F8CD40183
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 09:39:39 +0000 (UTC)
X-CSE-ConnectionGUID: 32zu2u4yTYyzPZXEbPhiTw==
X-CSE-MsgGUID: T5RcrS0gS6+qkxVhXeUBSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="90897263"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="90897263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 02:39:38 -0700
X-CSE-ConnectionGUID: D0EnGxW4T7WD2qnfEWI6lQ==
X-CSE-MsgGUID: 3hmPycacQFKthEakuI0wqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241027295"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa010.jf.intel.com with ESMTP; 26 May 2026 02:39:30 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Tue, 26 May 2026 11:34:15 +0200
Message-Id: <20260526093419.639220-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526093419.639220-1-grzegorz.nitka@intel.com>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779788379; x=1811324379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f4CVBYvBZXYPMriPrpN7kde+f4AJB2joLIhMcwxsOdU=;
 b=EeKlaw9JoKxttOCf11PA+wtA/yNjNnFw14znCoMYPncWyCFOh6zMTRzL
 Gg+3E8Kgbl7QmsB9PEFm695HGfVAAe4lw7zKtcdljFFP0jZCFKeOUcb0B
 7VwKDwf383kifve6hHWGjKKWYdEdag7r12h4+VN9ekA5cFg/xcBJvS+wP
 CSIYo1e7hk1zGcnt3ypKAtGuMnkDW4l22T6aRp0ujOAm0NynRkxc+Bwwi
 jELzO1b7bhjGLVhQ9fj43+CXwM56dt9vV43KZWpaSjy/7RkARNyDDttl0
 xrUiHM0CVpY1viA4tm2//QgOq36wV9Izl9Lr6iwq3MuGe9cTcK/nGPOkf
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EeKlaw9J
Subject: [Intel-wired-lan] [PATCH v11 net-next 4/8] dpll: allow fwnode pins
 to attempt state change without capability bit
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

Pins registered with an fwnode may have .state_on_dpll_set implemented
without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
Requiring the bit for fwnode pins ties firmware description to driver
implementation details unnecessarily.

Relax the capability check in dpll_pin_state_set() and
dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
the capability gate and let the ops layer decide, returning -EOPNOTSUPP
if .state_on_dpll_set is absent. Non-fwnode pins retain the original
strict behavior.

This is used later in the series by the SyncE_Ref output pin, which
relies on the fwnode path for state control.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index f81ed1071dba..162c2a8cffca 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1316,8 +1316,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	unsigned long i;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -1352,8 +1355,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3

