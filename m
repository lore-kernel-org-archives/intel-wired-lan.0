Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783D2C10DC3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Dec 2023 17:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32BA983C29;
	Thu,  7 Dec 2023 17:22:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32BA983C29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701969739;
	bh=KgfUTENk/XqhMgc2eRun5EfQhwEz70TqRuDd9cBywco=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=M5fDJtrHKpyqDBckRC30qTxaTTHU9ha9gI0zz9CxN5SJC0QBn8tFvxdgiXyewXkAh
	 yFQ1CrG48U+1Y6WYhpHGO4ZD13MAnIsq6wiAgTOJrUZ4wLk/oR6yEzQuHjDIkkDvkb
	 tnBeJGiTGaOtHVSqjDz8D4DyIRRXPgpXnRMYQ25p2Fzw0Shjma6AQkXJvA0u+2w+H5
	 xhqPtHrS6Gg0KeO/fCImXnoBOcOWNKicuDjkN5xhpHReI3FtB5JMLm3lKjmJIMRpqQ
	 la2N49BRM2fMOqyUB9FpAKxH88T7RcJq0GRt+PgctpmgwJfMeyo9UOXH2uoDWWozZK
	 L7qO1St4mudVQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkC7_xBlJHiJ; Thu,  7 Dec 2023 17:22:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2589A83CE6;
	Thu,  7 Dec 2023 17:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2589A83CE6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id E20E11BF380
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 17:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A32B660BF3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 17:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A32B660BF3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5f5Uyd_sU6m for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Dec 2023 17:22:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01E6060A5E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Dec 2023 17:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01E6060A5E
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374434678"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; d="scan'208";a="374434678"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2023 09:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721548498"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; d="scan'208";a="721548498"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 09:21:54 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Thu,  7 Dec 2023 18:19:59 +0100
Message-ID: <20231207172010.1441468-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701969731; x=1733505731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ejhuq7rcREiXUDQMM5p6SxYKQOlZ+enzGd8uebPKEaM=;
 b=A9HZeX6qnmj6Wkb7Ib5AQOQK4F0HuJSNI84iSwl1NW4+j0K0Y1gLIz01
 sZMKEYVSMGEm0ohdYdo8MAlaMaD6typ6l+rE55xjk/a105bajeD8QpisT
 7mpnqKMU3yHCg5svOjeqkOGpDzkKmhuNkaVsNJxUJZkF+H6RDgJtJlPhN
 0sWZKQwSSUMvvz3PpKF3pqabprZYsIiOw5y6DKzRYyJMAqF7n69T4ip3G
 lajoA6tVTVPdN9aNFgAuMiBCbzns2bcHr8+BD/fLgh+BaqMOw2ptzZOxi
 pXlE3zZQd3zHtJnvnXTimsqrE1n25k/L+Jt2i1cLIGtWNdTIY7Sk+NbWK
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=A9HZeX6q
Subject: [Intel-wired-lan] [PATCH net-next v6 01/12] page_pool: make sure
 frag API fields don't span between cachelines
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Michal Kubiak <michal.kubiak@intel.com>,
 intel-wired-lan@lists.osuosl.org, David Christensen <drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
into fast and slow") that made &page_pool contain only "hot" params at
the start, cacheline boundary chops frag API fields group in the middle
again.
To not bother with this each time fast params get expanded or shrunk,
let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
the 32-bit architectures and 32-byte alignment for the 64-bit ones,
excluding unnecessary false-sharing.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac286ea8ce2d..35ab82da7f2a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -130,7 +130,16 @@ struct page_pool {
 
 	bool has_init_callback;
 
-	long frag_users;
+	/* The following block must stay within one cacheline. On 32-bit
+	 * systems, sizeof(long) == sizeof(int), so that the block size is
+	 * precisely ``4 * sizeof(long)``. On 64-bit systems, the actual size
+	 * is ``2 * sizeof(long) + 2 * sizeof(int)``, i.e. 24 bytes, but the
+	 * closest pow-2 to that is 32 bytes, which also equals to
+	 * ``4 * sizeof(long)``, so just use that one for simplicity.
+	 * Having it aligned to a cacheline boundary may be excessive and
+	 * doesn't bring any good.
+	 */
+	long frag_users __aligned(4 * sizeof(long));
 	struct page *frag_page;
 	unsigned int frag_offset;
 	u32 pages_state_hold_cnt;
-- 
2.43.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
