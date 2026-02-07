Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DBE7E0DA
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 288FC83C0F;
	Mon,  9 Feb 2026 18:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1q01SDPgHwvU; Mon,  9 Feb 2026 18:41:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3766483BB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770662487;
	bh=lRpoA/wR4sCaVexOtN08fA3r6Hhmh7+YIvC3Eb6K1RQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6+4xq180EhFlk5JC6WgcJu/FBAVW4ObwWKRNgHnWINutDvx47bUBT41xbASN+okkb
	 Y+P/rPnwGrkuCU4SRNO68/dEhCCnOe8FJvYkf0chspUVqgafP296on68Ydowsi+INJ
	 phvuI065gENlEqJ8nG0+fMLTON3csdMM/RM5ZSv5qmURL9c3SjFfpvTJKjDIaudqoG
	 xvalPBFMfQfynzn/ZY7S9xzMgW4PbZYdgwxn5Ixok2nSQJgf/wjzE77m7WsmxGtQJK
	 oZhqk5FB27GfAuZ+DWGg501W54xV7ZC8oZuOlun6BAwrviXPm3NPlx8KxdHLhsfKSC
	 juJtp+r0VEEWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3766483BB0;
	Mon,  9 Feb 2026 18:41:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B06D52C5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 10:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADA8C60B85
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 10:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFk-GmVb1NQf for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Feb 2026 10:50:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=tglx@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0BF0C6087F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BF0C6087F
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BF0C6087F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Feb 2026 10:50:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20E0840AFF;
 Sat,  7 Feb 2026 10:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BF4C116D0;
 Sat,  7 Feb 2026 10:50:26 +0000 (UTC)
From: Thomas Gleixner <tglx@kernel.org>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Date: Sat, 07 Feb 2026 11:50:23 +0100
Message-ID: <87v7g8zv2o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:41:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770461427;
 bh=6OZX7EKogGNAZsj0RNloLVy4u0hDyHPuVJ6PiQoyoFM=;
 h=From:To:Cc:Subject:Date:From;
 b=T3KOAyK3mZst5PAQO0GLwVxw2hHoLOlvJTwpPyVaPh9LEafu24czTJMdXYWSlRtC9
 xJkbuO0/CEn3F9R4zrAT+LUh4Ma+OZ+FFd/FtKcXscXoLP+iWkmKuwT7hsV5AzdIbA
 nYvJV5dirxKCQ5ORQC+F9tL8x5GD6M6ug9yl69R2b8/+uK3owKXmI3uBvxN6wGXx5C
 bqijkUOk1JlwNZW0Z0odJ/1q7iUeApUJ94vFsyb+Xv9Q9AnAUOfPoYzW39aZ+dSjz7
 v54TaNYEamaaqZepoTFJmIer+SpmFSiggncj6NPbhKWq83eg4EvcFzMsbrDVxkxvTS
 Ac0ZlSFjFy9KA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=T3KOAyK3
Subject: [Intel-wired-lan] i40e: Fix preempt count leak in napi poll
 tracepoint
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
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname);
 		__assign_str(dev_name);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
