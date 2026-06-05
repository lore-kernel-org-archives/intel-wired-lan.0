Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0ECCD6E7D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jun 2026 15:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE0FB60C13;
	Fri,  5 Jun 2026 15:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oa8sFMkcA4Xb; Fri,  5 Jun 2026 15:25:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB9B860BF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780673143;
	bh=psMPm5lvDOvLaj/bPXlH1ud1R9wUuRmpSaAB7JVTHis=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hFdNSEUK1/TEBqaydTS9ZnLut0pYnY2r5TgLkOyOtDSmjeJGfDx4rf7Gwpg8ujpOB
	 utqXoWepxjgPoVl0DgFvWKuXvIqYw03Kwstc53OVu56CfJhUVjYvSO+ENwVDI0SENG
	 BI9wsxNA7OkG0rn0FV/VdZ8z4HKPYESSUifJfY8vfu/iA9a26YEi6kiK0VboWkqTqD
	 yMTEBD+XM8ZWLNNntjRNokYyq5pKOxNhtD+J2o7zzJdUbsdhWEMKrDQrWgaldjjz/S
	 4dm+r+XSBnyM0GiyACOdOuwxMsYa4fo/ApcNMzt5qTx/O+fadtPOr+M3wWrEqgFGAR
	 /y0cLrH5vyj8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB9B860BF3;
	Fri,  5 Jun 2026 15:25:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB176F4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB47F40431
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5iL2wq4CoQ4 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0D82B40461
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D82B40461
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D82B40461
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:40 +0000 (UTC)
X-CSE-ConnectionGUID: A3zafB8xRieiy8gHUSg9lw==
X-CSE-MsgGUID: PocKDVowRSGVWtp0d98WwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948975"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="106948975"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 08:25:37 -0700
X-CSE-ConnectionGUID: 59Ny/TS+RIWX3hsBvbBD3Q==
X-CSE-MsgGUID: OaCPqyhDSLG05ma0avE3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="249798860"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:25:32 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Fri,  5 Jun 2026 17:20:24 +0200
Message-Id: <20260605152030.891570-6-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260605152030.891570-1-grzegorz.nitka@intel.com>
References: <20260605152030.891570-1-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780673141; x=1812209141;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IlOl2lTbjJvzf3VEWq4GBVISiao5ux55lRmLsq8H/Qw=;
 b=PlNjZ5DG4vcENgG/nEu+FBF0IMKINGY/7c5jKaFc6X59eGw3BFrJprit
 pXXxb6vRQj7VWV831Abkk0lZbe27TLhnEM7oYWF8x9lVIMaidBoW4NOFA
 Tw/qRy189PoamvgthlCliEvnA30HhPdh1n/bmhdRuqmG5nTV/gCZDmI78
 RvvFJaL+hxNEpsPBO2gVbZvl/2jVRuqAMepJTQFmtLLGxEq2E9b6d2MjI
 BPCwGVMBKMGXcuELmIsvhzzK5zustJEKWKiwaiUQs/ZenCEHrw7WZWjfL
 ngY7QWD7RNbyUhnjryzxDwZHzsB6AUkMHmGqaY5BfYb4DnI0Aq5e3z9ac
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PlNjZ5DG
Subject: [Intel-wired-lan] [PATCH v13 net-next 05/11] dpll: emit per-dpll
 delete notifications in dpll_pin_on_pin_unregister()
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

dpll_pin_on_pin_register() emits a creation notification for every
parent->dpll_refs entry, but dpll_pin_on_pin_unregister() emitted only
one deletion notification outside the loop. When a pin is registered
against multiple parent dplls, userspace sees N creates but a single
delete and leaks per-dpll state.

Move dpll_pin_delete_ntf() into the loop and call it before
__dpll_pin_unregister() so the DPLL_REGISTERED mark is still set when
dpll_pin_available() is consulted.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 80195f3a84f3..58034be07080 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1036,14 +1036,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
 			continue;
+		dpll_pin_delete_ntf(pin);
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.39.3

