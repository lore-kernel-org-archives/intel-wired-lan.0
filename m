Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C990FC43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 23:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B12540608;
	Wed,  8 Jul 2026 23:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lt4b258UVrUI; Wed,  8 Jul 2026 23:05:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E072E40540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783551926;
	bh=+PFlT3RJWe6JoKnddGSkgUhZU+EBpA8u7FgwGEwUuz8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uAt53M0EUgNKAM+QnLyqqlaxSLWkxq0CZRVFiez4X1qkpYGBvWh+4vCaQI7DAKd8V
	 h40aEEHKUVX586BmuaKE5qTmYpsySiRjbdNwfixNPW0mXAGh/Z63dh73HO/mS/X6yj
	 Ve/9glngA9a3UuAsSjFCGzt2yXlO+JbbJPXZljmmvcQsmUL7YnjDmmPiULXJ571Ya8
	 VbTb3LAZHfBakqG5sArz2mJQzyNTCP9MffCLby5z0WSjj5MkmsOEd9cZ2h6r64W5oA
	 0eruMnXSSobh+Wz41SbNp1Oi1h7q9YWSxTb6DLPtugn9k7bJynEu2OXCWtM5AhZVuy
	 gDYoasvgFXPqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E072E40540;
	Wed,  8 Jul 2026 23:05:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E85721077
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDD5B606F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbSRsy86brA3 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:205::29; helo=outbound.qs.icloud.com;
 envelope-from=deliran@verdict.gg; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7CEAE6067F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CEAE6067F
Received: from outbound.qs.icloud.com (qs-2005d-snip6-8.eps.apple.com
 [IPv6:2a01:b747:3006:205::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CEAE6067F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:01 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 3FE41300111F; Wed, 08 Jul 2026 20:35:05 +0000 (UTC)
X-ICL-RepId: 019f4370-f930-7323-895b-d7470b570765
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGl4fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 5D6D23001108; Wed, 08 Jul 2026 20:34:59 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Vladimir Vdovin <deliran@verdict.gg>
Date: Wed,  8 Jul 2026 23:34:08 +0300
Message-ID: <20260708203410.45121-5-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX3j05Hbc6i0Xa
 FwV19KsuyI/eGyRtezOY7i23/f+aPFAX43jgdVdGnjX1ZJxFdFdx9QDc1JMpZ1Ce3FFdyMeVT7S
 if2CcBavqoufVD7Fk2Go6um1X2wFv0zIKqxI/fVvrAG6IjYUuhILhDDTOoOQoAyP0nAggHBgjGS
 elsAuqMkNrP1x984GOysgM178O+2QhqGDOTOeZT6bXT5tpwOO7v7lA3xTqTyghpqH5OaDlHBnzm
 dgzSu5n46dFJSYL66vb9JV8+eFw5ZdzWRe/U9ySdWmQi2qqCQNTHYTh1T4jPuUlR2aCxAxnpHsV
 t+MW06cvm0W3MnKgn85
X-Proofpoint-GUID: _5GTcZh2MDb4kVaLz0CyKt1Ozjyuyi1l
X-Proofpoint-ORIG-GUID: _5GTcZh2MDb4kVaLz0CyKt1Ozjyuyi1l
X-Mailman-Approved-At: Wed, 08 Jul 2026 23:05:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=verdict.gg; s=sig1; t=1783542911; x=1786134911;
 bh=+PFlT3RJWe6JoKnddGSkgUhZU+EBpA8u7FgwGEwUuz8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=qI7QkH7MYvKsl0iKmaZHC9xUnOIK+tRzkAaK/ZoFxAZpkfrQ1w/sU7YJlBfuOmeYbDPdNh7MVSEvZJQnt/flaOfHLAcoRWohlGQCB6KbCSw6VDxuuZyM+mn46srfWVTjA6IPkztZKlo4JHzHhZUa78YXJEzUeGQfrwkPMDuzLHa4cvUp3nUct9hEorAfo6LRN8OP9RtFFoJWTyZvTMC+NwSUC8m031rppDgbCEU5UXbAuxXwDC/h/id5HcrIkP4y0svrW0AtU6kfbLDLew5Yiit6Q5S2qprJ/SuzU65Fa5jjcp6NdpdeDtT1mOKRFNuFW6AvZYcep4ruYM1dsCfYvA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=verdict.gg
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=verdict.gg header.i=@verdict.gg header.a=rsa-sha256
 header.s=sig1 header.b=qI7QkH7M
Subject: [Intel-wired-lan] [PATCH bpf-next v4 4/6] selftests/bpf: Add
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce dedicated selftest for bpf_xdp_metadata_rx_checksum kfunc to
bpf selftest framework.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
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
2.47.0

