Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E65C531F7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 15:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C37FE60A4A;
	Thu, 23 Jul 2026 15:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2uRD754ZGcV; Thu, 23 Jul 2026 15:28:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 044D9607C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784820509;
	bh=CUCNWv8oD7YDF6T8E/8s+X0juB1U4CFABiYC8t4aShs=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JsZTAWnAl93NV9Sc+OfHZgtalK0V15Ynqwfoh7+mgvQlTiJOs/ri5JrPxWRoqqI/K
	 NSpAK9mHFsTeQKghINjWk/bknFaXeOBR1ytrrffs9xXgpmfiLT3rMUb+vF+B/h7lwZ
	 2LwqTTo3juNweUiKO+jgkFAU3jnDF6nEVfkCeKifkHwYMYFerRA4UhlIE7N/9SX6EB
	 3gUvT38//vayV+kVbtuQSVk55zO9OMjEvO4+08aQEJgLRTspRjsPcyntP9ybhEknZs
	 SnlrdETCEhX5YWLvr7iqwGUlVt4SAxDBgOH/GfJK0Mk5MmhgK8EoM/vO0Trhmdf46Z
	 yL9JQbqXj6ScQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 044D9607C3;
	Thu, 23 Jul 2026 15:28:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0539F4BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 15:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF385403F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 15:28:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yATo-kVamwc for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 15:28:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1D2E14020F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D2E14020F
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D2E14020F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 15:28:26 +0000 (UTC)
X-CSE-ConnectionGUID: 0u4Ae+Q8QdyXpYlDeQ0uKw==
X-CSE-MsgGUID: B0cmgLTPRLuEJQ/BnZlcWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85331112"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85331112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 08:28:26 -0700
X-CSE-ConnectionGUID: rPmgNh7+Qni0waMO+gfaGQ==
X-CSE-MsgGUID: 3Pr/zLzyTDyS1mYt3puhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254092280"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by fmviesa006.fm.intel.com with ESMTP; 23 Jul 2026 08:28:25 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu, 23 Jul 2026 17:28:23 +0200
Message-ID: <20260723152823.645558-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784820507; x=1816356507;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nVW09tHwatvJw1o3NhAYKylZFOxKAC2afK9GLenPfwM=;
 b=HHlzDCpD3iZI3FCDDicKX7fzR8+U5FzoQsv854PQVpr7QRl2SjLUf0bK
 0op/hPeAQQePGAQr9bEu5mw7kVSxZg4m72MNPK2iYgl7eviY1CUmZvgu6
 WxgpMJvJjNQGEcL5ecBbGdBZQGvH7Ty9qrH4uljrD2oES4J64e9g4Jz6o
 ff2n5RYRjleA2xf5VdIT4daVFVxHSd9SKj3N0LLiIHET8QLsCqOZypKG5
 lCj6bCakjuSKvZZM79CK9GdTgq+smY9VppMI1+iSGTGqSHt0K41WXHdOi
 UmAISslichdFYfWFux6dpGxTYhMhr85rx29PUpvSXIQd9PYOLDIuBGhXn
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HHlzDCpD
Subject: [Intel-wired-lan] [iwl-net v1] iavf: fix VF stats not updating due
 to PTP command preemption
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

Since the introduction of PTP support in iavf, commit 7c01dbfc8a1c
("iavf: periodically cache PHC time"), the periodic PTP clock caching
task always provides a pending admin queue command, causing
iavf_process_aq_command() to always return success and permanently
preventing the stats fallback path from executing, which results in VF
statistics remaining at zero despite traffic flowing.

Fix this by making the stats request unconditional when the adapter is in
the running state, rather than relying on it as a fallback when no other
admin queue commands were processed.

Fixes: 7c01dbfc8a1c ("iavf: periodically cache PHC time")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f5697d9c97fe..a05bd61d7de1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2986,18 +2986,12 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 				iavf_send_api_ver(adapter);
 			}
 		} else {
-			int ret = iavf_process_aq_command(adapter);
-
-			/* An error will be returned if no commands were
-			 * processed; use this opportunity to update stats
-			 * if the error isn't -ENOTSUPP
-			 */
-			if (ret && ret != -EOPNOTSUPP &&
-			    adapter->state == __IAVF_RUNNING)
-				iavf_request_stats(adapter);
+			iavf_process_aq_command(adapter);
 		}
-		if (adapter->state == __IAVF_RUNNING)
+		if (adapter->state == __IAVF_RUNNING) {
+			iavf_request_stats(adapter);
 			iavf_detect_recover_hung(&adapter->vsi);
+		}
 		break;
 	case __IAVF_REMOVE:
 	default:
-- 
2.54.0

