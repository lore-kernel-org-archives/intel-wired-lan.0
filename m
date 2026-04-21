Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BDFA1FD7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Apr 2026 17:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2304F4112E;
	Wed, 22 Apr 2026 17:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rj0jGPRmQmJ0; Wed, 22 Apr 2026 17:02:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3ED94119A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776877337;
	bh=K8y1nJ5X+p53Tw+hj93PYyBGC4V7zERYLDg+mn/JilQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Btt87KWHkU02xE4zdvfLNT/q7BxO4uUnWQ3ubIXb0gmhv9iu7bHKiLdRIq94pHxaK
	 x9NyIeJVPVgkUHudasACMcj6st/YnfHHkivjhfNo54CWLW89iUpG9RSZ5CYEEv1ETt
	 j1vj6tlS0Nk82s8JFkMjHbpgk97YWVjQ7dD3gLVv0owUCf0Lc34YITBQ1Vw5aBVJ85
	 uci9vbtqDSwswY6AOhPdyZUR1lhPHO1ibtFaLd8/lPAUGeg/+zDx3DcvQ2sDsVYfc4
	 TGyPAGVJOabeJCSaj3N+BFM02Anm297RJ8DKx9TvdGdobJgANMekWRUOOo4z2aNuiO
	 9DiM4CLS2NhfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3ED94119A;
	Wed, 22 Apr 2026 17:02:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B94E24D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 07:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D254611E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 07:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3p5nH9tUx5f for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Apr 2026 07:12:12 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Apr 2026 07:12:07 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 37B4E60A3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37B4E60A3E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=14.18.100.240;
 helo=mail.189.cn; envelope-from=charles_xu@189.cn; receiver=<UNKNOWN> 
Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37B4E60A3E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Apr 2026 07:12:06 +0000 (UTC)
HMM_SOURCE_IP: 10.158.242.145:0.1904717626
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-223.104.44.125 (unknown [10.158.242.145])
 by mail.189.cn (HERMES) with SMTP id B4D40400088;
 Tue, 21 Apr 2026 15:06:52 +0800 (CST)
Received: from  ([223.104.44.125])
 by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id
 62d753c598464d8095105b9869314739 for tglx@kernel.org; 
 Tue, 21 Apr 2026 15:06:54 CST
X-Transaction-ID: 62d753c598464d8095105b9869314739
X-Real-From: charles_xu@189.cn
X-Receive-IP: 223.104.44.125
X-MEDUSA-Status: 0
From: Charles Xu <charles_xu@189.cn>
To: tglx@kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, joe@dama.to,
 aleksandr.loktionov@intel.com, stable@vger.kernel.org
Date: Tue, 21 Apr 2026 15:06:50 +0800
Message-Id: <20260421070650.3105-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 17:02:16 +0000
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=189.cn
Subject: [Intel-wired-lan] [PATCH 6.6.y] i40e: Fix preempt count leak in
 napi poll tracepoint
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

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 4b3d54a85bd37ebf2d9836f0d0de775c0ff21af9 ]

Using get_cpu() in the tracepoint assignment causes an obvious preempt
count leak because nothing invokes put_cpu() to undo it:

  softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?

This clearly has seen a lot of testing in the last 3+ years...

Use smp_processor_id() instead.

Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 33b4e30f5e00..9b735a9e2114 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname, q->name);
 		__assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
-- 
2.35.3

