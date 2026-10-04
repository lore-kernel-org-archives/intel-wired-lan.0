Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B58CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E621606DA;
	Mon,  5 Oct 2026 15:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ybSGbJGMRGU; Mon,  5 Oct 2026 15:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4D60260703
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214002;
	b=TEWTpf/h4zBX9eN6POnjUXG6Me8AWuFzEKXXaW+0cM8HkaVHQNR7iEAyyX3Xaj5pgLSm
	 dcOQYsHqZxFDSRJLoeZKe4b7fP4BNgNp56Ydj3xnvg9XJLTHPXr7FtXllTLWHSPBchAB5
	 149OnAGDsG6PNZd4NLKYMrHhT+O4EVgtNWMa+OAVbdzwdcxPVI6b5x5K9FTIzOpKh+oC+
	 4MJyWZjEYwEPPQlbUS1YmO3qm4RzSWgLngOKNegz1craYW38EBi5YQwEguzMq6whP+rk6
	 KBYnA60gQB0Q2f00WE3EuKiK4Mv513YXzRROCTxE3+JY/LZlbd117e6ljWfPEfiQjQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791214002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DWJjGzhQwAiHQo9PbtWaIldKOahhqRvJI5AJa/zE5cM=;
	b=VDy5rJ3DuT4CF0dwoUiIg5/oHgCcfdTwGD1U21EA9aHciqHkaRrz7kJ1RNZ18iczRNuZ
	 dvEReUMHurxTbvJ2R3nT+Px1cZS0GsE8cJ8w5Jo2BI9EVrO1rn8/IOhYnVHLCjG5/n5XE
	 emqRWuw6QyTV6Emjuxy5HAUTt0k0HT6yBiKMYZ1PH8/xB5Sil9bc1ZwoCLCpEoBxLVigK
	 l0mdvFk37VUqPuSEYRsqKUZtGDbGjFE69BVg19hadbELDD/exXZ8D8Ev5WqwKWXZlcS6J
	 t1hpromjzZdUVDrHkLCRpAkO4iYtsVlaxrOUXckCdeYb58eE9bXCHIjjc/4szOwGKEg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=proxmox.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791214002;
	bh=DWJjGzhQwAiHQo9PbtWaIldKOahhqRvJI5AJa/zE5cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1y4IuGLtYdXENmkLrwxgx7kkKaX0ejKNPgrmeEh8V1lUfKnhZ4W0pOQa3hRV0W4i
	 zVZ7ctrKt6eskqUVg7BwAGufHBOlxsWTQzNBTwspXj8H5uXWphzcuxxGhFkDNOjjro
	 5Vgzxlo0rIQao7CYdlE9gCktP90A3KcxyvX3bFlJpFjzzI6DW2wn1cvpnvHOFOgj6q
	 U6gN+NFgM45vMvSgIJ+A7FY1HL9klTqD54Ra+ndnp37BTGPiMYg2fL3ZlE/zQ1aInd
	 ewP7lUD9Ay9GaSzx2+MvN5Ibdl9KVzk/XhOj+q8O3PaXIvhtpviTp104NP2AH8JwQ8
	 tS2ZEXAdGiEyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D60260703;
	Mon,  5 Oct 2026 15:26:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D773A435
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C89BE60614
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w32dJMMnV2YJ for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Oct 2026 19:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9A20E60705
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143458;
 b=L88aAqc94/DJCyoCAi2ZPL9noUGLA0oh0iHD/G/CHR17+P5Xmy/Bq+2a7Rj1B1l7U+Yv
 kuLlTBkmi4L2wYPYN7lTYqHMTYznjIjkcsWe8GFDMkgICdvGsymomYOV1R4bagjrxLtzF
 7GeGFWjmax3IytyVRDHP8N8e35jvJEVu/RGJOgjFlCa+F9C+osWVchOtbrkX0dHPMT2aH
 8ii4G5FusIbZpID2K7MQh/Mrs7aiDkE6O8nuAwSCCbu+cWZ9KaH5i2knw9ynPY5OytgL6
 /W5SMDSpptK2iMnC+9PVyExmAWX4etYSVyqE9ONaF8xdMyFuIDf0k4GXpUOh3Sxl8nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143458;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Bm-Milter-Handled:
 X-Bm-Transport-Timestamp;
 bh=DWJjGzhQwAiHQo9PbtWaIldKOahhqRvJI5AJa/zE5cM=;
 b=TK48YsVu42bRL1sh1caMdV632JSa21/GhQvuXxtJiLJO/ETZlID/TGSJ2Sox93e8brz7
 jdFGeuwPMzjDMRmVgN/vLydlvZNCgdytbUcTZtw1PRGbgJl/2blIOjj+bjQixlrrF89tO
 cawGvhAydqj9FhAgUm/vNjRuvSOEYi5o6VzCo32c5BxToJndiCbyqaNhLizGs70b5nlJI
 l726ZVkHNPx0mjepykl524N+naXfELS5OE16PQK6so+UowYZ+rD32p+Vh9DqLGay7/n1v
 2JLkMCk1zXHdke+khV1GafFpy4CtctIry9JSenWoJrB9Oy860jY1JfYhfDmH6Jzl7pQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=proxmox.com; 
 arc=none smtp.remote-ip=94.136.29.106
X-Greylist: delayed 412 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 04 Oct 2026 19:50:57 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=proxmox.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=94.136.29.106;
 helo=proxmox-new.maurer-it.com; envelope-from=t.lamprecht@proxmox.com;
 receiver=<UNKNOWN> 
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com
 [94.136.29.106])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A20E60705
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Oct 2026 19:50:56 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 913FE47979;
 Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Don Skidmore <donald.c.skidmore@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Viacheslav Tyryshkin <s@tyryshkin.me>,
 Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 2/2] ixgbe: do not enable MDD without VFs
Date: Sun,  4 Oct 2026 21:37:00 +0200
Message-ID: <20261004193704.2895700-3-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040630
X-Mailman-Approved-At: Mon, 05 Oct 2026 15:25:30 +0000
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

MDD is meant to be enabled only while VFs exist, see commit
d5e3152037f3 ("ixgbe: add MDD support"), and ixgbe_watchdog_link_is_up()
accordingly only enables it if there are VFs. But ixgbe_set_rx_drop_en(),
which disables MDD while rewriting SRRCTL, re-enables it
unconditionally. It runs on link up unless DCB with PFC is enabled, and
on DCB PFC changes, so MDD ends up enabled on X550 and E610 adapters
without VFs, where it can block PF queues and raise events for VFs that
do not exist.

Only re-enable MDD if there are VFs.

Fixes: 1a3ebc59f717 ("ixgbe: turn off MDD while modifying SRRCTL")
Reported-by: Melissa Romanus <melissa.romanus@proton.me>
Closes: https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d..e35265f96ac08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4132,7 +4132,7 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
 
-	if (hw->mac.ops.enable_mdd)
+	if (adapter->num_vfs && hw->mac.ops.enable_mdd)
 		hw->mac.ops.enable_mdd(hw);
 }
 
-- 
2.47.3


