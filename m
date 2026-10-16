Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588D0CCA46C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 15:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0EBF60AA8;
	Fri, 16 Oct 2026 15:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XI6gB2fs6mi9; Fri, 16 Oct 2026 15:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31E4B60AF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792165065;
	b=XisdFD85IKyDCIHhgyPgVjrPw3TzamCQP6QpcDQsaNAac0RVD4T6fQ8rPlvD8YXCjH28
	 U2kbuGwxFt8Gkp9035JooKppD4m2CN94kstFRbWWpTyKWG8zf4d00EndWueYsPC9FD+WB
	 ji1MeM79pNckW65f3QgKv5Ul089yoPtOCt8rCNCqPv/eU6D5SZCa1R4sobXYZdepy44sy
	 bb3rk1kQMDLZjREzwJmGjN4LIAkjRxANlVqKhnZdM13PhmGhkymokyvzlAPKgrStsYTbJ
	 j6iFo27NfveIKz1JGx5DSYgZ0mTMF+VCT386lOgZq3uI4jdJXEtu65q8zmxh5rAX6sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792165065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
	b=Kj+Dy2ammKYKCLxAQMB0iKVppoHV9pv8D+yzqkic8WP1NnGmgxkVc/0BFS01KucspXzl
	 PzjlssrWSWItvgVXNzSZDzV+EYFpbVxw+D8HkL9Szlv8wnBiupkO7G8y+xuMyErt8fanE
	 m9jnCXrsCpTWuTEVRv7mMfoBBeq5y7kfsPYnesVDVypx+FeI5JdhqY2dqt/XgrIdwgccs
	 j0aopKOzWl0x1wKf/VXF/WvYm/VjklGPnAITu5lkWS7JvDS1Y/9z/NrJcr4BVEtN4vRtW
	 hFgKWArTXk2R0ImMaOQE3x5Nnnm4g8WcEBTZxgVcZvweHiJQZ3DUKIwkgEnBLk0CX3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792165065;
	bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5Vd07b+gmxFHBhG/MglYqfCbYDlRdeLMzev4AzkzPTqw6rDHrM4U2YOK0MfNkQf3O
	 6vUVaX8etDGCrk6PK/Pqh9UX/E9l7eTJh4T4LZpIO9AEYO16u2WaJb5WCM3E2Vi7fK
	 leFcyrw/EKlejMDcAqhsyJSwsRTcRTz2QlYcZYdyJk+ezyuyoVkt8rwx9eNWns3dJF
	 3OZqTha05K/veBbu7A4ijv/inddjTNc7XlkMgW1Aqj+blF9rEE5jNlOBxWtI4QxHgO
	 umT6wY80pv5e4xXLJ4t4ogni5zjvMFpAhfLv4E/z1hfYGVFR/ahjZ0QjyuiOHivft3
	 P5rtpq/nxTvtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31E4B60AF1;
	Fri, 16 Oct 2026 15:37:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B71C255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 15:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1BEA40C48
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 15:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRYUKS4jxWYA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 15:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD56B40C46
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792163920;
 b=P9fhmFg2GXShgf5mUoQ2zwakoqFny5rwN+XUTK2twtvvbvZ1B3E05hMlkgkKsnaeEq+d
 pHZGMK5HqxYkOq6SVORNmnxg9cW0q2UIC2TxCmwbkIppBWUPtG76ZL3xGRV6xionf9RHd
 AHw+z4G4jkZ16y3e+b9h89fxBGzBPSDvhhNKR23rEq/XE5g0UgG52V7Z2ysHAMo+/cvoO
 a7ZT3lMM9cy2v1erpggrY9p/Gnl5Lvkvwt3LJ4EMwnyBIw1+I6zf7k5rld70Phmp/LqDY
 KuXTxHeiEikQN81lyQ3TyxahTS5/qWeVvo9mgDPIXqgXc8f/356snXggfpxyCbvQoJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792163920;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
 Subject:From:To:Cc:Content-Type;
 bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
 b=ExsHAMK86M0364PpjHWkPtFgWT7bUEF8Wbm/7gsWwuDrJGAHPtN0RsWeLErDU1jyzdZ+
 UxmnSl9kW6I47aG9UqW1rbVbItXdGvXehHLdo/WyWR9k59IbIHq66dSVqLwHh0TUCrrBa
 LRyLvSC8jaFuwjPQ5kMeVFrbsSp/4TcA8h1O0pmGq+uRwfISio+zbP1XCM4yuqdwIZe3B
 drvP5p9hH9XPgSOkMULcEtVyHK9J0QoBGkq8rMCVmjxmx4p9c/fYIIMIcb4FJVqSo2ghM
 SQHY0+DKGlvUF08CQMG92ggPGVh4j8BukCLeQfxsxFF8Y6okR22ELWI25NoJSi3MAbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=MIrdiIbt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::648; helo=mail-ej1-x648.google.com;
 envelope-from=3tedsagykd3mcizqqfxffxcv.tfdzekvc-nzivu-creczjkj.fjlfjc.fix@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=MIrdiIbt
Received: from mail-ej1-x648.google.com (mail-ej1-x648.google.com
 [IPv6:2a00:1450:4864:20::648])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD56B40C46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 15:18:39 +0000 (UTC)
Received: by mail-ej1-x648.google.com with SMTP id
 a640c23a62f3a-c2942fa0995so1159466b.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792163917; x=1792768717; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
 b=MIrdiIbtagTPkDeS3+dRLz9T+vZBQ8LmaMm+C8I9ZntXvQp8BaO8BgfQ+PFk4X+RXS
 gQxAs3nuO5+qFFVArqiLzdoE9t0GdWRyLqQ+cFW0scApIXdSwWIzL1qu6q6EhDvK5vKc
 QTkizk1XRd+mqJ5M851ief3d0XDIQIWKskdUt2O656JUfw0hgbVArBLSB0z0RUZUMcma
 t/wA0K1keprgFrykJn3szkZbCBrWSQlGYtFHButc5hpt95ZFDlqjYd2RVWO+GsAbKy6i
 SeoF+JLOXCuPS+6FBlfY1qqrxkyhGqdcOu6lMZM4LgbBxFyjdASSmk/W8wXZFiH+1Von
 7/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163917; x=1792768717;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DdrT9/bm6JcU3yKappBYHRJ/j1CG7LkhSy2cx3C2M6k=;
 b=ORFkhgd45p//Jb2F8tmAYeLaFSq2IPP/lcPcmyf69nO5pUquJ8hZChTyBp24lSrRAl
 hqdo6eCtDQH9ICaQjExelXNGPvfISo22FdReuA4fJmSROC6HkbiTRPpo/7qon9L5pVil
 Jv7GMSWlDNaUFWFm8W7xbWsOdcBCFB6KFw+7s3ACyaQsKkpLvF1P//B5Gydfzs6bo57a
 zqEso945JEo+i6ucbVxfBFZyiBs5O5wagk8ZRmyIsCGcyNcyBxhq98nK3SzbrXobWOYW
 DNLtIQinGZQAnTW+DRBun8Y5BCaFhtQb/3jmS8DSDwGXy+HCiTqCj3xZ6gZHy4h8k4v0
 7fdQ==
X-Gm-Message-State: AFq9FYKf9x9flD0OH+J+dfZ5GrSnm9yqCo3riICmbB5KGvVfnCuQQS1u
 RjJQWMyK+66VkPeja39WrtZnVtwFMI9JqW6DoAisRjL+Or39CSGEeuZDXC/wcuKez3bdZs7Qf2E
 kpp5kYI5xL6cM+oLZPxSuochHKr6yKrasK37eQb+4M+uX9b9OViG7QvwB0+xrKQLqO7gaf3Nbpf
 8eahST3CT/jWCrDrOa0bL2JltU4kdk66IYhQ7aITG+ATXRQgokkg==
X-Received: from ejcb24.prod.google.com ([2002:a17:906:36d8:b0:c3f:7f5a:30f9])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9713:b0:c2e:856:2a08
 with SMTP id a640c23a62f3a-c419a942d66mr15910266b.1.1792163916834; Fri, 16
 Oct 2026 08:18:36 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:18:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016151835.2500807-1-lrizzo@google.com>
Subject: [PATCH iwl-next] libeth,
 idpf: use GFP_KERNEL for the initial Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 16 Oct 2026 15:37:44 +0000
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

libeth_rx_alloc() always allocates with GFP_ATOMIC, including when idpf
fills its Rx rings at open or on queue reconfiguration. That fill runs
in process context, right after page_pool_create() and before the
queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is needlessly
restrictive there: it can neither reclaim nor compact, while the initial
fill can allocate tens of thousands of buffers across all queues.

Add libeth_rx_alloc_gfp(), which takes the allocation flags, and make
libeth_rx_alloc() its GFP_ATOMIC wrapper. Use GFP_KERNEL for the initial
fill in idpf.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 23 +++++++++++++++----
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..d623e4ab8511f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -885,11 +885,12 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
+ * @gfp: GFP_KERNEL for the initial fill, GFP_ATOMIC from NAPI
  *
  * Returns false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
-				      u16 cleaned_count)
+				      u16 cleaned_count, gfp_t gfp)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
 	const struct libeth_fq_fp fq = {
@@ -908,7 +909,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 	do {
 		dma_addr_t addr;
 
-		addr = libeth_rx_alloc(&fq, nta);
+		addr = libeth_rx_alloc_gfp(&fq, nta, gfp);
 		if (addr == DMA_MAPPING_ERROR)
 			break;
 
@@ -1095,7 +1096,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count, GFP_ATOMIC);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
 	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb18..b1127ab48ef3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -600,6 +600,9 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
+ * Only used for the initial fill, from process context, so it allocates
+ * with GFP_KERNEL.
+ *
  * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
@@ -618,7 +621,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 		fq.fqes = bufq->hdr_buf;
 		fq.truesize = bufq->hdr_truesize;
 
-		addr = libeth_rx_alloc(&fq, buf_id);
+		addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 		if (addr == DMA_MAPPING_ERROR)
 			return false;
 
@@ -629,7 +632,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 	fq.fqes = bufq->buf;
 	fq.truesize = bufq->truesize;
 
-	addr = libeth_rx_alloc(&fq, buf_id);
+	addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
@@ -675,7 +678,7 @@ static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
  */
 static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 {
-	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1, GFP_KERNEL))
 		goto err;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2a..e27438c78ec79 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1123,7 +1123,7 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
-				      u16 cleaned_count);
+				      u16 cleaned_count, gfp_t gfp);
 bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 				const struct libeth_xdp_buff *xdp,
 				struct libeth_rq_napi_stats *rs);
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..14a528ea8a075 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -96,20 +96,23 @@ int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
- * libeth_rx_alloc - allocate a new Rx buffer
+ * libeth_rx_alloc_gfp - allocate a new Rx buffer
  * @fq: fill queue to allocate for
  * @i: index of the buffer within the queue
+ * @gfp: allocation flags: GFP_KERNEL where the caller may sleep (e.g. the
+ *	 initial fill of the ring), GFP_ATOMIC from NAPI
  *
  * Return: DMA address to be passed to HW for Rx on successful allocation,
  * ```DMA_MAPPING_ERROR``` otherwise.
  */
-static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+static inline dma_addr_t libeth_rx_alloc_gfp(const struct libeth_fq_fp *fq,
+					     u32 i, gfp_t gfp)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize, gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
@@ -117,6 +120,18 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 	       fq->pp->p.offset;
 }
 
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer from NAPI context
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: as libeth_rx_alloc_gfp().
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	return libeth_rx_alloc_gfp(fq, i, GFP_ATOMIC);
+}
+
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
-- 
2.56.0.176.g3575e65682-goog

