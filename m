Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C295EF584C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Feb 2026 19:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA2E682778;
	Sat, 14 Feb 2026 19:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkRftY4zhxB8; Sat, 14 Feb 2026 19:47:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A9AF8270B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771098429;
	bh=dW14vW0bCAsIh8E1yS8gm9g3TbcmJP4FXwB0iz6Id9I=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6YNyyAluZB9pTpckQJAovI0SJe8Ca7mytR9bDI6ksk1qMJQKfZ1Gcu/SV/UAFQRTj
	 QpsWE7Tckjb/CIkBIMKKDkLpStToZOXjAjof5PsZjhXskiJ122dq4CBjbpkR3i+2Ph
	 t3RsbcKrjIBRuqoOyuhohS/Do4BGbSZh6JhLjwN0VJndf7KjPaMpMByj833giDufcU
	 MzeryXleuDXxYIjlWAUHqamLx54/tRX3QI8SatepLI2pIzTe4e44M65zficsczWbes
	 AOgUJRpwF2o/YtpokWk7s39T2EvGjTRYsckQy/WWu+fS+IBB1cssykCVgBjiw9qQI8
	 2F9QLUlCCJ0IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A9AF8270B;
	Sat, 14 Feb 2026 19:47:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B98D31F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Feb 2026 19:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00F5740A06
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Feb 2026 19:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mevMJsMtTwco for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Feb 2026 19:47:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 091D8409E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 091D8409E8
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 091D8409E8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Feb 2026 19:47:05 +0000 (UTC)
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61EJkckv078694
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 15 Feb 2026 04:46:38 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sasha Neftin <sasha.neftin@intel.com>,
 kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Date: Sat, 14 Feb 2026 19:46:32 +0000
Message-ID: <20260214194636.295647-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=dW14vW0bCAsIh8E1yS8gm9g3TbcmJP4FXwB0iz6Id9I=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1771098398; v=1;
 b=I7pYEOQWqHvgSx+cNQls6fJP+/R6yBzAd3ZiTF8Gw0SfdKmtaqIpJwIbbi03IeTM
 5fNNh0xdhhXKnjk7OVa5KPUZw3o9grkre9I8rvXhu2OOmbDaFOP3MMpEqKefduNV
 ko8r5+hIIudTfzQqQSTbNNxeCq1doo0oOsiANaNzApq9zC5HoR9J9yI3JC02ArCG
 64neej+NR/9ARwsrFocUqxN2MkY/sCUWe0UD4HKYl/JzBoybVBfwyCH7M+630uLp
 B0xU3k1J077f5L9nkBvhB7eqXivfS61Wf/5JkWU/JTiVU1Ou0ufccdpUTLjSRZ2M
 UNn7eSbQVACDbysEfkPVIw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=I7pYEOQW
Subject: [Intel-wired-lan] [PATCH v1 iwl-net] igc: fix missing update of
 skb->tail in igc_xmit_frame()
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

igc_xmit_frame() misses updating skb->tail when the packet size is
shorter than the minimum one.
Use skb_put_padto() in alignment with other Intel Ethernet drivers.

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1abbdbebf8a4..7ebeca5333b6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1727,11 +1727,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
 	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */
-	if (skb->len < 17) {
-		if (skb_padto(skb, 17))
-			return NETDEV_TX_OK;
-		skb->len = 17;
-	}
+	if (skb_put_padto(skb, 17))
+		return NETDEV_TX_OK;
 
 	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
 }
-- 
2.51.0

