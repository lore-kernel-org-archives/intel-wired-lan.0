Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AD1C88E73
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 14:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E944080E3B;
	Mon, 14 Sep 2026 14:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1u1jzi6I3zi; Mon, 14 Sep 2026 14:25:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 474F180E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395937;
	b=RMmap/Tf8gwDi8Phcf5cpTVL5Er/3zeDcfoo7yXGiQn6RX0461z6ocW+uzeszSOdZUYH
	 +61WBCjZhGHhagN1u5rNluTnrcPUMbNsi6/VazxKD2aTcx1ZBwHYIJKaAhfF6ZGjVLwu5
	 IjBXNjW3f8UH70/sGdm2oo6pIPuGQNOVg930ltDFrUBfEJOiCs6acQTT3dtdy0kWV3xbj
	 Y3otT7zw0VGbwZKyRUURfj2aourSycfdbelqky3qpyRE+pzkQ3e3gMwgpivZhUN8iPBtQ
	 79AX0cb52rkcpXH4QjAcEVmBqdKmPw+1vwcZXybcA7Pi6Q0CFS50NdW0y5zlSqiVH2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rs/ZLTNgkCNql9uBzxBgtNcF/3ONT5Z4V/ejoC9+NrE=;
	b=ISGqfKbwLhkvsWKqQ3u6rFgTdIBsjjyPVEunMmSCtKHJ3Vi+0E9yC+94EX7SSQUXgS/A
	 0EH7TFdhVIOsvNghWOJUT/+aJQueJeB7nhDNvg/r9agyb7kQkP36/aPP5r1EJMdtNFShO
	 o32aTruNaY52PhaH7Ng7XhsBWeE9kbaLW5Jq6YIH0AuYeSoj9q2WAJRYNh6c+ycXUoMXL
	 JGpm5Gn3j0wkPArCK5aclOyPgkTjOg2IzfnaLttrA3xvDuJLjohiYDu0vLzeaOvmF1Jet
	 gJNz4G943yv9rN4O3elrEBAnhTt/YH58vTr1QqbDPJqlfn/Olz75fl8IrP7VfPoNVPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=ZvZQObku;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789395937;
	bh=rs/ZLTNgkCNql9uBzxBgtNcF/3ONT5Z4V/ejoC9+NrE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E5HoKCY1jfVmCAPJ9doLQfY34J1nx2u0Kc6rQMeC9pdXMtqCnmwHBMzusfsz4DbtN
	 573mFWd0ADrCVGJXbdWfZSYBCwd0pXDUYkKUxeNw8lfXjyA3wrpylY+KR8zFahCSrR
	 yILbcFDWtewFkzHenBI2rjMuKoexx6uaRspzicccsOrTyi4rR8dXT7f65nRl5rvUrm
	 I3NWfwQhEsjQNTxf0falkBS6eni8zScEPdZW6ZwyJ9CDpQMmzXiEdbD0eIYxMfST1v
	 h2FehcOabSHLTXpnCzogpnVg1dVdgkOji8s2TMK6Us9KgNzSjwN3WSrgIWthACJbkF
	 N40wGY1t6WAow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 474F180E09;
	Mon, 14 Sep 2026 14:25:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D27259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AB9180DC5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJVbJEm8REQO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 14:25:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5502080D2D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789395933;
 b=CwdFY1vVPMw4Ssa7EIQnFsXBS9fyFz1CZduB5ExKla2ASPqtC0oRaLQadkcIR/MuT16q
 xEGNR0PWAjl7zjNSbeCq5B/C6h8u2LKo7y2S/5Xc/JITDtTsMhvMKff7ZP/WBqyFRpL7J
 tzfgBVofoun+CfE/ETuVhmCeNzLQXI4IeUKcNg5uub36EkQfUdkM8zIs0VrztJlpuUWFg
 sE1rg3Lqm9zdP3evaaMMYSgt9373NyYVXO08BdubT11H/pxF0X2jO7aGqgjZhJSNzpn+3
 7hKTz47XjN+teJCDyTdGCqApwfYrcbwfx4q1jPOLwz9WVnIqWZCYMXCm1/sGfWRPUnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789395933;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=rs/ZLTNgkCNql9uBzxBgtNcF/3ONT5Z4V/ejoC9+NrE=;
 b=rmQDFsg4IMZDapy65/20ke+SIXRW7SGwMChCjH4qu38HC1Nx0bLpGgrU2XHY+1um/1tY
 c/u/3B+Gp0UlpPxCUL3s7pq/vpxbbvbyVDDpiFqvIzi0JKEwH/WVoJug8hrQ0CLEbtJqI
 RN/oL32xuGUeITagkw+MEC3RjRmpEDqfnDGWYSQN/Yq1ONR3RzYxsIdSs0uZyGzY+erJM
 vh8Oz5qIKleHXaoY451M0FjvoZapuvU250y2QeBC0pOrsAcwfey2MoEbocpKntAnsV2U4
 /gzAojuEi30ojpkmjrkQVyU5BJXx947XyJdkupGI783n9MjXN8Omnbkib4Gei2R7FQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=seu.edu.cn; 
 dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=ZvZQObku; 
 arc=none smtp.remote-ip=101.71.155.101
X-Greylist: delayed 305 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 14 Sep 2026 14:25:31 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=ZvZQObku
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=101.71.155.101;
 helo=mail-m155101.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5502080D2D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 14:25:30 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4db486d8c;
 Mon, 14 Sep 2026 22:20:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 jianhao.xu@seu.edu.cn
Subject: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
Date: Mon, 14 Sep 2026 22:20:14 +0800
Message-Id: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a04a537203a1kunma732cb61298719
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEtIVktKQ0JLTxoaGU0dT1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=ZvZQObkuF5ogSFfr3bGIqGhwnS3WAc0v6n4yw+yOhXZYNGxr037kXdzjGRaVMkHD3x5hnzIOOcBx9P3moXaPLpHuVPSE+U1mkRCe20Zh5pc+vhMuLgkogsNVQyMm1vy2MdfJuYxb+o1IkRzEvc8vQSJdz492g/8E5pjObAF/FiA=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=rs/ZLTNgkCNql9uBzxBgtNcF/3ONT5Z4V/ejoC9+NrE=;
 h=date:mime-version:subject:message-id:from;
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

e1000_request_msix() requests the RX, TX, and other-cause interrupt
handlers sequentially. If a later request_irq() fails, the function
returns without releasing handlers that were registered earlier. The
caller then disables MSI-X and falls back to MSI or legacy interrupts,
leaving those handlers registered against disabled MSI-X vectors.

Free all handlers registered before the failing request in reverse order
before returning the error. The failed vector is not freed, and the
existing fallback path can then disable MSI-X without retaining stale
handlers.

A QEMU e1000e test with deterministic failure injection at the third
request_irq() reproduced a residual IRQ entry and warning on the
unfixed kernel. The fixed kernel reached the same fallback without the
residual entry. The injection is deliberate and does not claim that a
third request_irq() failure occurs spontaneously during normal operation.

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad4..f55aec340342b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_irq;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_irq;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_irq:
+	while (vector)
+		free_irq(adapter->msix_entries[--vector].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.34.1

