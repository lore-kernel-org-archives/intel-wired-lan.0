Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7593DFF8875
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 09:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B66384472;
	Thu, 30 Apr 2026 09:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmrYYaDsMh49; Thu, 30 Apr 2026 09:46:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8178B8445B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777542415;
	bh=Qhp+YxY7sKfdB1cAQ2jaO38gzjLfTtbAjElFiczGpgo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9GoqrWoDi41q5X7xsGpQgnvL6oX2sgQXcMUx6DMrHZWzax/SBvo6+dg3q7vGJMMEd
	 5Jr7cqyto5Ih9hbIeTgMuaZOhJ/yimc1wVFTDQ5P0kSEh3qTTAenm4Ul6GLa+saBxz
	 q5yFBmRqxwguj71a70PW9WJAJ3crAgt6lyJCF4lFqlaoyA7XILgkZkjtRRImmY3XKn
	 uTSKbm1KUwQQLNmpAMN1VvVVznALlzzSH58n4VSB4xy8eIEiwhzdtAsaHNGDd15Rm4
	 zhpohZFQfb4tbIADAoDSBddJfnvpHb3Y9WwFWF22HbUlawkWbW+rB1VURmtSnWhcpz
	 2ssBhlJ6il/Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8178B8445B;
	Thu, 30 Apr 2026 09:46:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DD9F18F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 09:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B88F8445B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 09:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYJ8t8byHLiU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 09:46:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0AFF884447
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AFF884447
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AFF884447
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 09:46:45 +0000 (UTC)
X-CSE-ConnectionGUID: jjORifv4RLSTvxfGgNsLTA==
X-CSE-MsgGUID: GymmGNJIQzuoN8zIKQrsSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82342570"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82342570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:46:45 -0700
X-CSE-ConnectionGUID: 1v08t+jyRlmPqWBOaXe4dA==
X-CSE-MsgGUID: GuN+VYnSRaeWpnRZC+5SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272649735"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 02:46:41 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Thu, 30 Apr 2026 11:42:31 +0200
Message-Id: <20260430094238.987976-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260430094238.987976-1-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777542406; x=1809078406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y/QDmxkfTXgNMhmlNvETtV7zJKHS/M5pTaNjnoyYTkE=;
 b=bNvuzaRi5yCNXaVXzEBn325Nwa0RxTG+mkCU5tzrIHLMjCZA2+wYk4LU
 YAk8T7QANKdZUr0u8bFcYRBuJRsM/LNzyQ+ijKd1RisYKhy7tu3rR9xMn
 B9p4crY70T0GiHbVeTMb/0soNYSrmaBXLAmC+RYxBwXNfZfpSU4Yrpck8
 hCmQtk48KzSiB7WwRO8Mj7ZqRxUtgOoxZfvE9+4im9hA5Up0/MZvdAf71
 jREw9iS/CSLhkW6Sg2IfKeHQBwFkv82qmxOQDKopRWsKBQJZ2xMvLoA48
 j/7QDnd3xQ6RISo5zPIjS6yeoHKRVrHkMU+6iVg8L+F/RV8k+7VefoKv0
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bNvuzaRi
Subject: [Intel-wired-lan] [PATCH v7 net-next 1/8] dpll: add generic DPLL
 type
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

Add DPLL_TYPE_GENERIC to represent DPLL devices which do not fit the
existing PPS or EEC classes.

The UAPI type is intentionally generic. During netdev discussion,
maintainers pointed out that introducing identifiers tied to a specific
placement or single design does not scale across ASICs and vendors.
The role of a DPLL is already inferable from the spawning driver,
bus device, and pin topology, without encoding additional
purpose-specific taxonomy in the type name.

Using a generic type keeps the UAPI extensible and avoids premature
naming that may become incorrect as new hardware topologies are
exposed through the DPLL subsystem.

Expose the new type through UAPI and netlink specification as "generic".

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 40465a3d7fc2..572cf7ae5f36 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -138,6 +138,9 @@ definitions:
       -
         name: eec
         doc: dpll drives the Ethernet Equipment Clock
+      -
+        name: generic
+        doc: generic dpll type for devices outside PPS/EEC classes
     render-max: true
   -
     type: enum
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 1e652340a5d7..9a3b70ea3ae0 100644
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
index 871685f7c353..648553053cd8 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_GENERIC: generic dpll type for devices outside PPS/EEC classes
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_GENERIC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3

