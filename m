Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64183EB26EA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Feb 2026 17:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EBF940702;
	Tue, 10 Feb 2026 17:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4urQfFAIonm; Tue, 10 Feb 2026 17:22:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5844340790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770744132;
	bh=TTWCdTM1DnTcf0j62OS1U9b3UGOhOtaFwq4LSoHceNo=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uS06QpSTwwCDDPLBDFM5agvkQ5njc3roV6ONJdILFH7KYVv+Ssl3F8mKq1cDF2m3G
	 O50njUZXRNf01Z8kEVbl/ASSjsiivqlpjhDDnz3Xq97Mpl1z9LeosjrVKb51Y9V8Jv
	 9Xy9GH9EcenDzh4sBFZF8Pi6o1PA60TDOGDRcYFlX7cpuUQSLSAA2kcNVY4AhFQig3
	 afT/7OpmwdnbeLNFf/8ckFhTgezu8ayHr4BUIKFDYF2He4+T95/irCgdjLfSD33A05
	 vSfHAEbuOe/ePqkZxVnim6OctYhJO/VDxaukSIyBBy1gtasA7eAM9eIk5IAGrX+mnq
	 mCrRqMR1sE/zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5844340790;
	Tue, 10 Feb 2026 17:22:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFCC41A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B570060B13
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQFbOQrUSD5H for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 17:22:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1386160B18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1386160B18
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1386160B18
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:22:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B876444F7;
 Tue, 10 Feb 2026 17:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A469C116C6;
 Tue, 10 Feb 2026 17:22:09 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 10 Feb 2026 18:21:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bpf-xdp-meta-rxcksum-v1-2-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770744130;
 bh=JAEMyV1TNwzlux2cgmKyDqshObhiQMHMmD4rd7uoQPY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rU41223K2+rA1C3nyhJokzdaYOw2NxYHmp9tP+Qb2kzw7GeNMX9P7KqqSnp1InX4z
 4vroi5OSAlhUtWf59Ik0F6C+IIV04WJx4jGw+pJ6TazI0V/TsUgowmxhtYDgoInkgu
 glNyOvhoQ16jcVVi7Xkxd+Uk+gX6HBDWd3Onfsc9pRuFqBCR6ci6pgeqC0KE/CCXVd
 z3k5tAfAofmPjgRLJOLeEtfWErDIXWx4Dr+f5q4NR4YTPuGwO3sW9tco790xEaMYTJ
 mEHsqgvguPN7kJ4MdlK99CbDvB8XqEfDyJNK2edUIeOKCyhJ6QaoqrkKnIzhtQh8aa
 qo/Y1Iok8XRQQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rU41223K
Subject: [Intel-wired-lan] [PATCH bpf-next 2/5] net: veth: Add
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

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb7783334d8f6afd54e658cf9a0e6f3d..38b70ad62db7e92cccc6c6c9ed1f5573d8baf48b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1693,6 +1693,25 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
+				enum xdp_checksum *ip_summed,
+				u32 *cksum_meta)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	/* For locally generated packets ip_summed is set to
+	 * CHECKSUM_PARTIAL.
+	 */
+	*ip_summed = skb->ip_summed;
+	*cksum_meta = 0;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1718,6 +1737,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \

-- 
2.53.0

