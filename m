Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC02106B504
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 20:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EFFB8169F;
	Wed, 25 Mar 2026 20:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gu6EEk5S7kKI; Wed, 25 Mar 2026 20:51:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18887816A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774471892;
	bh=e+ypmhgEo15svmjeaPLlvAZjVEpBxo8jHbFD3xFAMjM=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZfHha1ZlnfjKUZ91ySJViMp6HT3DzF8AMHsgJkIF2Rzz/+BKzMKKD+RrRlyF1N08v
	 QWbmWrdQ1ZshNHpvu2I1MYzpkqJ/51kOMou0Bc/qZsfd0bGF57MNp05AWIDnVuo7rV
	 VCSXyU32a4ROgC6OtnLV54xwYisVbr87ljPX1nNSR0S/3imn7A1bkaJfR4kSvPjARq
	 eDu8RLOnLI7RCwTwaZ/juyNENqSv+PcW4yEC1xlICypy2L4s+w8ODk6UlItT54UzJz
	 zAxIW6WGLsePsRApB72G8k76UCLvRHlwi7mSCE6HYvbOnB1FP8H7UHcBe4Ydc2rm/m
	 fcRIXvu3P5PJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18887816A4;
	Wed, 25 Mar 2026 20:51:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05A46F5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 20:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D688C40216
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 20:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_1BocXsCbqt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 20:51:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C82794008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C82794008C
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C82794008C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 20:51:28 +0000 (UTC)
Received: from ms-a2 (39.25.31.150.dy.iij4u.or.jp [150.31.25.39])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62PKou8B020293
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 26 Mar 2026 05:50:56 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shannon Nelson <sln@onemain.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Wed, 25 Mar 2026 20:50:06 +0000
Message-ID: <20260325205054.109822-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=e+ypmhgEo15svmjeaPLlvAZjVEpBxo8jHbFD3xFAMjM=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1774471856; v=1;
 b=lSUT0jRI1tAoWK5D8wckc74+l+HU26AoMJa853f/ULNa73hsWYW6Sk3J3x9pcD5y
 RIeaobmuvBF+s+DVLQYilGkBPgXs0AWQr6B0foQjHbWjgDBCHGDQdFBhleAWmTs3
 VuFeLz3y0/XQWGxreyXY55v/9KcfkpCeztMIFzb83ej5bVH4q2uzoQrtbQ2ImzCT
 H69am2/zMVOqKbaTRqFd7/Tn305KcKzvtSPto3nDh+fCVEtXZIACnKOZQYEvsAlj
 CWPMUae4CVUrNIZP65nz0xQG8OXoDnc4VxMqoek9v9jiiQEvdiMD63LhV3Fn4/CQ
 DRVhYrpsEVyqMgod0NUvbQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=lSUT0jRI
Subject: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
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

i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
socket option. However, this option is silently ignored, as the driver
does not check skb->no_fcs, and always enables FCS insertion offload.

Fix this by removing the advertisement of IFF_SUPP_NOFCS.

This behavior can be reproduced with a simple AF_PACKET socket:

  import socket
  s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
  s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
  s.bind(("eth0", 0))
  s.send(b'\xff' * 64)

Previously, send() succeeds but the driver ignores SO_NOFCS.
With this change, send() fails with -EPROTONOSUPPORT, as expected.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3749f32ef95a..a3c52aa6255b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13831,7 +13831,6 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	netdev->neigh_priv_len = sizeof(u32) * 4;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	/* Setup netdev TC information */
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 
-- 
2.51.0

