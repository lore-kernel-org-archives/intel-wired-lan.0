Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE5AC64ED6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Mar 2023 12:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CFDB60F33;
	Wed,  1 Mar 2023 12:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CFDB60F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677672020;
	bh=5v5OVvuuIFFOwF+Ai+2PycPRiq6mq6zSheNekFgzuDc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=q7RAa9ltHP4wYUeMfGVnyaVrSXf9MAC3bE4hLrTlwLb7K/XY5qdLmg7DZKn08E97C
	 Boz5TA34pV4C55+gHFfspbgSbECYo36CHrteWGN4l3C4Duzs/nAS5/X3cqgfRkh+5P
	 3URVFMrUkNbWIBxKYJ/BRFa1yQLKctShr5zJq1i8eb6cCAeiLVMLrY63YRLbSlMm9p
	 lSpFDAScxkvcs2aOx9tODpBXgZ7xfZfLYnO/+gUdm5/7KsvBbzbzQ1Mu7AlipSLZlT
	 pZjtnqRMaNTYz1zbf+ox+sD1VMo0hTUMoh1gjFRkT11gOeV+RS5S7XdE2jTuha0YE/
	 jq4JUjZVTvN3w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKfrHM51UOeI; Wed,  1 Mar 2023 12:00:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D3E260FBC;
	Wed,  1 Mar 2023 12:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D3E260FBC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1AF6C1BF5B5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Mar 2023 12:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E86AC60B28
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Mar 2023 12:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E86AC60B28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xiDwUeMauuUC for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Mar 2023 12:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BAF60E96
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30BAF60E96
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Mar 2023 12:00:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="331870260"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; d="scan'208";a="331870260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2023 04:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="743405103"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; d="scan'208";a="743405103"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2023 04:00:10 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com
 [10.102.20.203])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id B296236A0D;
 Wed,  1 Mar 2023 12:00:09 +0000 (GMT)
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  1 Mar 2023 12:59:07 +0100
Message-Id: <20230301115908.47995-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301115908.47995-1-aleksander.lobakin@intel.com>
References: <20230301115908.47995-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677672014; x=1709208014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=exlFMpVF5vBUX97QGUIEERFQuxyaIwqV/MHoSJIWeoc=;
 b=TzLDd7hvMsjoyjvNSC/zngxparJWq9BPrgrP+S/CRL2t3zDYQ13YC1WR
 iKMJaPf6ApWCy8BcuCyRIqqfTRoB5yCNhqSFPJQlehKFkQCIjkX2nJpid
 ZrPS32HR0bbuvcAGaOA6DIAsegzS1oQtqWBE2EjrthJQI/22nj7PbhZDa
 wox/l9W09gjdXfFZid5vEJx+uQN4sx3JA2Z0RYfdGC+o3FVREeiTpq6A/
 29NZpFPt7si1Bm15GQA4Owq01+wyt0n3ZFX+TIKTQP8ZxWETZPCV2jJZk
 MWHSAu1v/W68wCIk4QJAdX0LQSknSSaKcLlqBuTKJn1j9GdJ+cnJKwSVy
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TzLDd7hv
Subject: [Intel-wired-lan] [PATCH RESEND net v1 1/2] iavf: fix inverted Rx
 hash condition leading to disabled hash
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
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Condition, which checks whether the netdev has hashing enabled is
inverted. Basically, the tagged commit effectively disabled passing flow
hash from descriptor to skb, unless user *disables* it via Ethtool.
Commit a876c3ba59a6 ("i40e/i40evf: properly report Rx packet hash")
fixed this problem, but only for i40e.
Invert the condition now in iavf and unblock passing hash to skbs again.

Fixes: 857942fd1aa1 ("i40e: Fix Rx hash reported to the stack by our driver")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 18b6a702a1d6..e989feda133c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1096,7 +1096,7 @@ static inline void iavf_rx_hash(struct iavf_ring *ring,
 		cpu_to_le64((u64)IAVF_RX_DESC_FLTSTAT_RSS_HASH <<
 			    IAVF_RX_DESC_STATUS_FLTSTAT_SHIFT);
 
-	if (ring->netdev->features & NETIF_F_RXHASH)
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
 		return;
 
 	if ((rx_desc->wb.qword1.status_error_len & rss_mask) == rss_mask) {
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
