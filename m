Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F58CD8C8C
	for <intel-wired-lan@archiver.kernel.org>; Sun,  7 Jun 2026 18:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AF1A4088F;
	Sun,  7 Jun 2026 18:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9cChtMM_aId; Sun,  7 Jun 2026 18:36:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA126407C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780857370;
	bh=MyL+eofIi3BL6aPxZGcmJDRlRuUxTfhatFhqvwBMtI8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dTWUOvUo5nTdfFxmYFPcfQAn0UMl2JfvMCX+Hn8jn1JMfT6jzrLKRxzckKzIvf9r2
	 PVoiN8H0qBy4n9wvf3GxHNlQ2ad3QWCF/RO8MV3H+quqOfS/oZKJv6j/RyT4R7cT3I
	 EZaFHZVxmZPZkYx3PeEuKaltd8b6l+VmkTaI/rnU14V0f+/kg/JDWMWa1eImfEgv1f
	 DPiLTSPh/Iml95X5t+sAgnAK91qp9UybHCu/e5QSsyxL1IIFDqRz+Wogbpe4herxqO
	 joiN0j5jBw2oVCUZikNeN31+9E6J67ZSubLQwagk44wKkW41P1MIZT5j+cBOHOCaB0
	 SxebC2dEcRvww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA126407C9;
	Sun,  7 Jun 2026 18:36:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5461345
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6CB280D89
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdZRwWFJ8ff2 for <intel-wired-lan@lists.osuosl.org>;
 Sun,  7 Jun 2026 18:36:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A15AC80D43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A15AC80D43
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A15AC80D43
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 18:36:07 +0000 (UTC)
X-CSE-ConnectionGUID: 6MPm/1OOTGyctGuyW0gO8A==
X-CSE-MsgGUID: wcRimpWwTROR6gLL5DJdVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602109"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="81602109"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 11:36:07 -0700
X-CSE-ConnectionGUID: G0bckApxSPGY16CCQQxCtQ==
X-CSE-MsgGUID: iPgD75WXQA6PCGKwvcSMPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="245171448"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:36:02 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Sun,  7 Jun 2026 20:30:39 +0200
Message-Id: <20260607183045.1213735-8-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780857368; x=1812393368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fwCPDXwHX50TF2F6sSd9ftV4aMKEeCNes1mJGAuv0KE=;
 b=QiGtcYcgPp8CFgqBkhg+0WHClRO2PGO6Vo8AkveBdKM6MDcRnN6F8IBR
 MUCCImdq9+k2nd+j3LGebxC1JXLFpdLCorX8nZGBhWgxHYCrOowVaM76n
 L5ZIsV6cjIn2lvT80wbqNQc3caLvCstftuZII1l5eTZtVMlQaKJwWI8xc
 BbZs8e4xdNsCi/gG0BYEAbvLjWoshOctBfVeLd4y9TUemYdZi1gJq9eDj
 qlKM1Ms5y1xvAw0gNCbYeyLVPJ7Ixv5RhMQLVHuGqlRBQ/cewDkinOjKZ
 WE6ZCVuA8O4g19Iw+8CCKytIRkfvxZ9oljWuXoXV4V5ewLTcegTXywD5G
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QiGtcYcg
Subject: [Intel-wired-lan] [PATCH v14 net-next 07/13] dpll: balance
 create/delete notifications in __dpll_pin_(un)register
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

__dpll_pin_register() emits dpll_pin_create_ntf() internally, but
__dpll_pin_unregister() left the matching delete to its callers. The
counts then diverge on dpll_pin_on_pin_register() rollback and on
dpll_pin_on_pin_unregister(), leaking stale notifications.

Emit dpll_pin_delete_ntf() inside __dpll_pin_unregister() and drop the
now-redundant call in dpll_pin_unregister().

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index ea45bb41376c..1aaf62775408 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -926,6 +926,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	ASSERT_DPLL_PIN_REGISTERED(pin);
+	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (xa_empty(&pin->dpll_refs)) {
@@ -953,7 +954,6 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		return;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 }
-- 
2.39.3

