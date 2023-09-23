Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A40CE7A89
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 Sep 2023 12:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A98F60AA6;
	Sat, 23 Sep 2023 12:24:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A98F60AA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695471888;
	bh=tUdeN8hgR9khZW031BBY8Ejk0NPl2n0n4NznWc4MjrI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=d0godyjWOTBwhnEl0wuFFu1cVPfkB8Uwijss4oQhtF+qGq+vcLgNtNKK6V9vSg+M5
	 y4TeJVwWrtCAJ4xgInFtd6ybCdm9JaBV2v3tt2iUSeXyxfcSp3wiR87g6HRMNJRJks
	 8SQ7j/9rzwJgRaF4/NJHfEPb4WOA2CE+Ctxn0oy7r29qFEPlZCzh0h8wnqA+0WipxU
	 7MZGSTLbRJOngklQzJtbxlT75QZCHRsb0F5noGKfyepG2Q4lboDxmF4iRcav86q7Ew
	 La7uU70Us/joBZGwpNf6+1XjxGmbFpwo/Sa5m4pHvqpCA4gqZa4LZwDjs4lNY3mP3q
	 oFS6FOtk9EDGA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BXhhJ88eq_Fk; Sat, 23 Sep 2023 12:24:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8A0C60B6E;
	Sat, 23 Sep 2023 12:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8A0C60B6E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 53A801BF389
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Sep 2023 12:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28EBC60B6E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Sep 2023 12:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28EBC60B6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1yIqGy3ZQjRn for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 Sep 2023 12:24:43 +0000 (UTC)
X-Greylist: delayed 451 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 23 Sep 2023 12:24:43 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44AB160AA6
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr
 [80.12.242.24])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44AB160AA6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Sep 2023 12:24:42 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id k1ZLq0FE4ttXNk1ZLq9cSW; Sat, 23 Sep 2023 14:17:10 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 14:17:10 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Sat, 23 Sep 2023 14:17:05 +0200
Message-Id: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wanadoo.fr; s=t20230301; t=1695471430;
 bh=MZ+x3+dMxPzCGceJF8/93Shpse4vUvBYF6v0b3D2kfE=;
 h=From:To:Cc:Subject:Date;
 b=pWrkqoYWrs+z0eZtol7HHfGiyoEXhV/dOMobQxnDEhy6fd6vb/VVWl+xgiAj4FXnz
 4PvjXGd+S2o3TMbt4Ut7bO62rSgDkrpmxKcfbTt9ZBgTg+WQ1X+cRAIwr8ZPvxx+TL
 unF0hAolnIG5mmLcu0WkE4eqgFOYmtiwp+867RTzbgveloEchATdFmfzfB359NaQHC
 y2nJVmMr/0cV50aDKXwfsgFzViVX8Rul99nI4gR5DjZMggg/qrfGY34L7oFPnBMrvX
 SvRULTOQBPjgKYToaahMrfT2APagS9YohRwfVWOAZ9IrPna8uYXnvjEX6NrQaznMMa
 +RLYynY5dib/w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr
 header.a=rsa-sha256 header.s=t20230301 header.b=pWrkqoYW
Subject: [Intel-wired-lan] [PATCH net-next] iavf: Avoid a memory allocation
 in iavf_print_link_message()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

IAVF_MAX_SPEED_STRLEN is only 13 and 'speed' is allocated and freed within
iavf_print_link_message().

'speed' is only used with some snprintf() and netdev_info() calls.

So there is no real use to kzalloc()/free() it. Use the stack instead.
This saves a memory allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 8ce6389b5815..980dc69d7fbe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1389,18 +1389,14 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
 static void iavf_print_link_message(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	char speed[IAVF_MAX_SPEED_STRLEN];
 	int link_speed_mbps;
-	char *speed;
 
 	if (!adapter->link_up) {
 		netdev_info(netdev, "NIC Link is Down\n");
 		return;
 	}
 
-	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
-	if (!speed)
-		return;
-
 	if (ADV_LINK_SUPPORT(adapter)) {
 		link_speed_mbps = adapter->link_speed_mbps;
 		goto print_link_msg;
@@ -1452,7 +1448,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 	}
 
 	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
-	kfree(speed);
 }
 
 /**
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
