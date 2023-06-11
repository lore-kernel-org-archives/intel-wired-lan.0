Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D55C7EE23
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Jun 2023 20:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5FB982053;
	Sun, 11 Jun 2023 20:44:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5FB982053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686516264;
	bh=dI3y69ASczBihaXWSTE1najCsjiR0/5ATOSyp6NMgLI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=EghN7EXrI6DltxDS9ppfqX3K/82ENOz81gdRqpB07LGUQpja36YWCBg+9VuQgFKQE
	 vZ2ogUFScTQnQVu5/5Wngek1WeNDxZXcm9C/rXeq2Zn273mT/baZHYRptSgPHJgbN1
	 g6E6jyFn6XUQwag5WaxH6WIkqsGt6UTgSL7oiOUwpYLaXfvPPL9nW+jwtN9+eGd0Ql
	 bVTiFbOJRZCi2dtjWhu7sELJqd93kHD/2N0EuvnsOykDqeUgB7X/6jm5lkkKSfGFAJ
	 pVn4ODf9D8287tnbL7F0z8DYUww/GuU898kN9zYKzNI3dcfEONSd3+Viqxp/nlngCN
	 9fbqgRqq10Hxw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycZV7CJxMRAV; Sun, 11 Jun 2023 20:44:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD598205E;
	Sun, 11 Jun 2023 20:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FD598205E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 0FAA71BF271
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Jun 2023 20:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E387D60E82
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Jun 2023 20:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E387D60E82
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Isbj3ZI2W7QT for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Jun 2023 20:44:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51F2C60B1E
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr
 [80.12.242.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51F2C60B1E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Jun 2023 20:44:20 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id 8Rv5qwjzfZnIG8Rv5qdCzN; Sun, 11 Jun 2023 22:44:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Jun 2023 22:44:17 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Sun, 11 Jun 2023 22:44:13 +0200
Message-Id: <e86a1ab7b450462a1e92264dccb5a5855546e384.1686516193.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wanadoo.fr; s=t20230301; t=1686516257;
 bh=UiEF+Yax2f7tK9mHB7IIdxWz2jAlp2s9xTkNsdxvvkw=;
 h=From:To:Cc:Subject:Date;
 b=OUYbcJz4qYNl/rvRcj8m+xkYnIYgYw5GQYzEjeohGePg5f/NCQ8hwaP+KA2NayJR9
 9wo1V+vywBUF/RBzAz2/5PuBFXnj/0Pumv0YzR/p0GHPoa8tBx76xKE/EEB4WV7TIy
 RyeSIE2ybOJ2nDKb/sSutIi5Gk+NTRKPv+sOcgvJOe89LUM8dsLItS05cgRvcGguI8
 XtgUsQBFlGN/AqyLmN7CtnL3gCdjewsqhU16bNZpQhctYekQU1iorp9X7RZD038Z8n
 /DGcOik+Xj5t5duaZZ3W3HuTPTCqjC+UPykoE5W1Reir3MyjLEIhDLR2sEM8iMMTgB
 S7YmbF3ZWGfQg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr
 header.a=rsa-sha256 header.s=t20230301 header.b=OUYbcJz4
Subject: [Intel-wired-lan] [PATCH net-next] ice: Remove managed memory usage
 in ice_get_fw_log_cfg()
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

There is no need to use managed memory allocation here. The memory is
released at the end of the function.

You kzalloc()/kfree() to simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index eb2dc0983776..4b799a5d378a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -834,7 +834,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 	u16 size;
 
 	size = sizeof(*config) * ICE_AQC_FW_LOG_ID_MAX;
-	config = devm_kzalloc(ice_hw_to_dev(hw), size, GFP_KERNEL);
+	config = kzalloc(size, GFP_KERNEL);
 	if (!config)
 		return -ENOMEM;
 
@@ -857,7 +857,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 		}
 	}
 
-	devm_kfree(ice_hw_to_dev(hw), config);
+	kfree(config);
 
 	return status;
 }
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
