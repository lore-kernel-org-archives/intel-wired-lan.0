Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6EB10854D8
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 09:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF37D608ED;
	Wed, 18 Mar 2026 09:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hsBoFUsG10yg; Wed, 18 Mar 2026 09:10:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB314608EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773825055;
	bh=1AN9bBwTCL9bPz61t0b3WejbIDpA1MxTeaJ2H6zm9Bc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oBQ8sLJU3LWAl8HtZ8uu6ALI/btmdH/xNsqIrae7pPh/Z3qeYY5zvue8KAIbjC9MZ
	 g9/2SQAGuMSxpzLaCFcm8AaZVqYiTiICwMGsctjb8mbtRZCvZVV7FizJcn31xPCOgc
	 VAL8kl+FcxTHtEwmpSqBgWTXQpr8NXC5dvsIW7sEPgM/iBI2mwwhTIwF7m7VKdw2T6
	 62+aaEfnN59ZEwnjP/cFS3tqN2586aqzN5rSto0IWnaEDGHtOyDRFzmekqiviPLuEK
	 GkYS1OPMUP4XBwAFP2obbHDTQNj9p9urdWFETRj7KUDFM6p8GGj6J8JSPvr6Xanp4e
	 lA5huVIWjln2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB314608EC;
	Wed, 18 Mar 2026 09:10:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 179FB1BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 09:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F15C440EF9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 09:10:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SilRnAWhpTBV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 09:10:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F295E40EF8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F295E40EF8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F295E40EF8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 09:10:52 +0000 (UTC)
X-CSE-ConnectionGUID: /VB3HFMUTL6RpI2OcAzfXg==
X-CSE-MsgGUID: ONRkx/P/Tt63bs5xZ3q5Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77484386"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="77484386"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:10:52 -0700
X-CSE-ConnectionGUID: e0rUIBs0TJiHtivit/Gyhw==
X-CSE-MsgGUID: VkKlT6VSSvG6ZBFeI/8iTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="226699909"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa003.jf.intel.com with ESMTP; 18 Mar 2026 02:10:48 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Wed, 18 Mar 2026 10:06:47 +0100
Message-Id: <20260318090654.611349-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260318090654.611349-1-grzegorz.nitka@intel.com>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773825053; x=1805361053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JwAYdusPC5by170hmQjS6FQlF/xAWF9PHx4rEUFWEJk=;
 b=dMmQdudVO4sOjSlhZBFY3CjQfi8ZubwyLpqexa7KcfTXmuwsa5lLypaf
 8YWpXwHkJZSl7KC5WQ7RPZEuBpl6h/rEP47xYiN9e/VI+wvjiRCIJpyUD
 9ZxeCyKXGQdxEdKAb8Hu1s/tVGCVyma606uhIb3sbb9oBbwe62xGhU3zO
 1CtZrs2SCJYITY7VbbXq35tRC95HXMvZunGKcxFKGycNkfQZV3OAcxX3S
 gtCEa9cQ32Foja+M5Yt48+340T7yKHYl/9qny8OdR+fLzR63j5QQWiJjT
 r+0XIYROtIPoXgwPHvvuWQygRN1tGnS/+N2JmYo8TgJCktwBiFkmvZcyC
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dMmQdudV
Subject: [Intel-wired-lan] [PATCH net-next 1/8] dpll: add new DPLL type for
 transmit clock (TXC) usage
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
 jiri@resnulli.us, przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 donald.hunter@gmail.com, linux-kernel@vger.kernel.org,
 arkadiusz.kubalewski@intel.com,
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
 include/uapi/linux/dpll.h             | 2 ++
 2 files changed, 5 insertions(+)

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
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index de0005f28e5c..a277d08ac264 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_TXC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3

