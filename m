Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F122CA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 10:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4C3781202;
	Fri,  2 Oct 2026 10:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1j5BhvljXve; Fri,  2 Oct 2026 10:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 051BB81205
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790937114;
	b=ZsD4FB43hAahzSHp4ohSHErLcSOl7RQorOH5YlwwT01fRBikBBjlGQ5GS4fznRYQpQIb
	 Qzbt5gtcXFh0Tlh5VwWWN0GiDPt2npRcChCGsE+cPRYATupQ5NL2y18Hqp/1MKoOFwXNX
	 5MgVEzvJ+kSfk7YTsPDPfd1c+1oz9HbKvUQSI27PirXKmz1BW2tOoGHnBVV1vTJdhulv4
	 ehgXCxtueESqOlbu2PKBaTkdgZRWXBqpXPqd7E1jI0yZSf3/mLbkHwK563tCMuxk0BNEt
	 7nkVJ6AxWntK3OAUayLfGo53QCS+r2e+xXRBQfhKvA1DPp29GlcmL1PpZDnpKaG/hQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790937114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UbTwYRHb8DyqJwziSa/wyNcRZN8bf0V0Em3U5wv/Th0=;
	b=ClaF6nwutv/Minp/UFN2Y4SlOHwjwHgMPnRRylAKawvJIBFpvnyMX7k4rj2+TWznlyjx
	 /4yKEmChg/TKQdY0f2lOSDZZ6UD5RAkBbsQ6uAwt7wjnZCJLLIQf+EzBoLdYVuktHQGRF
	 CebMxH7MrA6R3bfoc+UvJASWsrZoANte3S3xQw6CIC6ntsLpu2MhII2ixTak9ctmo7Qf0
	 cFhRGDno+Fxf5ppZAwKkEBq4Cpqf+OQ/LabwgZbZy+QkYTdBEu33lRoDkO7ismHFHoFc9
	 W3GLMHkBdumlUtMexYrFq/W/dPISQfbD+OlnjB00p/JfgN3kAY5TQ53Ws35KKO6AHxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790937114;
	bh=UbTwYRHb8DyqJwziSa/wyNcRZN8bf0V0Em3U5wv/Th0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4dQT6cMTnl+ftdTtafG8+Id8jnRmZruGDMGfBYxpqAWl3dpDoNK5UIo3nlGGwKqyn
	 +VCgxCYmPhcLKF/LlwuysSNW3KjKEept3ta8wrlrAhbd1ntmxGKm8mycY9SYfy0OE+
	 cUz6wdJB+3Mzm3EwUxDCOdPGFcxX6K5KGVoOvKyU8/0xwRD/1Px87ge4jbSdqRr+hS
	 UeYJP2hOBujGP/bJY+nxw/j3ZejTy/N8R2E2Ew50oHHXseTJlm8SrMHz4hIJkKhj81
	 9MWPjseczpS7f4IhDOigvZfekEJVR2lOJssPFFbkMYsvRIabF7pxdLdesAOg/z+z8T
	 DaAtljXfPXxcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 051BB81205;
	Fri,  2 Oct 2026 10:31:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A350A34D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 10:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 951C160828
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 10:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PogR7wGyTgQq for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 10:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D1D66080A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790937112;
 b=PrREW90nV6JtYRmX0k0NBc/NJ/i3R9lyteNWrz1NfLMrJuWPmwOVtx62ZHssAIF7B2uT
 o/Vpldqe7QDgG+yvtaETl27GwaAHNgoq/klXDrRKbbACerPIPu1Y/U5ihRInYm47ThnHZ
 5mmTnNuSk1M8KxUydzrJwMKsi9Zgr+Kr17tdUQeISzHNFmNfd4gnqyxPmk5RN7DN0icfX
 /pfki64qB4RLLfY0q2Z00ZSZslG1igG3cKlE/fozirz57+I1BASwIX1YMYYJb9WRJ3tzq
 KKVRAECmKMO6xokjaKdtixT7QjFeNwVVMsiE4VOa5YgGPUVDU5bzsniUMWNGhMYtJyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790937112;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
 bh=UbTwYRHb8DyqJwziSa/wyNcRZN8bf0V0Em3U5wv/Th0=;
 b=pcTx59C3F0/qGuJVl5xGcMFKk3EiUHrOyvWW0Y+ArwzysaDz7zPqO8QjGgxpxoxJFOX/
 M2zU4QCS3VXPBKoqApjkLxk8RXnI7JxscelpwYqMm+pjq82o/y7fjFpsHQ4AV5MwA1OYk
 IbR95lsCIUAKu1PlI9N/mS7cMXYH8JTuWC8OdHf2pyqaYFr1s9ZUhRnR5bw+FkPfikqv4
 y1PB4iM5V/6jZ6NP4/36DTpaj2fvPrLfrQzWa0pKFerDpHhw8eYov+MXAoHpECAX99qWG
 sEr8+qUjXkj2JpkIoTXrWCHmMbbIzl73OvACDlTGOMltHkmZ6P7LwfEmvnU82wKbUjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=E56lrZ0D; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E56lrZ0D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D1D66080A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790937109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UbTwYRHb8DyqJwziSa/wyNcRZN8bf0V0Em3U5wv/Th0=;
 b=E56lrZ0D9Ddlko0icwmfy/m/wVFOsCpN19kEVlmJibkJH/kipAo3xqZboyd3Egvdypyr8v
 7/bb3DNQGwkyxyQv827DwiWwWChAP6pjzjcvXqmfVvT55Z3ASyiqdTQ8x2xSxESCw+qmY3
 SABkydRFY7Kb7a0I5U+uob54B3htOHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-N3yYzrrcMRi4_1DBORVtWA-1; Fri,
 02 Oct 2026 06:31:45 -0400
X-MC-Unique: N3yYzrrcMRi4_1DBORVtWA-1
X-Mimecast-MFC-AGG-ID: N3yYzrrcMRi4_1DBORVtWA_1790937103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92DBC1955D62; Fri,  2 Oct 2026 10:31:42 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1114180034F; Fri,  2 Oct 2026 10:31:36 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net] ice: keep the VLAN tag of priority-tagged frames with
 Rx stripping enabled
Date: Fri,  2 Oct 2026 12:31:08 +0200
Message-ID: <20261002103108.2513191-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: EeCRPmo9K5cHXXDS9ki3rfTqF9Bqaq6eg1bg0DpSPuc_1790937103
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

With Rx VLAN stripping enabled the hardware also strips tags with VID 0,
but ice_receive_skb() only puts the stripped tag back when the VID is
non-zero. Priority-tagged frames reach the stack as untagged and a vlan0
upper device never sees them, while the same traffic works with rxvlan
disabled.

Hit by our QE VLAN test on an E810-XXV, where ping over vlan0 fails and
tcpdump on the PF shows the peer's priority-tagged ARP requests arriving
untagged. Reproduced on the net tree with a PF and its VF as the peer in
both single and double VLAN mode. i40e had the same bug, fixed by commit
2a508c64ad27 ("i40e: fix VLAN.TCI == 0 RX HW offload").

Put the tag in ice_process_skb_fields() keyed on the L2TAG1P/L2TAG2P
status bits, let ice_get_vlan_tci() report whether a tag was stripped
(this also fixes the XDP VLAN hint for a zero TCI) and drop the now
trivial ice_receive_skb().

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Fixes: 714ed949c6f3 ("ice: Implement VLAN tag hint")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  5 +---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++--------------
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 27 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  5 +---
 4 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 31303ab5be175a..3935ac05a251b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -970,7 +970,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		struct sk_buff *skb;
 		unsigned int size;
 		u16 stat_err_bits;
-		u16 vlan_tci;
 		bool rxe;
 
 		/* get the Rx desc from Rx ring based on 'next_to_clean' */
@@ -1051,8 +1050,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 		}
 
-		vlan_tci = ice_get_vlan_tci(rx_desc);
-
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
@@ -1061,7 +1058,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 
 		/* update budget accounting */
 		total_rx_pkts++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d18..19307086c238f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -218,6 +218,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       struct sk_buff *skb)
 {
 	u16 ptype = ice_get_ptype(rx_desc);
+	u16 vlan_tci;
 
 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
@@ -238,29 +239,13 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
+	if (rx_ring->vlan_proto && ice_get_vlan_tci(rx_desc, &vlan_tci))
+		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto, vlan_tci);
+
 	if (rx_ring->ptp_rx)
 		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
 }
 
-/**
- * ice_receive_skb - Send a completed packet up the stack
- * @rx_ring: Rx ring in play
- * @skb: packet to send up
- * @vlan_tci: VLAN TCI for packet
- *
- * This function sends the completed packet (via. skb) up the stack using
- * gro receive functions (with/without VLAN tag)
- */
-void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
-{
-	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
-		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
-				       vlan_tci);
-
-	napi_gro_receive(&rx_ring->q_vector->napi, skb);
-}
-
 /**
  * ice_clean_xdp_tx_buf - Free and unmap XDP Tx buffer
  * @dev: device for DMA mapping
@@ -587,8 +572,7 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	if (!*vlan_proto)
 		return -ENODATA;
 
-	*vlan_tci = ice_get_vlan_tci(xdp_ext->desc);
-	if (!*vlan_tci)
+	if (!ice_get_vlan_tci(xdp_ext->desc, vlan_tci))
 		return -ENODATA;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index f17990b68b621d..579ce56c0c3c0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -70,25 +70,32 @@ ice_build_tstamp_desc(u16 tx_desc, u32 tstamp)
 /**
  * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
  * @rx_desc: Rx 32b flex descriptor with RXDID=2
+ * @vlan_tci: VLAN TCI stripped by hardware
  *
  * The OS and current PF implementation only support stripping a single VLAN tag
- * at a time, so there should only ever be 0 or 1 tags in the l2tag* fields. If
- * one is found return the tag, else return 0 to mean no VLAN tag was found.
+ * at a time, so there should only ever be 0 or 1 tags in the l2tag* fields.
+ *
+ * Return: true if a VLAN tag was stripped and stored in @vlan_tci, false
+ * otherwise.
  */
-static inline u16
-ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
+static inline bool
+ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc, u16 *vlan_tci)
 {
 	u16 stat_err_bits;
 
 	stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
-	if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
-		return le16_to_cpu(rx_desc->wb.l2tag1);
+	if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits)) {
+		*vlan_tci = le16_to_cpu(rx_desc->wb.l2tag1);
+		return true;
+	}
 
 	stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
-	if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits))
-		return le16_to_cpu(rx_desc->wb.l2tag2_2nd);
+	if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits)) {
+		*vlan_tci = le16_to_cpu(rx_desc->wb.l2tag2_2nd);
+		return true;
+	}
 
-	return 0;
+	return false;
 }
 
 /**
@@ -132,7 +139,5 @@ void
 ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb);
-void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
 
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c35a..fd2e628a8bc95c 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -591,7 +591,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		struct xdp_buff *xdp;
 		struct sk_buff *skb;
 		u16 stat_err_bits;
-		u16 vlan_tci;
 
 		rx_desc = ICE_RX_DESC(rx_ring, ntc);
 
@@ -667,10 +666,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
-		vlan_tci = ice_get_vlan_tci(rx_desc);
-
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
 	rx_ring->next_to_clean = ntc;
-- 
2.55.0

