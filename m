Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32866C52D70
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Aug 2024 13:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A54F40A27;
	Tue,  6 Aug 2024 13:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xR_ElIljdsBA; Tue,  6 Aug 2024 13:13:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4FF840A10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722950010;
	bh=9G1FG/+oQ6kBZsYVABuGypyZUueZwf980OLrsfLkWu0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=L3bqpQEGePFhrt32G6wpBacDPI2v0Mkg+zoML4wcL8c/yWstGEQEa0uC/Htl50CuU
	 dQhE+BZMz+nL89VEXaWFKGhlmqojX76nsmjgX+ttQZ16+3YEI20mH9ekNigrtK/sDS
	 JznHlQVwDpoajIhlQd2FMIweFQOj+JbzykdOjNsXH0i43RPwhVjJ+JN7VJw/E7m+8/
	 rcClmHDyDrxfFUd/z7AX+af+ldtvBRfcHUMorNxA6WmUxPiID/jRV6I5CIhEEVgS93
	 soQ/JgKimMro2KG0faW6E7uQtaFfeLpjAnbo3LLzOHfmr+SaNNf+eDWJrUxEdDSShp
	 jCux82OGDXcWA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4FF840A10;
	Tue,  6 Aug 2024 13:13:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 65FDC1BF300
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Aug 2024 13:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 508AB403D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Aug 2024 13:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IW4PeM0SEHQY for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Aug 2024 13:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 34911403B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34911403B2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34911403B2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Aug 2024 13:13:23 +0000 (UTC)
X-CSE-ConnectionGUID: hC9EJVouTGKYD0FPR5F8EQ==
X-CSE-MsgGUID: Doq3SpbuShuu45pvrB8tAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20842119"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; d="scan'208";a="20842119"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 06:13:23 -0700
X-CSE-ConnectionGUID: xG9Oux22T3usMNGx8VYx3g==
X-CSE-MsgGUID: rwwRdc0URd6tARQb2RKy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; d="scan'208";a="56475812"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 06:13:20 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  6 Aug 2024 15:12:36 +0200
Message-ID: <20240806131240.800259-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131240.800259-1-aleksander.lobakin@intel.com>
References: <20240806131240.800259-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722950003; x=1754486003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ea6dfARgeRod6WyIOKsyRDBZrgbxzdAn+2JMu0mRaz8=;
 b=byjG6dwI8fv5JEWnIQwHo8mQ/cB/H8F+HSYPukqeZZawCZW+VsmeiAhk
 lv3HisGsYI8UpS2g3fAWxpAGFYRTS08Zne9hjwwrmOt9yGPu7vbugyDfn
 Q5ZJLA1on+MUBo4KtjAu2cByDZW0pwDDDCJ28z0ftMx4PjVdjInH/V6U5
 kYEm6uxHp/nEapmuHpGOPyiKB06JHbs4XPqWYGA4RgMcFtgcEcKg6LgUp
 t44oMyLLz/MIhWlwp8N7TiQMo1FjA1ChoQd/oy5E3VUouubYppXeUuoav
 uLff+FIn8Qw0ndg+vZkZc44Z1K/GzH+REZ0ebbFRJekMseb6DlEdJEVlk
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=byjG6dwI
Subject: [Intel-wired-lan] [PATCH iwl-next 5/9] netdevice: add
 netdev_tx_reset_subqueue() shorthand
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add a shorthand similar to other net*_subqueue() helpers for resetting
the queue by its index w/o obtaining &netdev_tx_queue beforehand
manually.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6e0b3ca5914..573226033d34 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3562,6 +3562,17 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 #endif
 }
 
+/**
+ * netdev_tx_reset_subqueue - reset the BQL stats and state of a netdev queue
+ * @dev: network device
+ * @qid: stack index of the queue to reset
+ */
+static inline void netdev_tx_reset_subqueue(const struct net_device *dev,
+					    u32 qid)
+{
+	netdev_tx_reset_queue(netdev_get_tx_queue(dev, qid));
+}
+
 /**
  * 	netdev_reset_queue - reset the packets and bytes count of a network device
  * 	@dev_queue: network device
@@ -3571,7 +3582,7 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
  */
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-	netdev_tx_reset_queue(netdev_get_tx_queue(dev_queue, 0));
+	netdev_tx_reset_subqueue(dev_queue, 0);
 }
 
 /**
-- 
2.45.2

