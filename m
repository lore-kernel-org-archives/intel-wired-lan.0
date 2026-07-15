Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0AAC4450A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 576F580E80;
	Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpgiLsdx53ei; Wed, 15 Jul 2026 21:41:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9608F80E71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151673;
	bh=bIkDt9gNPr9rmPhQSmqDYoRsChKSWA+sElIKgpyPfrw=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZpGmv1h6dLgMo37u0Zwfa2udhD/q896vWtAmBmCCD/qx82J2n3KhXVOE0UQVVHo41
	 sqJeQnpWIYEZaqcDEXHhHLoC9kQfDj5wRCoKqZXQ2EK4XlPSbt7rNha6KtdOHoWCpk
	 5T4/KyxLAHP874XPWc9GPltZM2DVAV+mgxiaVPjl4SS927mF/ZTEcBkXzGBxj2H9Cm
	 gW2h1CZMjp0DXAMo/QPi+FH6wP6Kk9p2RmmMz3lJZ8HhED2wpFkmUx4sYWblFdmM5A
	 Lhv9ArofyyvwFjh5SR6YbZG/oLd8roWaorrM4KrEdkl5lJ79d6DLwY4tXekMiJ5p2s
	 HC4WZngyNcWZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9608F80E71;
	Wed, 15 Jul 2026 21:41:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D306D320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C498380E5B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwYA4DoEFEbr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DE33580E7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE33580E7C
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE33580E7C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC0D943BCC;
 Wed, 15 Jul 2026 21:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC65C1F000E9;
 Wed, 15 Jul 2026 21:41:10 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-5-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784151671;
 bh=bIkDt9gNPr9rmPhQSmqDYoRsChKSWA+sElIKgpyPfrw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Py81LRRkBx10PB3NIkJdbuh0lWet18eXiuVIjgmoLoaNqS+LA//Bqx++4NQ7FSjFB
 ZDXSW63Ya0gXgwvkOP+u+LRs9UkyokmERHwRKg36DKd2tttofQ+LSopg2Lb7R3Jf8S
 /ysw6TGFfJbWNYwlIHNP98DBVXcgHyupMwW49tq5HebETN1IxV5/usYo16jB8EttUV
 4R/gFKQvquExo4Gv+dYjNubTms9ibpv1CjIA7JluuUuw9qc8wlFFlB2K9vIXVcT9Ub
 3qyixoZ3j0eZ+MWVM1JrRph3KoDr9/dkZmov/82XxTLeyJLNEDjbNY3hzDpKlfwV9R
 n6+SkjHIwF9ew==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Py81LRRk
Subject: [Intel-wired-lan] [PATCH bpf-next v5 5/8] selftests/bpf: add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
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

Introduce the capability to dump HW rx checksum in xdp_hw_metadata
program via bpf_xdp_metadata_rx_checksum() kfunc.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |  7 +++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 31 ++++++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h         | 12 ++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 330ece2eabdb..5eeadb7e27cf 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -110,6 +110,13 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
 
+	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
+					   &meta->cksum, &meta->cksum_level);
+	if (err)
+		meta->rx_cksum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CHECKSUM;
+
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6db3b5555a22..c63a70a54075 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -8,6 +8,7 @@
  * - Metadata verified:
  *   - rx_timestamp
  *   - rx_hash
+ *   - rx_checksum
  *
  * TX:
  * - UDP 9091 packets trigger TX reply
@@ -219,6 +220,30 @@ static void print_vlan_tci(__u16 tag)
 	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
 }
 
+static void print_rx_cksum(__u8 ip_summed, __u32 cksum, __u8 cksum_level)
+{
+	const char *cksum_str;
+
+	switch (ip_summed) {
+	case XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_UNNECESSARY:
+		cksum_str = "CHECKSUM_COMPLETE,CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_UNNECESSARY:
+		cksum_str = "CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		cksum_str = "CHECKSUM_COMPLETE";
+		break;
+	case XDP_CHECKSUM_NONE:
+	default:
+		cksum_str = "CHECKSUM_NONE";
+		break;
+	}
+
+	printf("rx-cksum: %s, csum=0x%x, cksum_level=0x%x\n",
+	       cksum_str, cksum, cksum_level);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -254,6 +279,12 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
 		       meta->rx_vlan_tag_err);
 	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
+		print_rx_cksum(meta->ip_summed, meta->cksum,
+			       meta->cksum_level);
+	else
+		printf("No rx_cksum, err=%d\n", meta->rx_cksum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index bca09b94af26..f864d4a8bd8c 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -28,6 +28,7 @@ enum xdp_meta_field {
 	XDP_META_FIELD_TS	= BIT(0),
 	XDP_META_FIELD_RSS	= BIT(1),
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CHECKSUM = BIT(3),
 };
 
 #define XDP_CHECKSUM_NONE		BIT(0)
@@ -52,10 +53,13 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
-	struct {
-		__u32 ip_summed;
-		__u32 cksum;
-		__u8 cksum_level;
+	union {
+		struct {
+			__u32 ip_summed;
+			__u32 cksum;
+			__u8 cksum_level;
+		};
+		__s32 rx_cksum_err;
 	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.55.0

