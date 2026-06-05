Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5891ACD6E7C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jun 2026 15:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312B460BE5;
	Fri,  5 Jun 2026 15:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLRdMRIS4KnK; Fri,  5 Jun 2026 15:25:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 317DE60BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780673143;
	bh=KAsEQdu4J4FFCnQRbGXYtMh3MwJNO5xrDzgXUHeI0ck=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dvhdNvVaweD9dp5jPbTqUEDD1kNqD+LPdtck8/AL6SEsCJhfz+ize08ZrcNoTSHgw
	 XYKB77C/qn5mWFxUm9E2VdbhvscOZCQVbBhgTV9u22ZxbJ4innllH/BUbUNpvePeST
	 QbE2C4tRwjMInIfjwPYOH2A6/6bjPUd7usnjFfHE6yoyMHrBmYORIkGJyjLp+N6klo
	 MS3gRChI/ToxEFpMtmVl2niJeD9g9KP6FpZ0upgcAxlMQcxxewIgWnpZMsChpT4Xju
	 992lcSjePIa8bZKyj5IDMGNvb1VcpMd8zOSi5C855Fx/fccLrGD59kO02yhtDNnmzj
	 c8w2mRJ+j7LbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 317DE60BBE;
	Fri,  5 Jun 2026 15:25:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A590388
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B9C940462
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZxgpKMjFfJB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jun 2026 15:25:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AD95740431
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD95740431
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD95740431
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 15:25:40 +0000 (UTC)
X-CSE-ConnectionGUID: FGLUeb8kSfW4Fo90hK1zMA==
X-CSE-MsgGUID: qaEV32vrRy+2XJGMtPXLZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948958"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="106948958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 08:25:30 -0700
X-CSE-ConnectionGUID: LoQvJZlRRBS5HP+czXnLZg==
X-CSE-MsgGUID: oSg8k8s7TcaV2eR8wKFdrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="249798833"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:25:26 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Fri,  5 Jun 2026 17:20:23 +0200
Message-Id: <20260605152030.891570-5-grzegorz.nitka@intel.com>
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
 bh=7SLLTaGR04kcGW6NFlVhrv/kbAI3IG9DGTQq1xYnrM8=;
 b=lmWkauGPJMxv+twj+JS1tgYp0/gughmUA+MlJTvMtAICnaRR8kam3fxf
 8Ku2fh9O/qp62/n6Oj79T0vVz3t80v7eESfDqqEE3sbvBkiM9cnQfcW+p
 bLIuPah6nRsyEjB8LqPCFm84J6njgGiASplOQBeZUpuedQ1dAay0LFyEM
 g+dFU1XRyn35biTXvwN+Wr9Y4PwJNcCpMVF7jh884jb+/oZhJRDGnBIHC
 /vKPFe8WrfBe+zziukuWs3RDW53jnkFYtB4jPH5A1o/rbpqTuBX2goZAW
 6WQyxPRfZc4PbzYUAmwBiUvnd8UW8uOwjQD1FkqTr+FUZt8eAr2LVHdQV
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lmWkauGP
Subject: [Intel-wired-lan] [PATCH v13 net-next 04/11] dpll: send delete
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

