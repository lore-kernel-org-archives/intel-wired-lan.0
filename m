Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFF1C44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ACA340820;
	Wed, 15 Jul 2026 21:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBjAnWukb37S; Wed, 15 Jul 2026 21:41:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ABD340847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151672;
	bh=JQ8p5mYtWA3i+I5cBoLmSPNPAhSP0HZCk2Kpee4AGAc=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iqrkc3EIeWlGu3LUM4QjtU3IHj6K5Q+khNaLa3BKxktwe0H8DbWEax77pflPvgOWq
	 Nij9ov/IzKwTRXvZ1cC/ShzqZGQFNMkvl1vZvdAsBGh0AQr4dH7sU5hd9055vEUrX/
	 b9UFMC//kFU38eWoIjB8jngDOX+zveq+swha+Ihp4GaGnKYit4bjSmdUBOSpFzhaWk
	 OWtLqIsPBfT/JBZ4fY0dlWH7Hn0Wc2me0sLGRXMQpJv4k19TLOwC3Y3sBOtqwznZtr
	 gQlo7c0Vs16X3mLLjM8Oq7vGf6yuVfrFPiPsMEpzlygNhHre5k5JQU2ELP2INMXkOI
	 Q9Ep+eItBEGkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ABD340847;
	Wed, 15 Jul 2026 21:41:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B27A320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CC664019A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smUvFe9JHZO5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=lorenzo@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9E12040193
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E12040193
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E12040193
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32CD643B63;
 Wed, 15 Jul 2026 21:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB3C1F00ACA;
 Wed, 15 Jul 2026 21:41:08 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-4-623d5c0d0ab7@kernel.org>
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
 d=kernel.org; s=k20260515; t=1784151669;
 bh=JQ8p5mYtWA3i+I5cBoLmSPNPAhSP0HZCk2Kpee4AGAc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jUOCxkHifOGgYxxJeVSPBvGbTVZqau9fN1EiYF+vVXwcnR7Mlaz6PXl4GdBJNBNyB
 GAkdQ/Pm9hyhdVDRpYNgrW4gsultzAXDb6NM5LA8+a0O2biGC8Fq/Uj7LXwCCKWJsN
 v0n6NpEMMwVWmPz1Uvz2DgpmltBoi+ZVQ4gfOsIDYWfaS0zPsg7IixbKSf/Dyy8hFE
 1zmTb4GGW8hNXq7n2GhKuvysx2vSNTq8M7Idp865Y/StKT9JJiHZGOtwqkWFBsBTue
 E9XAbIuKLcsZdRUIXRNbciahDtXzpFpHd4uFKU0WbnTgwk8y/SF/LmECTwZXWooqX8
 HWChQtsKPddwQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jUOCxkHi
Subject: [Intel-wired-lan] [PATCH bpf-next v5 4/8] selftests/bpf: add
 selftest support for bpf_xdp_metadata_rx_checksum
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

Introduce dedicated selftest for bpf_xdp_metadata_rx_checksum kfunc to
bpf selftest framework.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 9 +++++++++
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 ++
 tools/testing/selftests/bpf/xdp_metadata.h            | 9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..91de61c822f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -310,6 +310,15 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
 
+	if (!ASSERT_EQ(meta->ip_summed, XDP_CHECKSUM_NONE, "rx_ip_summed"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum, 0, "rx_cksum"))
+		return -1;
+
+	if (!ASSERT_EQ(meta->cksum_level, 0, "rx_cksum_level"))
+		return -1;
+
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..af1e19d48d67 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,6 +98,8 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
+	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum,
+				     &meta->cksum_level);
 
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..bca09b94af26 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -30,6 +30,10 @@ enum xdp_meta_field {
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
 };
 
+#define XDP_CHECKSUM_NONE		BIT(0)
+#define XDP_CHECKSUM_UNNECESSARY	BIT(1)
+#define XDP_CHECKSUM_COMPLETE		BIT(2)
+
 struct xdp_meta {
 	union {
 		__u64 rx_timestamp;
@@ -48,5 +52,10 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
+	struct {
+		__u32 ip_summed;
+		__u32 cksum;
+		__u8 cksum_level;
+	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.55.0

