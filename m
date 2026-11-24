Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AC606A695
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sYvNdrT+;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=COS+ILg0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49456606F6;
	Tue, 24 Nov 2026 23:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFqd7S1WX5-G; Tue, 24 Nov 2026 23:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A505E6076B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564665;
	b=hXn5QWMuhMV0k8Qz224OJDPvNfcm1BvJWJRd0ZGzYMObofSZwLEH1AW5P4kpWjEhNwkx
	 q4vs9MkfF1plJhpo7V2zqhQyDZLaPBwyiDMdw5InxShMm1emOdDe+2KH9kmc9/8Paf0+B
	 jNX0hYcM3em3iB6hKKOJUyW/Xy4NGqbFoBs3xUpyk3KT2RngoRo+sXJQAGgpP9iB1X1TZ
	 cP77nT/oeS/rFtQetS1/qg/C5KD9XyUojOFW/N7R9P4L/qaxzjs/pfiKOjohJoPZrcwlu
	 SETnBUr8uSZpC+ot6HvaL8mZl/RRGX9qGF0ehA00WGa75qSzFPWMFTuOzPwnFA8yMeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nLNAbdcbhe94cKt1uJgEZAT+B3+pg7rFP4RoRlJ/uUg=;
	b=pd4FoCJWsMEUW4TZ7Ot2OY4TWmNqd8L7cggujWQ7rdmhPaP5wSWd5Y79XjiJUmafiKC1
	 sDaDfEzhvvGABUTDlPelvTsB/MgXCLrIwsbgYZnf0PEuHSK4zoTQlaT3bG+0eFFjOShTm
	 Hnvr1oUIlkCgSIhcbzrnnw5OPQAafUCWiZQqxDJQkPgC/xNB0dsVvEo2gNyq5WkwZoGKn
	 llN2CejzxP/CD8fpQqTQjw2rr76FobkNseGe+GssYs/a4EZzYXaHEC/mX0G6z/bd+xf91
	 EcAtgfoZmxvErdGPVHmHf3SXPyzxvHWF91JGt3Wugxpjk6hzR1G1R3ccjPKBz2eYOWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564665;
	bh=nLNAbdcbhe94cKt1uJgEZAT+B3+pg7rFP4RoRlJ/uUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYvNdrT+N/Q/k/bnq0Jk081iSRGmTJYJbUGv5my4Flwy/0V0DgIF2xVb1gJvX8vxp
	 omg2cHJXgjbhaVEY8J0A8xIQNDBe9+3GS68G3VFFLpKTmpTSsEdMm782s0UNHON86a
	 dnKJ++JcrVCLkqKdbzIjVXFY5IgcrKH7UHK/bqEcOZ/t0wqgR/bAwDBJrVBaX8CzgS
	 AE7hwh4VJBreaTMkmYZPFoI9YsLXV3S9r7zYb/GS4tPwDqmmG8iJC8yT82WimjFt+/
	 spk7m5WBcJy/qraROGJSAaPLG1S7Z3br6f4jeWD3C11XcNdv0/37KI9cr2HYfgGl6U
	 s0WaxalpgmMkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A505E6076B;
	Tue, 24 Nov 2026 23:57:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01E512F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E872F405AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m972scVPb_PY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B44E404EC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::105"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::105; helo=mout-b-105.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=COS+ILg0
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org
 [IPv6:2001:67c:2050:102:465::105])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B44E404EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jZ09Y387Dz9ttS;
 Wed, 25 Nov 2026 00:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLNAbdcbhe94cKt1uJgEZAT+B3+pg7rFP4RoRlJ/uUg=;
 b=COS+ILg0iXL4uTSMflkkkR1xtTGh0GPyXrtxx6BTex0cDfcqYEBblZEadkQUxEMSslMyYs
 ie/szoviBKG6/BTEhjyCQBLF29EzWIOQIW0nikKpxaJLJ4ZfVRrsV2T4u+dSTSjNQPJgUm
 zR3mVYm0MaxxilOIfNHwy7ovCG1jixeBUxnNfAc92E63CDW+uSnVGtCcrqya1qIjrC9JI8
 a1MMdjdfwcwT+j8hdczMB3PMkyZK6BiBd7w20KJTyDSSd+AisWxI3ymNArxJyZ04NvvRyE
 PXpB/I5fQK+FJeExM/zBiilQQiOlYcQ0J8WLcqZZSSY09SBRl5U9ArcBF1eQEg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sven Auhagen <sven.auhagen@voleatech.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v5 5/6] igb: resume the device before changing XDP or XSK
 settings
Date: Wed, 25 Nov 2026 00:57:20 +0100
Message-ID: <20261124235723.1135808-6-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09Y387Dz9ttS
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb_xdp() can run while the device is runtime suspended or resuming,
and __igb_resume() rebuilds the queue counts and the rings without
RTNL. igb_xdp_setup() and igb_xsk_pool_setup() can then see a queue
count whose rings don't exist yet (NULL dereference), or a NAPI that
isn't enabled yet (napi_disable() never returns). Changing the XDP
program of a runtime suspended device also opened it twice.

Resume the device for the duration of igb_xdp(), as ethtool does. Like
the other resumes done with RTNL held, this can still deadlock with a
runtime suspend already in progress, which takes RTNL itself; closing
an AF_XDP socket or changing the XDP program is now one of them.

Tested with the 82576 emulated by QEMU by closing a zero-copy AF_XDP
socket and attaching an XDP program while the device is runtime
suspended; the latter no longer warns in __netif_napi_del_locked()
because of the double open. The races themselves weren't reproduced.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: new patch (Sashiko)

 drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index acd9a33..80ae03d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2942,16 +2942,28 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
+	int err;
+
+	/* The rings only exist while the device is resumed, and resuming
+	 * rebuilds them without RTNL
+	 */
+	pm_runtime_get_sync(&adapter->pdev->dev);
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return igb_xdp_setup(dev, xdp);
+		err = igb_xdp_setup(dev, xdp);
+		break;
 	case XDP_SETUP_XSK_POOL:
-		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
-					  xdp->xsk.queue_id);
+		err = igb_xsk_pool_setup(adapter, xdp->xsk.pool,
+					 xdp->xsk.queue_id);
+		break;
 	default:
-		return -EINVAL;
+		err = -EINVAL;
 	}
+
+	pm_runtime_put(&adapter->pdev->dev);
+
+	return err;
 }
 
 int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
-- 
2.56.1

