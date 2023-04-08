Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AF7C7619A
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Apr 2023 19:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9477E41D65;
	Sat,  8 Apr 2023 19:24:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9477E41D65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680981899;
	bh=3bHEQfvQCTkzK/VbPcTwp8clqDMbitjVdrOCp+DCUs8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vyr0hzkwHXc9eJuwqSdGrJf1EVe18UUNZKmbzBCZc9s8PP5o2QZ2ta3IuYNkapCug
	 ckdXmGHaRYuitwmmISOTOH2AmSSg90s8jbnaLQ6TD/PXvwaVcJQ49beZZAFrhiAIJL
	 4olCVs+EwSC4yfNq83mkgZzrZroWVEJEdF2jVySke9GoGaWLg8snYSagfmpfGTzNYt
	 wUivfc+s6k3zXxuBd/VliH7rNcObq1VXkGPh6rfayGWGtlbRYPIrUpgeC5+GNMNxuC
	 Lz1MFxGbF17rfauhrJ7bqjxywcHO8Cz8EuCAEzyqOM7zpTC9o5pAVssOESdmW6q090
	 RmzP9WJ+XWSYA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1v2ri4DBqrc; Sat,  8 Apr 2023 19:24:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09F1A41DC2;
	Sat,  8 Apr 2023 19:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09F1A41DC2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C72CA1C2C89
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A003940516
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A003940516
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TI_20EoK2Ri4 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Apr 2023 19:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B734840160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B734840160
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 19:24:53 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-WNc-nW5aNYCSe86ldUi1gQ-1; Sat, 08 Apr 2023 15:24:49 -0400
X-MC-Unique: WNc-nW5aNYCSe86ldUi1gQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5608D29AA2E9;
 Sat,  8 Apr 2023 19:24:48 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CC4014171BE;
 Sat,  8 Apr 2023 19:24:47 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id 73149307372E8;
 Sat,  8 Apr 2023 21:24:46 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sat, 08 Apr 2023 21:24:46 +0200
Message-ID: <168098188642.96582.9605191658852260548.stgit@firesoul>
In-Reply-To: <168098183268.96582.7852359418481981062.stgit@firesoul>
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1680981892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eO/r8MtggLglxkiJ3agqPFRas0YnxAM9LNBZVhZj1AA=;
 b=Bph0OZpxH7c3kTDsOFLa4KNDor4j/bO/Rbq2/CA09Wbm0CA9CRoHYhk/gtjA83UyOOp3sg
 iE/Y9vKiFEztruF3LLhnh0Q/DSUSLvF8EwCnR/5YTCR5pQXosewZ9v9NhRaYnf42lu7lPG
 +X4BTZbBjyqyCd8UeZmG1pHMM6T7eaI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bph0OZpx
Subject: [Intel-wired-lan] [PATCH bpf V7 2/7] selftests/bpf: Add counters to
 xdp_hw_metadata
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
Cc: ast@kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 boon.leong.ong@intel.com, hawk@kernel.org, xdp-hints@xdp-project.net,
 daniel@iogearbox.net, linux-rdma@vger.kernel.org, john.fastabend@gmail.com,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 Jesper Dangaard Brouer <brouer@redhat.com>, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@kernel.org, larysa.zaremba@intel.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tariqt@nvidia.com,
 yoong.siang.song@intel.com, saeedm@nvidia.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add counters for skipped, failed and redirected packets.
The xdp_hw_metadata program only redirects UDP port 9091.
This helps users to quickly identify then packets are
skipped and identify failures of bpf_xdp_adjust_meta.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   15 +++++++++++++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    4 +++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 980eb60d8e5b..d11aca50e54d 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -25,6 +25,10 @@ struct {
 	__type(value, __u32);
 } xsk SEC(".maps");
 
+volatile __u64 pkts_skip = 0;
+volatile __u64 pkts_fail = 0;
+volatile __u64 pkts_redir = 0;
+
 extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
 					 __u64 *timestamp) __ksym;
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx,
@@ -59,16 +63,21 @@ int rx(struct xdp_md *ctx)
 			udp = NULL;
 	}
 
-	if (!udp)
+	if (!udp) {
+		pkts_skip++;
 		return XDP_PASS;
+	}
 
 	/* Forwarding UDP:9091 to AF_XDP */
-	if (udp->dest != bpf_htons(9091))
+	if (udp->dest != bpf_htons(9091)) {
+		pkts_skip++;
 		return XDP_PASS;
+	}
 
 	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
 	if (ret != 0) {
 		bpf_printk("bpf_xdp_adjust_meta returned %d", ret);
+		pkts_fail++;
 		return XDP_PASS;
 	}
 
@@ -78,6 +87,7 @@ int rx(struct xdp_md *ctx)
 
 	if (meta + 1 > data) {
 		bpf_printk("bpf_xdp_adjust_meta doesn't appear to work");
+		pkts_fail++;
 		return XDP_PASS;
 	}
 
@@ -91,6 +101,7 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->rx_hash = 0; /* Used by AF_XDP as not avail signal */
 
+	pkts_redir++;
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 1c8acb68b977..3b942ef7297b 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -212,7 +212,9 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd)
 	while (true) {
 		errno = 0;
 		ret = poll(fds, rxq + 1, 1000);
-		printf("poll: %d (%d)\n", ret, errno);
+		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
+		       ret, errno, bpf_obj->bss->pkts_skip,
+		       bpf_obj->bss->pkts_fail, bpf_obj->bss->pkts_redir);
 		if (ret < 0)
 			break;
 		if (ret == 0)


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
