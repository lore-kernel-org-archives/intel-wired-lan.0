Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C0C38142
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Jan 2023 14:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE2DA4037E;
	Mon, 23 Jan 2023 14:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE2DA4037E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674482522;
	bh=gy9/x2aDCLD2xASBbDHQy3UDlxi0BkHFpQ8fhVAmA28=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=P8EvSRHcEvdwrGDuctFyViCb7Qsnzar7HEdCo/QocJW0xSdLU4+1R1Lu/29mrAb0e
	 hCV7p5F+H4ufJjQTV2wkMzRPoo20v5wHMo2wYGwQiBfRw6pJAMGWLoij2bRSxPuq9t
	 jBHk+1ZdnITlEoGanJl6X8q0ksZQ9qQ4KO+hD72SPjFH0cN6xXPkJiVwmZzhzafbBQ
	 QKwJl1PYbJAAzr2IzHmmsj2JBDwB3UR5fVRImF2iBWUyOCgPetKfvh5qGtvQgHmQYb
	 20L5spJwgP1hR/FkuwUdcJE2ITWdFJz8dmoi0Pa/OHL2HdawP4eim2v2wNB0iuM6xY
	 sJsBFWJcPprgQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqutZ1OsT4sz; Mon, 23 Jan 2023 14:02:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5EC94056B;
	Mon, 23 Jan 2023 14:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5EC94056B
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7FD951BF359
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 14:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BEBA4037E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 14:01:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BEBA4037E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id viyV3tTjEfXL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Jan 2023 14:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BE624035D
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BE624035D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 14:01:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DAA65B80D54;
 Mon, 23 Jan 2023 14:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941BAC433D2;
 Mon, 23 Jan 2023 14:01:53 +0000 (UTC)
From: Leon Romanovsky <leon@kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>
Date: Mon, 23 Jan 2023 16:00:22 +0200
Message-Id: <d563de401d6fdc1c52959300eebb2bbb27c6c181.1674481435.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674481435.git.leon@kernel.org>
References: <cover.1674481435.git.leon@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674482515;
 bh=U3drdqMwWME1pVMJtOM4jYmzrzE6E4B6J850ca4rGPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j34EjktX7VS3FL8RwDToON9LLmOw7qN3kmXm8AB7VSr2Rr6TYJweB5HqdEdOmzzDO
 x5HC8/sEi+BXj+yGk5L+Uty7pNeqQRiUslDopTKTC81nA3SLk9OgkuR2RbbFg6whBW
 VIZPLpr9jS7kFrWw2uxdLa25fCg6j/mp4KPyjcdffYzVM0e7noRA8BTUI75RvZGYs4
 WIO9d0qen4yn2uN4bJgJxBTOy55qFKFsDKR3ZW9kx9S/ZRgbS4ZQkSQoAvnY/o9ViY
 dyHonWuXs/ttVA7su+NhS1IgCjhj0Xv1L5/TzCKUKcHgds8AuMSjqv9J1DU1VJ/Cx7
 712xWr/Tu9cXg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=j34EjktX
Subject: [Intel-wired-lan] [PATCH net-next 09/10] bonding: fill IPsec state
 validation failure reason
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
Cc: Veaceslav Falico <vfalico@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Jay Vosburgh <j.vosburgh@gmail.com>, oss-drivers@corigine.com,
 linux-doc@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Ayush Sawal <ayush.sawal@chelsio.com>,
 Simon Horman <simon.horman@corigine.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Andy Gospodarek <andy@greyhouse.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Rely on extack to return failure reason.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 686b2a6fd674..00646aa315c3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -444,7 +444,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 	if (!slave->dev->xfrmdev_ops ||
 	    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(slave->dev)) {
-		slave_warn(bond_dev, slave->dev, "Slave does not support ipsec offload\n");
+		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
 		rcu_read_unlock();
 		return -EINVAL;
 	}
-- 
2.39.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
