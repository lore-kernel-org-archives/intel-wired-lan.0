Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21874C44501
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 15:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E439B61025;
	Tue, 30 Jun 2026 15:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMWz4PCChgDj; Tue, 30 Jun 2026 15:19:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D74476104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782832751;
	bh=pbgNrbVcE6yo3qKfNUymapKPERWtTNs1YyhYIxOunlw=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=topgUDrjgCkpJj9AvIezlfAHmGTEGyIAdn9TDDlmboi8c1p4nOB5iggUvgfI9EA98
	 aWNyJeoWQSCXn1zED2zhrQSytDpHbxJ4CgOWG9SVFrCWkTSJ4qYKbkcEi1syRpnfYP
	 yc72MiD6cpM3lAoVyhGmijf0Upm4Nmq106NrYXfp3pbinRqSrBj2Z85FwPIH7erZCp
	 UnOdgFXj4f4mdHE9kqrOk3Qs5JArdpKlMTFZ6Ot7Ok707NXcxLsLWex0AevZiuOxSq
	 eEFLsPUCz/aHV5XtQi1cxKMbA7GMqZjuVq+5mquOHEv9A/11oWq7LY43FJGVDWCVE1
	 jKdWWJyn5xlSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D74476104F;
	Tue, 30 Jun 2026 15:19:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA2A1338
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9435B82496
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdGOe_yifp64 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 10:59:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AA8A4824A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA8A4824A4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA8A4824A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 10:59:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECF9343C7C;
 Tue, 30 Jun 2026 10:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506821F00A3A;
 Tue, 30 Jun 2026 10:59:43 +0000 (UTC)
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:59:23 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-drivers-net-v1-4-672162a91f37@kernel.org>
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
 d=kernel.org; s=k20260515; t=1782817187;
 bh=pbgNrbVcE6yo3qKfNUymapKPERWtTNs1YyhYIxOunlw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CQkkhZRBHHfobx6i8LR25033YOFT01rNrX0kyeipLKqLNF9BFgAy8s9JCwf2j/vq/
 eS+GIvwPdBaem60TRTg8gPtQBHnvDN3UJKx+Z1n+bWbwYhFLkHQ5Q9E6reXSf0OhSX
 7aJVtLVCY0Y8zaytM//DLEtFjwC4DZ9ubENo+sUUBFHRPy+4I3/hDOhp+osMXhQ8DE
 Jp8OQjwqHXfE/Sf+yV97a/f2u5a2t8IYcEmoigGTJjWa0f+8BWJQqTpMmf9ZEjeBYV
 UNKaFsEUBwWljJqmbIsS1Ki4cZFK+nk2EYxJGpveiDh6cF05HUrvteXBTqlHwXBVBJ
 auSHAeBkZXxNQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CQkkhZRB
Subject: [Intel-wired-lan] [PATCH net-next 4/8] libertas: debugfs: use
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

libertas debugfs functions allocate buffers for formatting debug
output text using get_zeroed_page().

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
 drivers/net/wireless/marvell/libertas/debugfs.c | 39 ++++++++++---------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c b/drivers/net/wireless/marvell/libertas/debugfs.c
index 9ebd69134940..9428f954837a 100644
--- a/drivers/net/wireless/marvell/libertas/debugfs.c
+++ b/drivers/net/wireless/marvell/libertas/debugfs.c
@@ -35,8 +35,7 @@ static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
 {
 	struct lbs_private *priv = file->private_data;
 	size_t pos = 0;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	ssize_t res;
 	if (!buf)
 		return -ENOMEM;
@@ -48,7 +47,7 @@ static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
 
 	res = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 
-	free_page(addr);
+	kfree(buf);
 	return res;
 }
 
@@ -96,8 +95,7 @@ static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
 	ssize_t ret;
 	size_t pos = 0;
 	struct sleep_params sp;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -113,7 +111,7 @@ static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
 	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 
 out_unlock:
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -165,8 +163,7 @@ static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
 	struct lbs_private *priv = file->private_data;
 	ssize_t ret;
 	size_t pos = 0;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -174,7 +171,7 @@ static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
 
 	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -228,7 +225,7 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
 	u8 freq;
 	int events = 0;
 
-	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -261,7 +258,7 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
 	kfree(subscribed);
 
  out_page:
-	free_page((unsigned long)buf);
+	kfree(buf);
 	return ret;
 }
 
@@ -436,8 +433,7 @@ static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
 	struct lbs_private *priv = file->private_data;
 	ssize_t pos = 0;
 	int ret;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	u32 val = 0;
 
 	if (!buf)
@@ -450,7 +446,7 @@ static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
 				priv->mac_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
-	free_page(addr);
+	kfree(buf);
 	return ret;
 }
 
@@ -506,8 +502,7 @@ static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
 	struct lbs_private *priv = file->private_data;
 	ssize_t pos = 0;
 	int ret;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	u32 val;
 
 	if (!buf)
@@ -520,7 +515,7 @@ static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
 				priv->bbp_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
-	free_page(addr);
+	kfree(buf);
 
 	return ret;
 }
@@ -578,8 +573,7 @@ static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
 	struct lbs_private *priv = file->private_data;
 	ssize_t pos = 0;
 	int ret;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	u32 val;
 
 	if (!buf)
@@ -592,7 +586,7 @@ static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
 				priv->rf_offset, val);
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
 	}
-	free_page(addr);
+	kfree(buf);
 
 	return ret;
 }
@@ -812,8 +806,7 @@ static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
 	char *p;
 	int i;
 	struct debug_data *d;
-	unsigned long addr = get_zeroed_page(GFP_KERNEL);
-	char *buf = (char *)addr;
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -836,7 +829,7 @@ static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
 
 	res = simple_read_from_buffer(userbuf, count, ppos, p, pos);
 
-	free_page(addr);
+	kfree(buf);
 	return res;
 }
 

-- 
2.53.0

