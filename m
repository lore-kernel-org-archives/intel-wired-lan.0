Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF98C433FE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Sep 2022 22:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49BB460D89;
	Fri, 30 Sep 2022 22:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49BB460D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664577166;
	bh=zYwga3h11vlnNL+QrWbLKqJaVdz0MCMiqW9yooD7deM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=yLhFXTUkaJAGt0atUZYH6gCegFNoGGjLIAi2rB5Ki+yRSqxNVPNLZMw3aNPwQURwo
	 Jbw6j56opIRdRGGvJNBpZ9f/PuiQjPSmEL5hEC7/KF2eC8ZkCHyhUfafOYun7pxXdt
	 CHFYI93OtbuoXRxzEmdrQgUQHzNH8vV22UhSQ0YQW+HETPkJdVd9/IlWUe80+VgHSF
	 VOCDHDVSAfOhg5ZqEn4LSCehBdxLlCaZEi+MVQfrhX/tqlgnRkbp0dGWMw9m+KRUVd
	 AA10ZTf/gha7LdHtzdo3htwPje8yUon/+M9Y6aCt0vgN4NVcBq8XHkdA5GxajmPHZk
	 hrUeNbFRpEUSQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDk1TYTmXaZL; Fri, 30 Sep 2022 22:32:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EA6460D91;
	Fri, 30 Sep 2022 22:32:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EA6460D91
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CDA5C1BF4E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Sep 2022 22:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A839040B78
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Sep 2022 22:32:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A839040B78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVRvbwH7rX4O for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Sep 2022 22:32:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8133D4052F
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8133D4052F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Sep 2022 22:32:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282672772"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; d="scan'208";a="282672772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2022 15:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="618134137"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; d="scan'208";a="618134137"
Received: from avenkata-desk0.sc.intel.com ([172.25.112.42])
 by orsmga007.jf.intel.com with ESMTP; 30 Sep 2022 15:32:40 -0700
From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 30 Sep 2022 15:33:24 -0700
Message-Id: <20220930223324.1008555-1-anirudh.venkataramanan@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664577162; x=1696113162;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1p7qLFh7XHJkhrkTF2KAd2O/ABA7vYXK+QKJMHkg+NQ=;
 b=DSXVhoLGYVZuJOYqRxInR1//JSLYSFhsyGyPLTcebkSBnALK6y7k0eUg
 fzn2rhPXHMtFGkPufaFhk/Qt3OWhA4k2/mSIqi0rZCbJQvZQvsNj9qPC6
 YOUX7euUvgumITCFbFJHvwGFgXWYd9bavG+t+PerW3wrW8ecWrCFY2RgZ
 CWjGFy5zRIeANYqTyUJYNWBkGcGtNhaMqsP7ux5KwWbQLJNpeXp0oeGdl
 6BJVlk/ZE6Sd7+zpMRgPBrhxc3aQHr+Bttr/GQ4Gl3e4kq6roNKnzvOj3
 uHGzYs+NBQw+6/7mfC4r8EoRjt+LSxhUtddoflOdyCXPi4nGHZuLuPWMZ
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DSXVhoLG
Subject: [Intel-wired-lan] [PATCH v2 net-next] e1000e: Remove unnecessary
 use of kmap_atomic()
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
Cc: "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
 Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

alloc_rx_buf() allocates ps_page->page and buffer_info->page using either
GFP_ATOMIC or GFP_KERNEL. Memory allocated with GFP_KERNEL/GFP_ATOMIC can't
come from highmem and so there's no need to kmap() them. Just use
page_address().

I don't have access to a 32-bit system so did some limited testing on qemu
(qemu-system-i386 -m 4096 -smp 4 -device e1000e) with a 32-bit Debian 11.04
image.

v1->v2:
- update comment to remove a reference to kmap

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 49e9269..5fb7891 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1388,26 +1388,18 @@ static bool e1000_clean_rx_irq_ps(struct e1000_ring *rx_ring, int *work_done,
 
 			/* page alloc/put takes too long and effects small
 			 * packet throughput, so unsplit small packets and
-			 * save the alloc/put only valid in softirq (napi)
-			 * context to call kmap_*
+			 * save the alloc/put
 			 */
 			if (l1 && (l1 <= copybreak) &&
 			    ((length + l1) <= adapter->rx_ps_bsize0)) {
-				u8 *vaddr;
-
 				ps_page = &buffer_info->ps_pages[0];
 
-				/* there is no documentation about how to call
-				 * kmap_atomic, so we can't hold the mapping
-				 * very long
-				 */
 				dma_sync_single_for_cpu(&pdev->dev,
 							ps_page->dma,
 							PAGE_SIZE,
 							DMA_FROM_DEVICE);
-				vaddr = kmap_atomic(ps_page->page);
-				memcpy(skb_tail_pointer(skb), vaddr, l1);
-				kunmap_atomic(vaddr);
+				memcpy(skb_tail_pointer(skb),
+				       page_address(ps_page->page), l1);
 				dma_sync_single_for_device(&pdev->dev,
 							   ps_page->dma,
 							   PAGE_SIZE,
@@ -1607,11 +1599,9 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 				 */
 				if (length <= copybreak &&
 				    skb_tailroom(skb) >= length) {
-					u8 *vaddr;
-					vaddr = kmap_atomic(buffer_info->page);
-					memcpy(skb_tail_pointer(skb), vaddr,
+					memcpy(skb_tail_pointer(skb),
+					       page_address(buffer_info->page),
 					       length);
-					kunmap_atomic(vaddr);
 					/* re-use the page, so don't erase
 					 * buffer_info->page
 					 */
-- 
2.37.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
