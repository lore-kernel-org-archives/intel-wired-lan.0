Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004D7C7619A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Apr 2023 12:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 941AC61555;
	Wed, 12 Apr 2023 12:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 941AC61555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681303381;
	bh=/p3M1JkZsCI9hkQ57zNqJLHsEBfrUMcrUD/jSylWQv0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Uj8LZUq+zvsDTDdH+d5X0kBLZ+26pxq+jD9mCPqC1W2310nnjr/IhKo3ZZ8Hoaeum
	 9dxWmWCXnrVueR5g8n5xr3w6Gyd2v5o3lCm/68wSuLuF+kCY/QfAKQGE56T8lI4HIa
	 FnA46Zb8UpZCwuQyzfg4qfyRVeSb96oPNCbO4/h/NwivutCX9EE+IVl8Y2ZEYf9wuW
	 tMFReIjajjZYfeWfHLXlm2fPmebiArAEPUW6oFOzp57yslb+K6sgWwXV8AqEX0tPl5
	 MeAx9xCY2tIVkQClF3up+HRjRCI001m25l5KrKIiX4xhl8UtqRNDwqYx3sBJvpNqFn
	 D9OgH6mnSx4tg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ieYTgbnko61h; Wed, 12 Apr 2023 12:43:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ABE061550;
	Wed, 12 Apr 2023 12:43:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ABE061550
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1689C1BF45A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 12:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E443B83B5E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 12:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E443B83B5E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-mabuWKw8VT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Apr 2023 12:42:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CF0883B34
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CF0883B34
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 12:42:57 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-Zz-IJwvuPi6Z5sEwkERDlA-1; Wed, 12 Apr 2023 08:42:51 -0400
X-MC-Unique: Zz-IJwvuPi6Z5sEwkERDlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 758671C09079;
 Wed, 12 Apr 2023 12:42:43 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2405B40BC797;
 Wed, 12 Apr 2023 12:42:43 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id 38F48307372E8;
 Wed, 12 Apr 2023 14:42:42 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 12 Apr 2023 14:42:42 +0200
Message-ID: <168130336215.150247.1088133245386431977.stgit@firesoul>
In-Reply-To: <168130333143.150247.11159481574477358816.stgit@firesoul>
References: <168130333143.150247.11159481574477358816.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1681303376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPA/2DPgV7DkzsAGv07BeNJ4vzcmIchr5dPwJsagFdw=;
 b=XlwodiYr12UVAuMWfvA3KpNXWizAyf2OeVQdMMK/CbND018iiPnuxs8ZAXHlGBGUdVDAlM
 SKKnoidbs+O2AtomTwX0QVZcoT6+tNJVT/OnyWbK5nru8gyAUZcCR6S/aslAX6Nal6khCw
 KO7lfVfph/cRQyaiaanWhLv+2KwWquk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlwodiYr
Subject: [Intel-wired-lan] [PATCH bpf V8 1/7] selftests/bpf: xdp_hw_metadata
 default disable bpf_printk
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

The tool xdp_hw_metadata can be used by driver developers
implementing XDP-hints kfuncs.  The tool transfers the
XDP-hints via metadata information to an AF_XDP userspace
process. When everything works the bpf_printk calls are
unncesssary.  Thus, disable bpf_printk by default, but
make it easy to reenable for driver developers to use
when debugging their driver implementation.

Next patch will add counters to track some of these cases.
That will provide a hint to re-enable bpf_printk.

This also converts bpf_printk "forwarding UDP:9091 to AF_XDP"
into a code comment.  The bpf_printk's that are important
to the driver developers is when bpf_xdp_adjust_meta fails.
The likely mistake from driver developers is expected to
be that they didn't implement XDP metadata adjust support.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 4c55b4d79d3d..b0104763405a 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -5,6 +5,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+/* Per default below bpf_printk() calls are disabled.  Can be
+ * reenabled manually for convenience by XDP-hints driver developer,
+ * when troubleshooting the drivers kfuncs implementation details.
+ *
+ * Remember BPF-prog bpf_printk info output can be access via:
+ *  /sys/kernel/debug/tracing/trace_pipe
+ */
+//#define DEBUG	1
+#ifndef DEBUG
+#undef  bpf_printk
+#define bpf_printk(fmt, ...) ({})
+#endif
+
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
 	__uint(max_entries, 256);
@@ -49,11 +62,10 @@ int rx(struct xdp_md *ctx)
 	if (!udp)
 		return XDP_PASS;
 
+	/* Forwarding UDP:9091 to AF_XDP */
 	if (udp->dest != bpf_htons(9091))
 		return XDP_PASS;
 
-	bpf_printk("forwarding UDP:9091 to AF_XDP");
-
 	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
 	if (ret != 0) {
 		bpf_printk("bpf_xdp_adjust_meta returned %d", ret);


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
