Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F229606A69D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=63A2Rfqy;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=10OFZmT3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEC40405AE;
	Tue, 24 Nov 2026 23:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czprKDOKySUQ; Tue, 24 Nov 2026 23:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D87C5405BF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795564664;
	b=Dk82WxPqthVE2gPLfEf3F6xqrxNU25M+TEAcn3/e+AZplfowaH+Pl9xTPTF4gedIQicC
	 J5zkYTn4kOIMBkc00c2zP5d1Gvp1soeTE5Vql7zrlNv5e6D3SmdWwOOEpNQw/XznuTttt
	 PzuEf25JkFR4JZXmaL6Sd8Q8sr5qE4+NPvKLnfCJKiigFQp2DaVGQSydRL8qDP59W0iz3
	 i65kV6ODOn+jSQ4WZzl5Ot7S6jDQaj1vs1JA5h3MY/Nj7XtJdWVLtMkK8bmbgqkQl63jK
	 LL/ivfStUW7LNoWPIzc70Zq5gTbAcqq1MN04HY5x3JEzJVcw1YETvwqDgEi2aGk6jAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795564664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wCMeyeId4pxu+z1tczoA9noYx9DObdHNjkQk8bnS1Eg=;
	b=iq/BMB4FQnwpWba+deY8DOqfEhgCBfqHKGUuBRXMG+r0r5qY2/10/yEAxbq+O+piJyM6
	 /GXUsrnswrWd9GZY34etP+BEqJuFlMsyXX/3LULk1cSOGuCreBLNLdYm5XlAWsNF11ANi
	 dIObgMXQCEUTlisg5q5vebn60Id/9yxa0YOWgEMV8t47AQcK3qHbXjR5SIipbF2DpYVzL
	 R9LTdZEwTu6/gld6dsSf20yRv9sLtI7lpFe8cVMN1VUIGOMGevaTKEJqkkte2uLZnHtBy
	 V2aAhSNda8bSW1kNOXQqEWl1O0EIqRyCsK4r93bU3iQNr35B+1wb8G58OP+HIM72kdQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795564664;
	bh=wCMeyeId4pxu+z1tczoA9noYx9DObdHNjkQk8bnS1Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=63A2RfqyppVJkttj8MgDq4WyIdPHuRnwu2NZgz5uZbFF8pbZ7pT5IHznEujusaxKX
	 l0SLFmtVW0H3uTRo97ARDbtcSgYg+LtHzS18z8NkC0okjOvK/zaS27rv5WcQfVwwDT
	 30uAmzntjYEFb9Vcq+YuYfgVDoK6tUIDprbpFv4/wq83dAVXuPjeC0EtWSQLeBxy8+
	 kTg01kAoo4cNJwNxYBVtfmOl19HGUmXHgboZClBZqxTr23ItppeDHHrWwWxo+OzDek
	 h31X3zzrs9oc4szCBfXtaZMDh6cyOtn6dWdnBDjo1+AWn2Df0/YBbMh4YggtMxH4q5
	 51AkfrvtHEhog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D87C5405BF;
	Tue, 24 Nov 2026 23:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCCD72F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2A6A606F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UN7pFNZ645Ao for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 23:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B8866065C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::112"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::112; helo=mout-b-112.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=10OFZmT3
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org
 [IPv6:2001:67c:2050:102:465::112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B8866065C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 23:57:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jZ09V74Tqz5xNV;
 Wed, 25 Nov 2026 00:57:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795564655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCMeyeId4pxu+z1tczoA9noYx9DObdHNjkQk8bnS1Eg=;
 b=10OFZmT3XE/7yACnOfiGMRZhZ02DEO0NYxtRJQ9LbqaLAIWdwTVZVqyGMztKoT0tj3yIP/
 Rp1MfArwwIACswYdC6y3ncJbVaFMw2c46YaEadmwwVdNxX1u+gZ7HZzf1fsJM4ZAeM1Sao
 cjsMdYWr32Wk0e9kyPNSW8Rg+elD2mwqV6RRSkOMEz94lZeDN8LaeDs+oAKURt//7lrGfb
 81a4zIVjdXysGZ/5Ro6XZBHDORWj5BrtTjC+7ig7PTJSirsCcoWN6JM3/Qt+TCcpwANYOB
 tckUCsDAS5BJHT2wyXEbPwMnMjRA5WRIficCNbFpkTdl9wea4fxveqVbGxQDrA==
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
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v5 3/6] igb: keep the stack's Rx queues that still have an
 XSK pool
Date: Wed, 25 Nov 2026 00:57:18 +0100
Message-ID: <20261124235723.1135808-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ09V74Tqz5xNV
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When igb lowers its queue counts by itself, after a fallback from MSI-X
to MSI on resume or when enabling VFs, xsk_get_pool_from_qid() doesn't
find the pool of a socket bound to a removed queue anymore. Disabling
it then fails ("Failed to disable zero-copy!") and the pool's DMA
mappings are never unmapped.

ethtool refuses to remove a queue that still has an XSK pool, but igb
can't refuse a VF enable or a resume fallback. Keep the real Rx queue
count up to the highest queue that still has an XSK pool instead, so
that the pool can still be disabled, and lower it at the next open. The
Tx count follows the device: an XSK pool is always bound to both an Rx
and a Tx queue, and the lookup finds it through the Rx one.

Tested with the 82576 emulated by QEMU and a zero-copy AF_XDP socket,
bound to queue 2 when enabling a VF, and to queue 1 across a runtime
resume forced to use MSI with a single queue (with a test hook): closing
it warned and leaked before, not anymore.

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Cc: stable@vger.kernel.org # 6.14+
Reported-by: Janis Edvarts Lacis <janislacis06@gmail.com>
Closes: https://lore.kernel.org/netdev/xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f/
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: new patch (Janis)

 drivers/net/ethernet/intel/igb/igb_main.c | 27 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f51edc..6961646 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4126,6 +4126,26 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	return 0;
 }
 
+/* ethtool refuses to remove a queue that still has an XSK pool. igb can't
+ * refuse when it lowers its queue counts by itself, so keep the stack's Rx
+ * queue instead, or the pool couldn't be disabled anymore: lower the count
+ * once it's gone, at the next open.
+ */
+static int igb_set_real_num_queues(struct igb_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	unsigned int rxq = adapter->num_rx_queues;
+	unsigned int i;
+
+	for (i = netdev->real_num_rx_queues; i > rxq; i--)
+		if (xsk_get_pool_from_qid(netdev, i - 1)) {
+			rxq = i;
+			break;
+		}
+
+	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
  * suspend: apply them from here instead, if the device is still up.
  */
@@ -4137,9 +4157,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 	rtnl_lock();
 	if (!test_bit(__IGB_DOWN, &adapter->state) &&
 	    netif_running(adapter->netdev)) {
-		if (netif_set_real_num_queues(adapter->netdev,
-					      adapter->num_tx_queues,
-					      adapter->num_rx_queues))
+		if (igb_set_real_num_queues(adapter))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
 	}
@@ -4208,8 +4226,7 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	 * runtime resume igb_rtnl_resume_task() does it.
 	 */
 	if (rtnl_held) {
-		err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
-						adapter->num_rx_queues);
+		err = igb_set_real_num_queues(adapter);
 		if (err)
 			goto err_set_queues;
 	}
-- 
2.56.1

