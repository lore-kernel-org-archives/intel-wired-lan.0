Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9C21091926
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Mar 2026 21:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A489B61639;
	Thu, 19 Mar 2026 21:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiC88h8s85ES; Thu, 19 Mar 2026 21:14:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C35C6163D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773954849;
	bh=7Aa9WQH2nRMAPbiU5kLXI43Kh8UMwbZjiB4pQpdKyy8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Upv1N4AKcxBKZ9UL/wWfWMkeHOQB0zwBhyfbuTaOYlAdV09rB1WGaQP2xoqfqJABL
	 WIrgZ/e3hXJP5iycfjhLy+tWy5dovGupX7GEndTUFDG3/YTGII0EXStRoIiEyEUqFn
	 a2wF1WO9KaD2r8nA0FI8Fq7UpsBsHz632Up+gwloydOGVxCK6kQfdt6rYzWTA2dCSI
	 H5zx3ag+ETgyvfF9IXrIC4xhzeNdaq4bP69sX7Rsnf/5eQIT7bnj36jzWPpeJOpNAQ
	 MYQAOYIxbYAbrJ9F10W3DRGN9lBSFlAZBT6VTpIXe8448zg0NuunhLJ6hf1+0DjG8f
	 fLFjYrq1NzOlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C35C6163D;
	Thu, 19 Mar 2026 21:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C0511B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 21:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF54184395
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 21:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wLJvZeHHziy for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Mar 2026 21:14:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0385284393
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0385284393
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0385284393
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 21:14:04 +0000 (UTC)
X-CSE-ConnectionGUID: 5YtGPhApTdizboMNzPC6QA==
X-CSE-MsgGUID: uhg+h+EUTxWUPG09nzQFqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86116393"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="86116393"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 14:14:03 -0700
X-CSE-ConnectionGUID: 2EqDeqCLSlSYjS+eULEVQA==
X-CSE-MsgGUID: 3BQchCY/SRWvkrVajC8CCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227221178"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 14:14:03 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 sgzhang@google.com, boolli@google.com,
 Emil Tantilov <emil.s.tantilov@intel.com>, stable@vger.kernel.org
Date: Thu, 19 Mar 2026 14:13:35 -0700
Message-Id: <20260319211335.23236-4-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773954845; x=1805490845;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=yOUQh/Qr8P8XqIix5oGN+qhabvQxrLR5JATDwg1qSaw=;
 b=Fp38d8guxiXuP65HylGzGzCopoWGI0Tmaoq+THyIiEq78SR3kDiJvpXg
 XZvm9D7BG3PgYoDMclslW0kIed6BlBQETwtUue7CrJ/0sMrw9JBVF/ofK
 WS+oZoG3TPA1cYF1En+cGXCzgiwpNo7WyJp9fr4zeNz+ysNHjPZPYvYbc
 rAXjZvXOhPpFEewwySnwHeXGy/+nkXZ+mDV0vUG4fj/q/YGgkVIQ7l0+1
 T2LP6NU8HR1OW9iRtGeACSJ4gBuKPnVSpQvMW+WJtgGtO4N2hORmbfSE+
 SfemkfU+vipLabgJuXJSck/CoyMcbg3rHZZLIwY6bLzAOBdfnYHle9TOW
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Fp38d8gu
Subject: [Intel-wired-lan] [PATCH iwl-net v2 3/3] idpf: set the payload size
 before calling the async handler
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

Set the payload size before forwarding the reply to the async handler.
Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
will never get past the size check.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fbd5a15b015c..be66f9b2e101 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -615,6 +615,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		err = -ENXIO;
 		goto out_unlock;
 	case IDPF_VC_XN_ASYNC:
+		/* Set reply_sz from the actual payload so that async_handler
+		 * can evaluate the response.
+		 */
+		xn->reply_sz = ctlq_msg->data_len;
 		err = idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
 		idpf_vc_xn_unlock(xn);
 		return err;
-- 
2.37.3

