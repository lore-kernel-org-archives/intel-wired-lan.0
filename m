Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CE7C44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 21:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45C5580E5B;
	Wed, 15 Jul 2026 21:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHJLePn9jdGs; Wed, 15 Jul 2026 21:41:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0AC180E78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784151666;
	bh=RXeWVuF7smvM1sf5ym+9TItmzzu3cbeVhVuWJ2Vmgp8=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1rIeBgdNZfMfSBzg6/FSsz+otiJWf4NYfhSdUoBFAjunCA79/2ereMoO/Nh5I4Sq3
	 2j5wfUqe+LyrrWp+qG/biyr77gvWmwMzBZvHjhZkeOhAwrNqfUpyMLiDla21oClPr/
	 uZQ0rU/pSmba/L+jZQpgWkdSxE73J6UbnS04oWWGtWjt9F1g8tdK3VPgLeHU4/Yzk6
	 Rg/eND8dctTbGxFymyZAufpPHT/ph8Zp5c9FJollpE1fqP+Bb+cx8QgKs46aqB8ZcS
	 jwSMTZHou9oI99RbU67qYerdAO1YHRMegBIyew9+PgHpnF8HDpCp8f7HPeN6HAJFXx
	 sjcad5o76QTqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0AC180E78;
	Wed, 15 Jul 2026 21:41:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9573320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B724440193
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxhwB7tSPenR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 21:41:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=lorenzo@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F07C8400FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F07C8400FC
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F07C8400FC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 21:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C197B6001D;
 Wed, 15 Jul 2026 21:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB51F000E9;
 Wed, 15 Jul 2026 21:41:00 +0000 (UTC)
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
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
 d=kernel.org; s=k20260515; t=1784151661;
 bh=RXeWVuF7smvM1sf5ym+9TItmzzu3cbeVhVuWJ2Vmgp8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MmD9Nrejvzon9S1bUjQ9XqXt2CN8SD5JTV1MYIpU3XXMLm0I7L6jC1qfaqydL+rUK
 AAGCVpivkbIfJcPe7Znv68GFgNQ4gCYA62+h5/5o0eG5WTrriyTJ3R8h8hjJfF9vHs
 +IOmZBlnJHvkeHDCykonI/Wa/y715cyQqkyJChdA2GMZltvOPl/P6Uh8z+HIcqdNHa
 K9ZyzLNlvLNheZN24XSs9bCAdTyNni0N3EBKilh93N4Pr0SfOGT/laG1wkZW1X9ZKG
 i7x5aSsx47/gioO+sRkyszRs7vfmcV90jNQoFTM8RCMgfNpeT/IjkHousnEMnGlB1G
 VlM79N2CuIfPA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MmD9Nrej
Subject: [Intel-wired-lan] [PATCH bpf-next v5 1/8] netlink: specs: add XDP
 RX checksum capability to XDP metadata specs
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

Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
checksum will be use by devices capable of exposing receive checksum
result via bpf_xdp_metadata_rx_checksum().
Moreover, introduce xmo_rx_checksum netdev callback in order to allow
the eBPF program bound to the device to retrieve the RX checksum result
computed by the hw NIC and reported via DMA descriptors.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml      |  5 +++++
 Documentation/networking/xdp-rx-metadata.rst |  3 +++
 include/net/xdp.h                            | 13 +++++++++++
 include/uapi/linux/netdev.h                  |  3 +++
 net/core/xdp.c                               | 32 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h            |  3 +++
 6 files changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5f143da7458c..6d0d90d3a614 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -61,6 +61,11 @@ definitions:
         doc: |
           Device is capable of exposing receive packet VLAN tag via
           bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: checksum
+        doc: |
+          Device is capable of exposing receive checksum result via
+          bpf_xdp_metadata_rx_checksum().
   -
     type: flags
     name: xsk-flags
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index efdf5eeb49e7..93918b3769a3 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -28,6 +28,9 @@ metadata is supported, this set will grow:
 .. kernel-doc:: net/core/xdp.c
    :identifiers: bpf_xdp_metadata_rx_vlan_tag
 
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_checksum
+
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..d95e126f2426 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
+			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
+			   bpf_xdp_metadata_rx_checksum, \
+			   xmo_rx_checksum)
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -643,12 +647,21 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+enum xdp_checksum {
+	XDP_CHECKSUM_NONE		= BIT(CHECKSUM_NONE),
+	XDP_CHECKSUM_UNNECESSARY	= BIT(CHECKSUM_UNNECESSARY),
+	XDP_CHECKSUM_COMPLETE		= BIT(CHECKSUM_COMPLETE),
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_checksum)(const struct xdp_md *ctx,
+				   enum xdp_checksum *ip_summed,
+				   u32 *cksum, u8 *cksum_level);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..f8caade93c8c 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -47,11 +47,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing receive
+ *   checksum result via bpf_xdp_metadata_rx_checksum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CHECKSUM = 8,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..9bcaa423ad17 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -961,6 +961,38 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
+ * @ctx: XDP context pointer.
+ * @ip_summed: Return value pointer to a bitmask indicating available checksums.
+ * @cksum: Return value pointer indicating the hw checksum value.
+ * @cksum_level: Return value pointer indicating the checksum level result.
+ *
+ * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
+ * values are:
+ * ``XDP_CHECKSUM_NONE``
+ * ``XDP_CHECKSUM_UNNECESSARY``
+ * ``XDP_CHECKSUM_COMPLETE``
+ * ``XDP_CHECKSUM_COMPLETE`` | ``XDP_CHECKSUM_UNNECESSARY``
+ *
+ * In case of success, ``cksum`` contains the checksum value calculated by the
+ * NIC. ``cksum`` is valid only if ``XDP_CHECKSUM_COMPLETE`` is set in
+ * ``ip_summed``. ``cksum_level`` contains the checksum level reported by the
+ * hw. ``cksum_level`` can be considered valid only if
+ * ``XDP_CHECKSUM_UNNECESSARY`` is set in ``ip_summed``.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
+ * * ``-ENODATA``    : means no RX-checksum available for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
+					     enum xdp_checksum *ip_summed,
+					     u32 *cksum, u8 *cksum_level)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..f8caade93c8c 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -47,11 +47,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing receive
+ *   checksum result via bpf_xdp_metadata_rx_checksum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CHECKSUM = 8,
 };
 
 /**

-- 
2.55.0

