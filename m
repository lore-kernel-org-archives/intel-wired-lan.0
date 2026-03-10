Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E067EB104C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 11:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63FBE84234;
	Tue, 10 Mar 2026 11:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LW-ig1OJt2-2; Tue, 10 Mar 2026 11:13:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A33EA8420D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773141200;
	bh=ODX8lAzIpwYClXJtX9ELoN5GW51NhlOCfc466Bz2Hw0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OysM0tSi37iHonB/DfAvFl/d0Lr1eS4N6IeGmFQ/Jb4uLIHefBgl3pSP3c2irVIdr
	 1vi3gVjOLXz7VV3Hu1Qb98jRbV5eC7F3TYSG0+MTuEAtMPWbclz59yUwhlaA+ydOmk
	 K8Rm6WUunGVzUeiMwQHswKx4gcNdWq+tDrD89pFkE2CQOhUCznj/mKKxMQtyil4JDG
	 WLO7fe2gDBlawJd7ROFnV/uYZ0ZupowIxtTjRinjQuoShC4K3IwaNR59Xb2qu7m4WN
	 ffjYkFCmniT2nUU7euiMv/TaZbAkNCBdeVTIxj86dhmid7Db1jTHSIRHLKoJqBtE0A
	 sodvgzUqsnExw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A33EA8420D;
	Tue, 10 Mar 2026 11:13:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFACDB8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E09128420D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id px4T6yC6vCOB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3C1F6841FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C1F6841FF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C1F6841FF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 11:13:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A685D600B0;
 Tue, 10 Mar 2026 11:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58609C2BC86;
 Tue, 10 Mar 2026 11:13:15 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Joe Damato <joe@dama.to>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Sasha Levin <sashal@kernel.org>
Date: Tue, 10 Mar 2026 07:04:04 -0400
Message-ID: <0a369fdef8cf09371f72d1981cb0bee70fc00703.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773141196;
 bh=QccW6cyqKoTAs/xHLg87J6mZAwKWfrQURGqDAox24ns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AXLKWULTMoUJ2+l5Kf6I2KEA78ir7/HrEzazw+oXWdSo78dWokpjKd6m0tITl6W1e
 en/NIjJpFUfaCQMmv1q/WqqtfuY3pjTw5fJY/oz7P/BZ8Xe9W3DQYKEQRzhHnIbw0/
 DEtP1Ybe2SgtqCPlLI2G4gP9RCfbzQ3Ip6OEMsZtlPJetjQpVQ1/gn87z0H8msUdvg
 FxXE21LAMzd3+zs1rjuWzj0uPnq2rICCOpbB5jLhtnI/dz18k9CSZ6jQyq1eOovI9B
 0UrfscxqLDi3KZH+N35Ilgk60p02HnP1pHAuQXLSESBliPMy+0LiEeD9l97duuerr7
 Tw/S4QnaBUJWw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AXLKWULT
Subject: [Intel-wired-lan] [PATCH 6.19 197/311] i40e: Fix preempt count leak
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

