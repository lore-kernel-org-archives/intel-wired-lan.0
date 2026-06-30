Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6951BC44502
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 371EC61075;
	Tue, 30 Jun 2026 15:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heMuqvoLVJNo; Tue, 30 Jun 2026 15:19:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69E596107D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782832754;
	bh=nCZadshr+DzQYVkCBh6cy/RM40zwNi0ZS4nnwSr8GpY=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTCjTxR0sQMFU19EpbsHAQKkqn8s0FTFTAedg9yMiuaozn8B4LZbByNSMWsyz3UJw
	 6g3WH0uwJsK9UPhna+Rct0qV8caA5FlbP5BcS0zTXOrkMO9y6cp6IVTU4WbezR8Ohd
	 ZhWiiyP8LsUF1/WaQC5r/sDU8c0bQYv91ty0Vsus3luj/BfpCyW5AWBEbo9bB7ztSW
	 z8P5hqtdKWC8utZqCnUjXy/RL/8dNzL36o1Qlath85ToQsOpTutaFaUxHHebHzyeUT
	 srQic44YCp0vPw2bjaUne0wBpLoF9khIZ0Qbq79DcSkTS3L7Yvyrhnj2dWcEUWrw0q
	 3w/8UVhv5pC/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69E596107D;
	Tue, 30 Jun 2026 15:19:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 688D3ED6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 11:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EFEF60FC0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 11:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bERsJuGJEvpe for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 11:00:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 545F860B4A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 545F860B4A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 545F860B4A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 11:00:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F12B40E06;
 Tue, 30 Jun 2026 11:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736051F00A3D;
 Tue, 30 Jun 2026 11:00:03 +0000 (UTC)
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:59:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-drivers-net-v1-8-672162a91f37@kernel.org>
References: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
In-Reply-To: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, 
 Edward Cree <ecree.xilinx@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Manish Chopra <manishc@marvell.com>, Mike Rapoport <rppt@kernel.org>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, b43-dev@lists.infradead.org, 
 intel-wired-lan@lists.osuosl.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-net-drivers@amd.com, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:19:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782817208;
 bh=nCZadshr+DzQYVkCBh6cy/RM40zwNi0ZS4nnwSr8GpY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BHxEq6ExepayPqMVcba1gAOZBamGomKzGI5/5rbn4FkcDA6n30f9+6e3ho9P8OwWU
 6+ENTujmQC9oE2fr15f3DfD685ltql5+ulTzniflHu/5xHjg8Eppf3qb9Hh+2qgUDA
 ME464175cHxtguWUsZhBztIo+dKhzs8PG5IC/96hm29yd4Z0iwNPkTO33p6idcdDp/
 FjithW/WlildOFWxaLjCMKyGZXhKmpBpkXf96s/l1exvCtkqBxQaNyn0n5UfWOeBNn
 SVmcV8YVyeBAmrNTxPQHtglqbphZVG5c+ST+4B2ZpMQqg9IQ18aRQQ7t+8J2hG1Npu
 aIQxG92cvPCBw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BHxEq6Ex
Subject: [Intel-wired-lan] [PATCH net-next 8/8] wlcore: allocate aggregation
 and firmware log buffers with kzalloc()
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

wlcore_alloc_hw() uses __get_free_pages() to  allocate TX aggregation
and firmware log buffers used for software data staging.

These buffer can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_pages() with kzalloc() and free_pages() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index be583ae331c0..5595f7a1fc0c 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6354,7 +6354,6 @@ struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 	struct ieee80211_hw *hw;
 	struct wl1271 *wl;
 	int i, j, ret;
-	unsigned int order;
 
 	hw = ieee80211_alloc_hw(sizeof(*wl), &wl1271_ops);
 	if (!hw) {
@@ -6434,8 +6433,7 @@ struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 	mutex_init(&wl->flush_mutex);
 	init_completion(&wl->nvs_loading_complete);
 
-	order = get_order(aggr_buf_size);
-	wl->aggr_buf = (u8 *)__get_free_pages(GFP_KERNEL, order);
+	wl->aggr_buf = kmalloc(round_up(aggr_buf_size, PAGE_SIZE), GFP_KERNEL);
 	if (!wl->aggr_buf) {
 		ret = -ENOMEM;
 		goto err_wq;
@@ -6449,7 +6447,7 @@ struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 	}
 
 	/* Allocate one page for the FW log */
-	wl->fwlog = (u8 *)get_zeroed_page(GFP_KERNEL);
+	wl->fwlog = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!wl->fwlog) {
 		ret = -ENOMEM;
 		goto err_dummy_packet;
@@ -6474,13 +6472,13 @@ struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 	kfree(wl->mbox);
 
 err_fwlog:
-	free_page((unsigned long)wl->fwlog);
+	kfree(wl->fwlog);
 
 err_dummy_packet:
 	dev_kfree_skb(wl->dummy_packet);
 
 err_aggr:
-	free_pages((unsigned long)wl->aggr_buf, order);
+	kfree(wl->aggr_buf);
 
 err_wq:
 	destroy_workqueue(wl->freezable_wq);
@@ -6509,9 +6507,9 @@ int wlcore_free_hw(struct wl1271 *wl)
 
 	kfree(wl->buffer_32);
 	kfree(wl->mbox);
-	free_page((unsigned long)wl->fwlog);
+	kfree(wl->fwlog);
 	dev_kfree_skb(wl->dummy_packet);
-	free_pages((unsigned long)wl->aggr_buf, get_order(wl->aggr_buf_size));
+	kfree(wl->aggr_buf);
 
 	wl1271_debugfs_exit(wl);
 

-- 
2.53.0

