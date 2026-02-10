Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA187EA813E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Feb 2026 15:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D03541165;
	Tue, 10 Feb 2026 15:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lc1Uq-J3w3gh; Tue, 10 Feb 2026 15:58:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3EA341166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770739126;
	bh=AV99yFS6N2XH5Ncq0/NTS/CftT+Jd2zuUBJxQTuidFU=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xt3cD3LNoee73BWrjiI2vwAeZePVgbeslz227zmf1RweBbzK9c3v1ETqZ/WbZ0ISt
	 s+3M7g/rJ/mmV+gV3Wd4JV7D6yYJBdNYKp2Ug7piLQY3JaxZdhizLkDcjxvB+gK052
	 6KQ8tTBpNJovceaNIPK05yh4/KIHXLr0dHDRqIh9q/EN6wgSOKK+eOKpkoPNOre/P5
	 nYVRP8BXjWsHGCEFZ3Y4wlF2fq7Ma8vxO8SBDUyXlCGLYqC0hUGGpPVsQPtxW5DHYM
	 OsFvNTBNKdkDysMNY8IIz0klqiOpPP/8ImnFxPNxOjKjEPFB+D/m7haGIsT6xwD0yv
	 49TY0NfvQqTVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3EA341166;
	Tue, 10 Feb 2026 15:58:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55D23219
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 536824116A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWItU6neShTG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 15:58:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4D6A541166
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D6A541166
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D6A541166
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:58:43 +0000 (UTC)
Received: from ms-a2 (227.25.31.150.dy.iij4u.or.jp [150.31.25.227])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61AFwBhg052279
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Feb 2026 00:58:12 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Tue, 10 Feb 2026 15:57:14 +0000
Message-ID: <20260210155810.135577-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=AV99yFS6N2XH5Ncq0/NTS/CftT+Jd2zuUBJxQTuidFU=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1770739093; v=1;
 b=P43r5surwhqNi1X2pF7KN9sf678WyvqiBOt8ni5kpFQ4GKnZETg+JekWTNSJ7+FV
 EgDjDm6LKXpYK0C9GSIKOzLBHo1JIhgP7yfhZ2ik2sZEEpkbDBhnkw8j71ioJjmL
 P8dFILQgn1c/eB0LNdjWgNopbZeRKPmb3rFzmREIml3QRM6oHQ54Dq9d6rtDghJX
 sYiUXa1Vy3sjDpEKKyePCfdbzlMTeDgqoW8v+vFBsAxRMMdDE/M8gtAtkchxGzqU
 SImjiTgYYm6XOi5/Ebhmrg1xBkg0SJmuRyab3DUsqmc04X25wIe4SkMRQHZnYDc/
 7X1Ra4NaeKSpCTN4tVtMdw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=P43r5sur
Subject: [Intel-wired-lan] [PATCH v1 iwl-net] iavf: fix netdev->max_mtu to
 respect actual hardware limit
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

iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
from PF [1]. This allows setting an MTU beyond the actual hardware
limit, causing TX queue timeouts [2].

Set correct netdev->max_mtu using vf_res->max_mtu from the PF.

Note that currently PF drivers such as ice/i40e set the frame size in
vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
netdev->max_mtu.

[1]
 # ip -j -d link show $DEV | jq '.[0].max_mtu'
 16356

[2]
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 ...

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Ideally we may fix ice/i40e to set max MTU (not frame size) in
vf_res->max_mtu on the PF side, but this would break PF/VF API
compatibility between different kernel versions and would need
modifications on code that treats vf_res->max_mtu as the frame size.

If it's acceptable to change the PF/VF API, this patch would be simply:
    netdev->max_mtu = min_not_zero(adapter->vf_res->max_mtu, 
                                   LIBIE_MAX_MTU);
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b625ce00b836..d911c634596a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2772,7 +2772,22 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = LIBIE_MAX_MTU;
+
+	/* PF/VF API: vf_res->max_mtu is max frame size (not MTU).
+	 * Convert to MTU.
+	 */
+	if (!adapter->vf_res->max_mtu) {
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else if (adapter->vf_res->max_mtu < LIBETH_RX_LL_LEN + ETH_MIN_MTU ||
+		   adapter->vf_res->max_mtu >
+			   LIBETH_RX_LL_LEN + LIBIE_MAX_MTU) {
+		netdev_warn_once(adapter->netdev,
+				 "invalid max frame size %d from PF, using default MTU %d",
+				 adapter->vf_res->max_mtu, LIBIE_MAX_MTU);
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else {
+		netdev->max_mtu = adapter->vf_res->max_mtu - LIBETH_RX_LL_LEN;
+	}
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
-- 
2.51.0

