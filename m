Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701CEF3C9AC
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 16:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C2B1613BC;
	Tue, 24 Feb 2026 16:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCApp1pvUfUN; Tue, 24 Feb 2026 16:22:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 563D0613C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771950151;
	bh=24QQdcjZhM80ilIGLqtANVCR5SSQQFNTsmuDLQafI8g=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mm36g+WBm78TIPCuceRfQsDauS/VS7tipkENmTiIDVqlVBzyegZXCZNIlLJmCde6x
	 61cI4UCy625xXpqC132T67ha/a9pDmDAygqSj2R7c/QqRNOAud6io4+7vTycL8n8Pl
	 lDi3uaWzMYL2nCsz5udcr5ek37O5+1JJHgTVyfEqTi0NDPR6h/kxvG+0/PIJIidO0v
	 XhdKIegBqtHi/ji0GKPKVAv0WOTC2vHqhEz4EXq71rFGlnxs4/MGnTETFx4WhlvCbJ
	 IJNGYqhP66VYd2mAb4Tl4bu0YHRCvVg2c9RT31VwXyB+jaduQMwgTs3bGmwHtW4Mj9
	 lmCl2XVqQEfjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563D0613C1;
	Tue, 24 Feb 2026 16:22:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17D81237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 22:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1723403F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 22:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vm00losfZTqY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 22:15:36 +0000 (UTC)
X-Greylist: delayed 779 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 23 Feb 2026 22:15:35 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E83A840095
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E83A840095
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.188;
 helo=out-188.mta0.migadu.com; envelope-from=bart.vanassche@linux.dev;
 receiver=<UNKNOWN> 
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E83A840095
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 22:15:35 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Date: Mon, 23 Feb 2026 14:00:19 -0800
Message-ID: <20260223220102.2158611-20-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:22:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1771884146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24QQdcjZhM80ilIGLqtANVCR5SSQQFNTsmuDLQafI8g=;
 b=pijj5riv5kFPKmLqQUVK+pOjN7QnhmxBUd48g2Viq9ScGi4sbhQgwJ8iiTL3PeF+rPamzC
 1g01hKQcYtenZ9jaO5OVgqWhneyq+DJJ+lH3ioV2EKEIlPdx+4lHJodiv3i30p9AEWlMmf
 M1w1Y+bnvMWF1sNzftb60qSGXr2FLfA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=pijj5riv
Subject: [Intel-wired-lan] [PATCH 19/62] ice: Fix a locking bug in an error
 path
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Bart Van Assche <bvanassche@acm.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the ice_query_port_ets() call.

This patch fixes a bug in an error path. Without this patch pf->tc_mutex
may be unlocked in an error path without having been locked. This bug has
been detected by the clang thread-safety analyzer.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c001ee..78ded6876581 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	mutex_lock(&pf->tc_mutex);
+
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 
