Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09A6C43458
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 15:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E27B6106A;
	Tue, 30 Jun 2026 15:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WwIQGFeostiL; Tue, 30 Jun 2026 15:19:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83F166106C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782832752;
	bh=mIRRvN16ToAQb1e9zetNytMS/So59mpcGLgkkM3oXG4=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=paGMCgP3prHrWg2D9UAb/atPZMSpbm4/gqkGSrFIoTTvroD+3fa8fNKepWN475UOJ
	 6ACw/o1L1aOEGIKUZxF1lb3+YrxNmmWfz6WTE0Hw7Afhk5AedXetK3szlgkx1Do76/
	 vKf4hPDHlcpv5LGqihBIhOMY+gX1Or7A41SidEB5oxkQoxWKmMx+hReFFn6V0ZNp+5
	 483N+J7/1WVkPvt9KFVOQi4SC1K7qJRTyrF6pCTne+7U6vv7yuslQjMRdEpEJwu/BR
	 7MuIHywaOYWEduRs8LQZDL20uXYuevfwj5UX1kH4O/hWgg9hAckOwzGQMXewJGSkUh
	 KVtwD1ZVhPUQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83F166106C;
	Tue, 30 Jun 2026 15:19:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 488B1ED6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46A20824C1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yh8K-fTDqTxL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 10:59:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5644C82496
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5644C82496
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5644C82496
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 024B041711;
 Tue, 30 Jun 2026 10:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BF31F000E9;
 Tue, 30 Jun 2026 10:59:48 +0000 (UTC)
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:59:24 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-drivers-net-v1-5-672162a91f37@kernel.org>
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
 d=kernel.org; s=k20260515; t=1782817192;
 bh=mIRRvN16ToAQb1e9zetNytMS/So59mpcGLgkkM3oXG4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hnXL8u7DMOm61ET2YFbf/5HG/UOM//MlyIUC1ghjFLWaMFK141AlmTM8FUJgs3RAn
 RX1cWUUYGaqEsVtUipC1zlFqCjMTLg3N2LPmKOGTSgsaGmsFPT+Ms8Vlw+IEhsK8Nj
 3MTBHNq+YJKJW9KJMD2Y+hb13ctB6uNi6q59EqSVoBp6J69Q9zlpe3ota+j8R5N6gq
 ayMXVIE+LyBCz80hv5zKhkjroxVtZ+1iMlZhIDQEhp7t/fmsh/MArdtmfrHvN29KrU
 LCfNiNAbWeNajuZRrNkEnu35SQ2y+pjxqnAqO8Pp9rb+Lq2NbBlVcpamK8CZv0r+EW
 YwTjWPvrvQzJw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hnXL8u7D
Subject: [Intel-wired-lan] [PATCH net-next 5/8] mwifiex: debugfs: use
 kzalloc() to allocate formatting buffers
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

mwifiex debugfs functions allocate buffers for formatting debug output
text using get_zeroed_page().

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 62 +++++++++++---------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb62..573768b6ad91 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/slab.h>
 
 #include "main.h"
 #include "11n.h"
@@ -67,8 +68,8 @@ mwifiex_info_read(struct file *file, char __user *ubuf,
 	struct net_device *netdev = priv->netdev;
 	struct netdev_hw_addr *ha;
 	struct netdev_queue *txq;
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
-	char *p = (char *) page, fmt[64];
+	char *page = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	char *p = page, fmt[64];
 	struct mwifiex_bss_info info;
 	ssize_t ret;
 	int i = 0;
@@ -133,11 +134,10 @@ mwifiex_info_read(struct file *file, char __user *ubuf,
 	}
 	p += sprintf(p, "\n");
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_read_from_buffer(ubuf, count, ppos, page, p - page);
 
 free_and_exit:
-	free_page(page);
+	kfree(page);
 	return ret;
 }
 
@@ -168,8 +168,8 @@ mwifiex_getlog_read(struct file *file, char __user *ubuf,
 {
 	struct mwifiex_private *priv =
 		(struct mwifiex_private *) file->private_data;
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
-	char *p = (char *) page;
+	char *page = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	char *p = page;
 	ssize_t ret;
 	struct mwifiex_ds_get_stats stats;
 
@@ -220,11 +220,10 @@ mwifiex_getlog_read(struct file *file, char __user *ubuf,
 		     stats.bcn_miss_cnt);
 
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_read_from_buffer(ubuf, count, ppos, page, p - page);
 
 free_and_exit:
-	free_page(page);
+	kfree(page);
 	return ret;
 }
 
@@ -247,8 +246,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	ssize_t ret;
 	struct mwifiex_histogram_data *phist_data;
 	int i, value;
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
-	char *p = (char *)page;
+	char *page = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	char *p = page;
 
 	if (!p)
 		return -ENOMEM;
@@ -309,11 +308,10 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 				i, value);
 	}
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
-				      (unsigned long)p - page);
+	ret = simple_read_from_buffer(ubuf, count, ppos, page, p - page);
 
 free_and_exit:
-	free_page(page);
+	kfree(page);
 	return ret;
 }
 
@@ -383,8 +381,8 @@ mwifiex_debug_read(struct file *file, char __user *ubuf,
 {
 	struct mwifiex_private *priv =
 		(struct mwifiex_private *) file->private_data;
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
-	char *p = (char *) page;
+	char *page = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	char *p = page;
 	ssize_t ret;
 
 	if (!p)
@@ -396,11 +394,10 @@ mwifiex_debug_read(struct file *file, char __user *ubuf,
 
 	p += mwifiex_debug_info_to_buffer(priv, p, &info);
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_read_from_buffer(ubuf, count, ppos, page, p - page);
 
 free_and_exit:
-	free_page(page);
+	kfree(page);
 	return ret;
 }
 
@@ -457,8 +454,7 @@ mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
 {
 	struct mwifiex_private *priv =
 		(struct mwifiex_private *) file->private_data;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *) addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	int pos = 0, ret = 0;
 	u32 reg_value;
 
@@ -497,7 +493,7 @@ mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
 
 done:
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -511,8 +507,7 @@ mwifiex_debug_mask_read(struct file *file, char __user *ubuf,
 {
 	struct mwifiex_private *priv =
 		(struct mwifiex_private *)file->private_data;
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)page;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	size_t ret = 0;
 	int pos = 0;
 
@@ -523,7 +518,7 @@ mwifiex_debug_mask_read(struct file *file, char __user *ubuf,
 			priv->adapter->debug_mask);
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
 
-	free_page(page);
+	kfree(buf);
 	return ret;
 }
 
@@ -652,8 +647,7 @@ mwifiex_memrw_read(struct file *file, char __user *ubuf,
 		   size_t count, loff_t *ppos)
 {
 	struct mwifiex_private *priv = (void *)file->private_data;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	int ret, pos = 0;
 
 	if (!buf)
@@ -663,7 +657,7 @@ mwifiex_memrw_read(struct file *file, char __user *ubuf,
 			priv->mem_rw.value);
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
 
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -719,8 +713,7 @@ mwifiex_rdeeprom_read(struct file *file, char __user *ubuf,
 {
 	struct mwifiex_private *priv =
 		(struct mwifiex_private *) file->private_data;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *) addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	int pos, ret, i;
 	u8 value[MAX_EEPROM_DATA];
 
@@ -749,7 +742,7 @@ mwifiex_rdeeprom_read(struct file *file, char __user *ubuf,
 done:
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
 out_free:
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -820,8 +813,7 @@ mwifiex_hscfg_read(struct file *file, char __user *ubuf,
 		   size_t count, loff_t *ppos)
 {
 	struct mwifiex_private *priv = (void *)file->private_data;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	int pos, ret;
 	struct mwifiex_ds_hs_cfg hscfg;
 
@@ -836,7 +828,7 @@ mwifiex_hscfg_read(struct file *file, char __user *ubuf,
 
 	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
 
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 

-- 
2.53.0

