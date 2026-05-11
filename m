Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D348CD37BE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 23:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4DD840AB3;
	Mon, 11 May 2026 23:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVEUUrleMSOh; Mon, 11 May 2026 23:36:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15BAC40AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778542605;
	bh=z/ugf1K20Acfp3nOJmg9dUXp1a51svU2e1dcWpO5mMg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AISm5PlQKIoAM/2lp/3u8CiU2f62VNAmcqD2UJ5DdzeBvX1mCv+sau733T//b+s1a
	 Xok3JH4jyp/LVc5zwTs16f1hsQ0dG1U4QqM24/XUMmH22KSnZWJaKZwOCeykkSspCY
	 2cCjEvd5zXDa32CspVrY0lqmF3YeBpWkdK6BRotAWie5TJc1O+3NG9sBgIqHV+3htD
	 +4EsJ/chZFYpMLVWmoC5fnjM39tuZZjbEnlam+2iBICzVWjJhgx6HND0yJNlblW6l9
	 FKBkJK4a/qMayXUYMciyyerXUKTXse1+phQf2drMb4YaM06mwdD/Q+2u1Z6yzPCcAG
	 nxtRNsmsFAhTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15BAC40AAB;
	Mon, 11 May 2026 23:36:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CDAF223
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 23:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1300960883
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 23:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6H47zefS5liO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 23:36:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 235D960881
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 235D960881
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 235D960881
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 23:36:42 +0000 (UTC)
X-CSE-ConnectionGUID: PVFVhB2FT9+fzcxV3vq3oA==
X-CSE-MsgGUID: 9zo85kA5Q9iKgb9y4CxLfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027410"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="90027410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 16:36:42 -0700
X-CSE-ConnectionGUID: rk2utmTsS5mtCme2bt2PRA==
X-CSE-MsgGUID: ht8ebcvZSOK4iTjGgFd81w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="237687278"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:37 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Tue, 12 May 2026 01:31:55 +0200
Message-Id: <20260511233159.2558165-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
References: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778542602; x=1810078602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vbbZq1hrf06NrmT4kCRwMGZ/sXfkisXd+yu/4ftUCUA=;
 b=NbLdsaFPnGjScOosi0oGcdy+horzYYs/l0U7ajEIzIAxge7/wg3cSqEL
 2AovXhf53x3m07wVRl9wCQOE4DV09jtyFFF9VXg2LfVkYyQM55R3+v7mf
 w1A/1FjAv1wouSYLKjVI9Ti/e7GccsotDnEqh5ADn4S3FxDALzXreaSTh
 2q5HfKPfDOHBExmwmm7U34JKZFlSiytC+zXHCMHPPD2gT0Fm0atVXkWFh
 GPmOKifKY86fZNWD5174Z05Wd8Jv2YeoeddjB8aG2P7je4bjq6oczAy2j
 SU36LQEiEj4AwNEFa163/JcZJkODt6h6ahUp+ENMMhtm1O6ll8/rlPwgv
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NbLdsaFP
Subject: [Intel-wired-lan] [PATCH v8 net-next 4/8] dpll: allow fwnode pins
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
 andrew+netdev@lunn.ch, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
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

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index b2c099990017..4f461d39ecf9 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1325,8 +1325,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
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
@@ -1361,8 +1364,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
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

