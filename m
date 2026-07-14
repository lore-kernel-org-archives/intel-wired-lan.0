Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F50C44508
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Jul 2026 15:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5BC84070C;
	Tue, 14 Jul 2026 15:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1St-vTQVynPJ; Tue, 14 Jul 2026 15:35:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB64740569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784043325;
	bh=1rEnfawiH1rUI2ixdzp/X50M5aPlt9DKDjE68QCryO8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CY/N8palER+vJ7twnb83a4YTEYynskSTz6wUyJvP2Pn+nxVPjcCkIKUbiTnoxE1eL
	 KiBOU9XEedK1PIeaZxMLYGCAGhhIfANzRo5+hODPvAgfvB6TK4gNAADetVyRBlhv4U
	 RIrZqccMo0lSO/qFBLXWTvaFfmnnOP7/+X/NF6Gl5JSr52i7nNHXzQlFl8KchnBY5j
	 6YZqtDOxrrqZcBWyroUWoxOMHPHmMH+6cPBCE5tVbID5Qi/d4XrL98jXyzxlxJsVnz
	 703D7kjlRLzKJAx4uGRJwGMjVbNJTwLTSPfkLnvJxzep5VSdQHkSXYJToyxbDLyQ66
	 1rmUkuQT1By9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB64740569;
	Tue, 14 Jul 2026 15:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F6696C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 02:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 105BD407FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 02:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7iO3AT7YhbB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Jul 2026 02:56:50 +0000 (UTC)
X-Greylist: delayed 323 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 14 Jul 2026 02:56:48 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0C6C640812
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C6C640812
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com;
 envelope-from=chenguang.zhao@linux.dev; receiver=<UNKNOWN> 
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ae])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C6C640812
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 02:56:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 chenguang.zhao@linux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>
Date: Tue, 14 Jul 2026 10:51:12 +0800
Message-Id: <20260714025112.284724-1-chenguang.zhao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 14 Jul 2026 15:35:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1783997476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1rEnfawiH1rUI2ixdzp/X50M5aPlt9DKDjE68QCryO8=;
 b=QQz8sqWvGo25reDkdkR+CV3dThlr38KgDGv4EIeVdeRR+NcrRp0uQp2ijyp3lwrOHlmboF
 Er0wHUXKlhdYNutFT/9LwL7+7p1SLF0Vuc2QCOnN/Rgp9qFDIrNlxWIav18w1BUuBwdd2V
 ZRBrygMk6WTxmsXoUqYyWbacuVZEfHI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=QQz8sqWv
Subject: [Intel-wired-lan] [PATCH net] i40e: xsk: fix multi-buffer XDP_PASS
 skb construction
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

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When AF_XDP ZC receives a multi-buffer frame and the XDP program
returns XDP_PASS, i40e_construct_skb_zc() copies frags into a new
skb. The copy used skb_frag_page() as the memcpy source (page
metadata instead of packet data) and passed a virtual address to
__skb_fill_page_desc_noacc(), which expects a struct page *.

Use skb_frag_address() for the copy, attach frags with
skb_add_rx_frag() so len/data_len/truesize are updated, and on
dev_alloc_page() failure free the skb via the shared out path so
xsk_buff_free() still runs and previously attached pages are
released by kfree_skb.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 - Fix memcpy source: use skb_frag_address() instead of skb_frag_page(),
   which was copying page metadata rather than packet data.

 - Fix frag attachment: pass the allocated struct page * to the skb frag
   helper instead of the page virtual address.

 - Use skb_add_rx_frag() so skb->len, data_len and truesize are updated
   when attaching copied frags.

 - On mid-loop dev_alloc_page() failure, go through the shared out path
   so previously attached pages are released via kfree_skb and
   xsk_buff_free() is still called.

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..a4247710c85b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -318,22 +318,19 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 		goto out;
 
 	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
 		skb_frag_t *frag = &sinfo->frags[i];
+		unsigned int frag_size = skb_frag_size(frag);
 		struct page *page;
-		void *addr;
 
 		page = dev_alloc_page();
 		if (!page) {
 			dev_kfree_skb(skb);
-			return NULL;
+			skb = NULL;
+			goto out;
 		}
-		addr = page_to_virt(page);
 
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
+		memcpy(page_to_virt(page), skb_frag_address(frag), frag_size);
+		skb_add_rx_frag(skb, i, page, 0, frag_size, PAGE_SIZE);
 	}
 
 out:
-- 
2.25.1

