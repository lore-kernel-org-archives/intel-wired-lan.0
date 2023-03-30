Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C989FC761A6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Mar 2023 17:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FD7941EAF;
	Thu, 30 Mar 2023 17:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FD7941EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680196086;
	bh=SsspbTCOYI89k6vmr439x03C8ouejofShp6GXv/LKoQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Qf5/Fub1r5YDclv7I9j7q25JsCbhP/7zZJbd+AgZ588VprvGDVOpwA2c4jSVr0M44
	 UAqHKJ7qNgBaVLJNVt84Q5Qzx+P7tfrxTEztxyCTb8uWSJlLVOutvQfKvJ10+DOUiO
	 UQDUeqC7Q4Yfwzbgb95mRT1SuMKoeTcbz1WLK6j0wzfwVJ+ry67+9US79WPAzirklN
	 GxpOqgWuJGGWI3u3bbHSRDVZkSErzWmMamju52NqTgbrRT60ay5JYVL+MWqk9Hf2wR
	 hIZRhcVfswDBd+ObbKw9G8zsNDI1KlalJox+vhEK+uv3bfMpJbzGuS1jSpDIjBfSqB
	 CEWwtfo+T1/5Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id onGPyT20Vg31; Thu, 30 Mar 2023 17:08:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC10441EA7;
	Thu, 30 Mar 2023 17:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC10441EA7
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6872A1BF3C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F4E961672
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:08:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F4E961672
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YXcWJjwAS68e for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Mar 2023 17:08:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 998F46166D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 998F46166D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:08:01 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-aug2f9xDNsKg0k9hF4gfzg-1; Thu, 30 Mar 2023 13:07:58 -0400
X-MC-Unique: aug2f9xDNsKg0k9hF4gfzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C643A101A54F;
 Thu, 30 Mar 2023 17:07:56 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860244042AC0;
 Thu, 30 Mar 2023 17:07:56 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id E2D5430736C72;
 Thu, 30 Mar 2023 19:07:55 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>
Date: Thu, 30 Mar 2023 19:07:55 +0200
Message-ID: <168019607588.3557870.8079404138352729694.stgit@firesoul>
In-Reply-To: <168019602958.3557870.9960387532660882277.stgit@firesoul>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1680196080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZoFlTLlLEFnWNA/e5RUGygzU5KPyB6B2U1PTeQjWe4=;
 b=VGnkd3e/u9oFxYtGAgfw48qiLlsYSoYG4d6P5SKUBc+/y5wdiBdOO4iuxH2JmkxFWYXsPE
 JrKRUE484oQUYahNAS0EX1GYQC79XogZ3W7S/LTYxUL04+EglxP4bQ4bsBnhcUG5bXKnLy
 VMwAYpVIST02PtsBN5yfChaI253TUj0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGnkd3e/
Subject: [Intel-wired-lan] [PATCH bpf RFC-V3 3/5] veth:
 bpf_xdp_metadata_rx_hash add xdp rss hash type
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
Cc: xdp-hints@xdp-project.net, martin.lau@kernel.org, daniel@iogearbox.net,
 larysa.zaremba@intel.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
 kuba@kernel.org, pabeni@redhat.com, yoong.siang.song@intel.com,
 Jesper Dangaard Brouer <brouer@redhat.com>, boon.leong.ong@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Update API for bpf_xdp_metadata_rx_hash() with arg for xdp rss hash type.

The veth driver currently only support XDP-hints based on SKB code path.
The SKB have lost information about the RSS hash type, by compressing
the information down to a single bitfield skb->l4_hash, that only knows
if this was a L4 hash value.

In preparation for veth, the xdp_rss_hash_type have an L4 indication
bit that allow us to return a meaningful L4 indication when working
with SKB based packets.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/veth.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index c1178915496d..f5381e7c9310 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1648,14 +1648,19 @@ static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
 	return 0;
 }
 
-static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
+static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+			    enum xdp_rss_hash_type *rss_type)
+
 {
 	struct veth_xdp_buff *_ctx = (void *)ctx;
+	struct sk_buff *skb = _ctx->skb;
 
-	if (!_ctx->skb)
+	if (!skb)
 		return -ENODATA;
 
-	*hash = skb_get_hash(_ctx->skb);
+	*hash = skb_get_hash(skb);
+	*rss_type = skb->l4_hash ? XDP_RSS_TYPE_L4_ANY : XDP_RSS_TYPE_NONE;
+
 	return 0;
 }
 


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
