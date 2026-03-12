Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670CB106ACE4
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 20:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D0EA4079D;
	Thu, 12 Mar 2026 20:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWdLIkrgHZ1y; Thu, 12 Mar 2026 20:23:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBFDB40788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773347022;
	bh=F0AjuU9hU6DJ/4e9OlLDjc0XFAYb4xcOmFu8pLLQO0I=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iRY1Yf5EIGRniLb6TpSGFIkbeNDlYE8jIdjlc4rdN1o4vC1DkysTuglBZiUD3PK+2
	 GdHqwmd7UTxfeoMaXV829GUtCT5688M+xTvROsFuzopwGMI5x7HnFDhEARwVpq/ha5
	 +2RxHRmbgr4eJGxfzrjvkjIRVpT4RXpTfK+2nAoSdYzsVev40p7KRHKE7yBpWqyW4G
	 RB4okUSRz8jHbrm9iAUJHVSbnIEz3GEgrnQtYr59xbJz7knS24+9xRQjfxRqD3m+C2
	 LuC1IoVZ9qZu/AWiiwZSA3QuFcp20gvbKel072Y2x3dUN0A/q1dLLzKp76zQzh215B
	 c76yXijSSyEOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBFDB40788;
	Thu, 12 Mar 2026 20:23:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E23C1282
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 20:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7BF8606E2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 20:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEoB0hDFjrGD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 20:23:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 13DAC606E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13DAC606E1
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13DAC606E1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 20:23:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E67A361336;
 Thu, 12 Mar 2026 20:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC95C4CEF7;
 Thu, 12 Mar 2026 20:23:36 +0000 (UTC)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Gleixner <tglx@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Joe Damato <joe@dama.to>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Sasha Levin <sashal@kernel.org>
Date: Thu, 12 Mar 2026 21:09:28 +0100
Message-ID: <20260312201024.845105273@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1773347017;
 bh=0t7Zjfl86gAcogx9eD4kCbzbz/ROtmtqZzdhjGQWNNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EBC2sHp8BEKLvcqIavCor6NMMLiyn8IENzdh7MajoEG4iS3bGR3tLqoq1IUxoZwTQ
 TWI5Din6c7APIBmonoRx+Zzfis8AIBop5zTeXspc63lrVZK71GEtAJBU8T3Cj4m4O/
 IJyD1GQ2NAWmELdhFQaX8lrcQT/vBLAH0orwqO/g=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=EBC2sHp8
Subject: [Intel-wired-lan] [PATCH 6.12 181/265] i40e: Fix preempt count leak
 in napi poll tracepoint
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 759f3d1c4c8f0..dde0ccd789ed1 100644
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
-- 
2.51.0



