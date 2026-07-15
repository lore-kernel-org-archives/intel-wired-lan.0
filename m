Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A96C44501
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E649240829;
	Wed, 15 Jul 2026 21:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqiXW3gM-daO; Wed, 15 Jul 2026 21:41:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C1BC4081C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151667;
	bh=ObIB2B5UEajWK2xeFWUSwolrym3joUTihyi6yd8zpJ8=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H29Eonqrg4eIR30Ayp7ihBpEenB6eSUvq9PRuZU1AiLN+FPqoIA4OTr8R58d8uwtL
	 T9Gh2GiAyYZek0iKnZ0ofgXYCfp7+/Bi/v85iXMrnPwf888DdVsbjpmaQXZ5SUdxYy
	 DWMV68mNi3KuBpwn4aGfKER/jPEuB/z5kMY+OZ10RKNcm+dVjouk9hwX2+aL43rq39
	 S3U9MdhbKo5KqBtvpJfKiatsmImPfM/nJ3YGQ1lUSCDZ7/xVsYFex/2Pm0V2ovWBn5
	 nSBXsksyyxe1AHulDq30eBofD0fq4ppGWHkqVuVv4FVy/Enm6uVPekfK0UKAPJqT5/
	 J8Y1jX3nn1+GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C1BC4081C;
	Wed, 15 Jul 2026 21:41:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48AFA320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A29140815
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gfujXA5aPaBJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D66F4066D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D66F4066D
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D66F4066D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A04661379;
 Wed, 15 Jul 2026 21:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1261F000E9;
 Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-2-623d5c0d0ab7@kernel.org>
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
 d=kernel.org; s=k20260515; t=1784151664;
 bh=ObIB2B5UEajWK2xeFWUSwolrym3joUTihyi6yd8zpJ8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BrDl9FoyE8sDxN3ES/mKWwn4mioM2GN1BOLigXI18U+ZjnZFhqwDo+8YO84P89p4q
 OezPGoW1hswJ9qzxvJwCg2k9bepQFRbLarBrdtZDE38TOFGpKzk3NR2LbjGG217vQY
 1YQkp442WscZ2dnOTTQpv5XoLZPZ1xPSDLDylZ3t+r1VNijiyvXxCFE9+Q2sgmVgWj
 bJeVi2/qHS42QDznnOx6q/GtG9jzu4fBHwuM0z3xsaOiXmL++G8iSyYSQrrzc2JsqX
 7/5PnPoLIDDJkAasB0o6QTrdvdduV5Sycffxec+S6w015+zkxWNyYNLxTZr815k/VF
 jd31xL0NRNh4g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BrDl9Foy
Subject: [Intel-wired-lan] [PATCH bpf-next v5 2/8] net: veth: add
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

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the veth device.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8170bf33ccf9..dbf30089581c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1701,6 +1701,37 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
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
@@ -1726,6 +1757,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \

-- 
2.55.0

