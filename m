Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BCAC44501
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Jul 2026 23:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE36D60721;
	Wed,  8 Jul 2026 23:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EX9ZDz3JVyP6; Wed,  8 Jul 2026 23:05:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F5526071F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783551926;
	bh=GWr+/cYzoqlgW0kcEges+YFVPk1EvrUUCWQCvaQHOqI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vvj8C+kwKH0eMeJ/Tfhz2yEC9SAeaUb486c9DSczn0GVlJbzJUaYoAUg38KYSzaN9
	 PCX1V11E27y7kvUebwv9e12qt6bFyKgGhBENtH7dILYti3+5jNYHhkEOUyM+sZCYQt
	 zEL/QEj5IxzhpdKvd4CLtcPQ84LMRCgFpo/Z6BU9aSlRgY98fuKwDzU7pmayRggNt5
	 t99qpG0mdiEEvEsboSvh682bhiTrq3uH2ZW80T/5AXDaieL9JR9LeBjtTe9DY2JlKm
	 bTvYRSBmao+mWg32wEHl0m8SM208SNTam4QKZodF40wsbPysgfJa1mLIddR5cEajsJ
	 11ok7BJYkVUeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F5526071F;
	Wed,  8 Jul 2026 23:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D97273A8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7DD180B03
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3c1CGmuHIgW for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Jul 2026 22:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:205::77; helo=outbound.qs.icloud.com;
 envelope-from=deliran@verdict.gg; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7CB1280A49
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CB1280A49
Received: from outbound.qs.icloud.com (qs-2005l-snip6-6.eps.apple.com
 [IPv6:2a01:b747:3006:205::77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CB1280A49
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Jul 2026 22:57:01 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 E61603001123; Wed, 08 Jul 2026 20:34:54 +0000 (UTC)
X-ICL-RepId: 019f4370-d0ce-7cdb-8d2c-bde2998f77a0
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGlgfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 00DA9300011A; Wed, 08 Jul 2026 20:34:48 +0000 (UTC)
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
Date: Wed,  8 Jul 2026 23:34:06 +0300
Message-ID: <20260708203410.45121-3-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lo6NqBdX611puj1IL8BWwXcDTgFJwfIx
X-Proofpoint-GUID: lo6NqBdX611puj1IL8BWwXcDTgFJwfIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX5VrYUA0tufOn
 ktYk9UvpocZIym5Q9GBeOgMFdThscsOvClhGAi3jjTiI5wddEoS2zpFbp9bjDdlr1UcOscQ9pgO
 MqAYl3YlggfGrqUeS2CKHnliNLDQe8RkAfz8AN/0rl9ogiMQiYM68eGbIu8pTzMtkCyLcdQwqse
 o3t7aB3/EznB/IS6EproSpb3sVxXz7yXf3py37a3/CvhJvlE5hGzvchf9QUpySVX8aZKm1Garo0
 m3jc9bcGvEvewwyrv/Daqzlp7rmxrDC66o4/WcG7GjjqFIWvysxI2AgeubNcadEhMVtxtL5QPHS
 Xr9e0+VrvaBQ91FC5qG
X-Mailman-Approved-At: Wed, 08 Jul 2026 23:05:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=verdict.gg; s=sig1; t=1783542901; x=1786134901;
 bh=GWr+/cYzoqlgW0kcEges+YFVPk1EvrUUCWQCvaQHOqI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dL4HSmuqc/VJH0/UZr+88qr6rSn61knIn8+Wh9JIlJHgVotUdvZAEHbMDJcsshsK5kPIOsZ7ThORGJDpEDSbAxy7Fq19PCZ22/FmuFiCUAdd4b8OWr7EFkROdtf4NMhDB7yNHRS4dcOb+Jl+rZWPYvF1X1P+nAJQ1navn6KWneWoQF+8ChI4dtZXLGAYiX9NB0xKgdLsokenF1elFDGbjDCdnZFKKtN6GOa3KomrINczVDq9VwJR6kaO+JBtpFak5K18Uv0vomG862ECLCpFmGX4hY6+hYN5ekM3f6ZEjbXj6M1k2XPclrG9D74jSdQXFa8ix19ERuaSSEgf1gTAVw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=verdict.gg
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=verdict.gg header.i=@verdict.gg header.a=rsa-sha256
 header.s=sig1 header.b=dL4HSmuq
Subject: [Intel-wired-lan] [PATCH bpf-next v4 2/6] net: veth: Add
 xmo_rx_checksum callback to veth driver
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

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the veth device.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/veth.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..498d894d043d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1700,6 +1700,37 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
+				enum xdp_checksum *ip_summed,
+				u32 *cksum, u8 *cksum_level)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		*cksum = skb->csum;
+		*cksum_level = 0;
+		break;
+	case CHECKSUM_UNNECESSARY:
+		*ip_summed = XDP_CHECKSUM_UNNECESSARY;
+		*cksum_level = skb->csum_level;
+		*cksum = 0;
+		break;
+	default:
+		*ip_summed = XDP_CHECKSUM_NONE;
+		*cksum_level = 0;
+		*cksum = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1725,6 +1756,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.47.0

