Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71A606A31E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 25 Oct 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HkzCmCOz;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=dsFm069s
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0184260618;
	Sun, 25 Oct 2026 06:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CFcL2Y6YhUW; Sun, 25 Oct 2026 06:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 950C560615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792911149;
	b=e3tw9ejFg6zppGSrxXBzkRU8jJZjYdGYlYZk604odGefyB7hUfgZOPXtT32L3cvrvI4E
	 fnOctJwXLb7zi0Stpsf0W+VoBGoPB73qZdKaNT7navxesweLayH5Oay5O68Sbp7wBWBsh
	 dNYrtEZYoDRmWGQKSWzynrzrIkd3bTpWLFRvZaV4y2BOhRxlm5zbg0maqZES+ugIzdkQE
	 4LxeclK4tmn3NYOMdUhTepnROLfIJBftKkohQH87RDpGiGkOSvXrPNlyb+2vxCZJiWw0j
	 pBf8/IkAE8cxFtBg1dy84WLdObXBGbJaAUgpNiRjELXOtYeQ8KwZZSoC9xloHn/hLXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792911149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lwQ4f2ZvBH062ZEHXjSVyzILEqPMVfwCfFpffv1k8n0=;
	b=Ltx5aswxtZhoWAcuCUG3L5wTmgIE2gRvBuinwynSg3LY64SAsSYvoCc7jwLRH19j2Jxh
	 5+1QR3oOOHi4UKlkVS/Y0Fqzbe5Ne5YNzAFX3QEC7WPsYcWSnonBcKrE5ZEfgYfkaRlDf
	 N8OfqLBVdPquDnH64HM8VGRvbNZfcF67QuO02QA+xQSeTaGDdPhgIwWUp7MVMiU42CiFM
	 q8JDQhsnQkcPTtoX7lhEJr8Ea5uGGW2vS+F/SbpWtVu5P0YBqCw/9nByc1oJIh+YCeErp
	 vQ3ZEGxk3sxlEQCBQvQ9JP+NfYMiw7LzDqbCXPvL1jN6k+uguhPUo6oMOnkIdvYQf9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792911149;
	bh=lwQ4f2ZvBH062ZEHXjSVyzILEqPMVfwCfFpffv1k8n0=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HkzCmCOzJOZGG5ztmm8WvAXQ5gNqC3X5c3zlkUNRsevnCL1zEqZvgkx3SCeTvqNWm
	 wQHY8BTBTQphX1WyqgguxtEKcUpgsK4g0LUBiwkTBIp9egyk6m6YxrGP4jfoU5KR/t
	 x0nHurfZn+BbYmUaSCwiLrI0JqzlGR1I/w0XETpHKB2nz3tbzaPvfvMJmJg2bQo4SE
	 39bEBr8x7mNiZtmJ0Kn4A1BXQ9zJTUQ2Z7i6r6Fl/SiYrET5wirwgGbL99pHuR1RJk
	 Gyzu1+TNbRwKFJrEi3j3rowvRUzQATL7LDtaQx+tYESKO4qeDoQAoYQ7bZ5C96MSVP
	 1l7ZetBxe404A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 950C560615;
	Sun, 25 Oct 2026 06:52:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3832B380
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E29B40664
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLeOOPk7tSAw for <intel-wired-lan@lists.osuosl.org>;
 Sun, 25 Oct 2026 06:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6754340660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792911146;
 b=kOU+jXqn8DYKqX7bwE9A9/tqLeW6mWhpVez2K/mNR73nlE8TBgg0wI2IguW41rT+ndQK
 JZcG9WbQb6zki4smqKTV1NrioLtLFqZSC4ueaRSoTaD2tVni78UGDb7fyqRtg9W8YHG5s
 ayqJmMJwxCToZlPVS4zKiFtU92o8270pTWW8PnrTIGdD4AqTLyQCfs46pGV57VAngnnpl
 uFyVldI8NxgdtQc02/+biXnk5c5pjLq70SoaND7uYonA5UfnsLWS/F4gtvEXStLJwUHBn
 2Gywt4x2HDuCkTdztmoY0M2l9mrycAgofuT6axfgfN6vbr1PtjUutfNuJmDBDev+OCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792911146;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=lwQ4f2ZvBH062ZEHXjSVyzILEqPMVfwCfFpffv1k8n0=;
 b=GVnppcPBwP0fHvrCIauqGwC0tmcYQfKY+VqLridVMu95jGiVoCNTFVqMRQXtBC63LmUd
 i85WZBEndrfYd2MW2DABRlF/Bcqq62uI628SEO6Dai75GJ/yyZI5aVPTen3MWVATk6KeV
 u45zsMVMJEKWPUVDMOSJ9J7FF6Inx+3AsPhaMIEJGjrwq2ifABnXnwtV/R7M90GSwLvVI
 13MdApxi8HiRQK1+WVdnh5XndrMyC4AaEA5epGnh5njYABV5j9Ifc+0FunLBx/mexhH68
 4ADRDh9EkhXqlJCyHxexAqnrlXaNY/hxmTnHZ8GVpS/T0602w2M951xJE3Xm0OkihNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=dsFm069s; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=dsFm069s
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6754340660
 for <intel-wired-lan@lists.osuosl.org>; Sun, 25 Oct 2026 06:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1792911134; x=1793170334;
 bh=lwQ4f2ZvBH062ZEHXjSVyzILEqPMVfwCfFpffv1k8n0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dsFm069sFcpfabfZXMqxJf8Y2iQPD2Hw1DSKMo0/ipyfxypJyLFax3fUFZI0Wc5jz
 OB8ns7Z6PEE75f8UgTi1xcX6y2dq4F2NyizwKQq+AKONn/xYGdShA3xvtbg0vXbQ8a
 G2KBrtZD0y3qDdruiOIcy6wljnYdaRslpdPiohC+vpfYrdgrCZwGjJsndG2567u9Zi
 VzfpXFPqmurzPL6npUfEbw97cLxbebn5dtNpT7cL5kysXDVdz9jqdpLn0uDdNz0o3n
 b32KkfyDI4GjXNeUdGfvyUN2iU3AYGfuhnQ/W/QFEyMw1ovjmXPIe8P8pPqf7lwcB6
 e2mFGYfNrh+pA==
Date: Sun, 25 Oct 2026 06:52:06 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com,
 andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <20261025065154.2037149-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d7913055a968b10d30843429c75eb5326aaf17d2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TSIP remains set on continuation descriptors, but the inline timestamp
header exists only in the first buffer. Stripping it from every
descriptor truncates split frames and can underflow short buffers.

skb ownership cannot identify frame boundaries when XDP consumes the
first buffer or AF_XDP uses zero-copy.

Track rx_in_frame per ring and update it as descriptors are consumed.
Strip timestamps only from first buffers, reject unsupported split
frames before XDP and drain continuations. Account discarded
descriptors against NAPI work without counting successful RX.

Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Fixes: 26575105d6ed ("igc: Add initial XDP support")
Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
- This supersedes "igc: only strip RX timestamp header from first buffer"
  following feedback from Simon Horman, Maciej Fijalkowski and Sashiko.

Changes:
- track frame boundaries independently of skb ownership
- guard timestamp stripping and drain unsupported split frames
- cover the AF_XDP zero-copy RX path
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++-------
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/in=
tel/igc/igc.h
index 17f213cc93e4..635d49701e62 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -198,6 +198,7 @@ struct igc_ring {
 =09=09=09struct igc_rx_packet_stats pkt_stats;
 =09=09=09struct u64_stats_sync rx_syncp;
 =09=09=09struct sk_buff *skb;
+=09=09=09bool rx_in_frame;
 =09=09};
 =09};
=20
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..9ca5558c762c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring)
 =09=09igc_clean_rx_ring_page_shared(ring);
=20
 =09clear_ring_uses_large_buffer(ring);
+=09ring->rx_in_frame =3D false;
=20
 =09ring->next_to_alloc =3D 0;
 =09ring->next_to_clean =3D 0;
@@ -673,6 +674,7 @@ static void igc_configure_rx_ring(struct igc_adapter *a=
dapter,
 =09/* reset next-to- use/clean to place SW in sync with hardware */
 =09ring->next_to_clean =3D 0;
 =09ring->next_to_use =3D 0;
+=09ring->rx_in_frame =3D false;
=20
 =09if (ring->xsk_pool)
 =09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
@@ -2111,10 +2113,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_buff=
er *rx_buffer,
  * @rx_ring: Rx ring being processed
  * @rx_desc: Rx descriptor for current buffer
  *
- * This function updates next to clean.  If the buffer is an EOP buffer
- * this function exits returning false, otherwise it will place the
- * sk_buff in the next buffer to be chained and return true indicating
- * that this is in fact a non-EOP buffer.
+ * Advance next to clean and retain frame position for the next descriptor=
.
+ * Return true if the consumed descriptor does not end the frame.
  */
 static bool igc_is_non_eop(struct igc_ring *rx_ring,
 =09=09=09   union igc_adv_rx_desc *rx_desc)
@@ -2127,10 +2127,8 @@ static bool igc_is_non_eop(struct igc_ring *rx_ring,
=20
 =09prefetch(IGC_RX_DESC(rx_ring, ntc));
=20
-=09if (likely(igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)))
-=09=09return false;
-
-=09return true;
+=09rx_ring->rx_in_frame =3D !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP);
+=09return unlikely(rx_ring->rx_in_frame);
 }
=20
 /**
@@ -2601,7 +2599,7 @@ static void igc_update_rx_stats(struct igc_q_vector *=
q_vector,
=20
 static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budge=
t)
 {
-=09unsigned int total_bytes =3D 0, total_packets =3D 0;
+=09unsigned int total_bytes =3D 0, total_packets =3D 0, work_done =3D 0;
 =09struct igc_adapter *adapter =3D q_vector->adapter;
 =09struct igc_ring *rx_ring =3D q_vector->rx.ring;
 =09struct sk_buff *skb =3D rx_ring->skb;
@@ -2609,13 +2607,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_=
vector, const int budget)
 =09int xdp_status =3D 0, rx_buffer_pgcnt;
 =09int xdp_res =3D 0;
=20
-=09while (likely(total_packets < budget)) {
+=09while (likely(work_done < budget)) {
 =09=09struct igc_xdp_buff ctx =3D { .rx_ts =3D NULL };
+=09=09bool first =3D !rx_ring->rx_in_frame;
 =09=09struct igc_rx_buffer *rx_buffer;
 =09=09union igc_adv_rx_desc *rx_desc;
 =09=09unsigned int size, truesize;
 =09=09int pkt_offset =3D 0;
 =09=09void *pktbuf;
+=09=09bool tsip;
=20
 =09=09/* return some buffers to hardware, one at a time is too slow */
 =09=09if (cleaned_count >=3D IGC_RX_BUFFER_WRITE) {
@@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_=
vector, const int budget)
 =09=09dma_rmb();
=20
 =09=09rx_buffer =3D igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt);
+=09=09tsip =3D first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP);
+
+=09=09if ((!first && !skb) ||
+=09=09    (first && igc_xdp_is_enabled(adapter) &&
+=09=09     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
+=09=09    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
+=09=09=09if (first)
+=09=09=09=09dev_core_stats_rx_dropped_inc(rx_ring->netdev);
+=09=09=09xdp_res =3D IGC_XDP_CONSUMED;
+=09=09=09goto xdp_done;
+=09=09}
+
 =09=09truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (tsip) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
 =09=09}
=20
-=09=09if (igc_fpe_is_pmac_enabled(adapter) &&
+=09=09if (first && igc_fpe_is_pmac_enabled(adapter) &&
 =09=09    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offs=
et)) {
 =09=09=09/* Advance the ring next-to-clean */
 =09=09=09igc_is_non_eop(rx_ring, rx_desc);
 =09=09=09cleaned_count++;
+=09=09=09work_done++;
 =09=09=09continue;
 =09=09}
=20
@@ -2664,6 +2677,12 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_v=
ector, const int budget)
 =09=09=09xdp_res =3D igc_xdp_run_prog(adapter, &ctx.xdp);
 =09=09}
=20
+=09=09if (xdp_res) {
+=09=09=09total_bytes +=3D size;
+=09=09=09total_packets++;
+=09=09}
+
+xdp_done:
 =09=09if (xdp_res) {
 =09=09=09switch (xdp_res) {
 =09=09=09case IGC_XDP_CONSUMED:
@@ -2676,8 +2695,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
 =09=09=09=09break;
 =09=09=09}
=20
-=09=09=09total_packets++;
-=09=09=09total_bytes +=3D size;
+=09=09=09work_done++;
 =09=09} else if (skb)
 =09=09=09igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
 =09=09else if (ring_uses_build_skb(rx_ring))
@@ -2700,8 +2718,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_v=
ector, const int budget)
 =09=09if (igc_is_non_eop(rx_ring, rx_desc))
 =09=09=09continue;
=20
+=09=09if (xdp_res) {
+=09=09=09skb =3D NULL;
+=09=09=09continue;
+=09=09}
+
+=09=09work_done++;
+
 =09=09/* verify the packet layout is correct */
-=09=09if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
+=09=09if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
 =09=09=09skb =3D NULL;
 =09=09=09continue;
 =09=09}
@@ -2717,7 +2742,6 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
 =09=09/* reset skb pointer */
 =09=09skb =3D NULL;
=20
-=09=09/* update budget accounting */
 =09=09total_packets++;
 =09}
=20
@@ -2732,7 +2756,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
 =09if (cleaned_count)
 =09=09igc_alloc_rx_buffers(rx_ring, cleaned_count);
=20
-=09return total_packets;
+=09return work_done;
 }
=20
 static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
@@ -2797,10 +2821,10 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx(str=
uct xdp_buff *xdp)
=20
 static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int bu=
dget)
 {
+=09int total_bytes =3D 0, total_packets =3D 0, work_done =3D 0;
 =09struct igc_adapter *adapter =3D q_vector->adapter;
 =09struct igc_ring *ring =3D q_vector->rx.ring;
 =09u16 cleaned_count =3D igc_desc_unused(ring);
-=09int total_bytes =3D 0, total_packets =3D 0;
 =09u16 ntc =3D ring->next_to_clean;
 =09struct bpf_prog *prog;
 =09bool failure =3D false;
@@ -2810,11 +2834,13 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector =
*q_vector, const int budget)
=20
 =09prog =3D READ_ONCE(adapter->xdp_prog);
=20
-=09while (likely(total_packets < budget)) {
+=09while (likely(work_done < budget)) {
+=09=09bool first =3D !ring->rx_in_frame;
 =09=09union igc_adv_rx_desc *desc;
 =09=09struct igc_rx_buffer *bi;
 =09=09struct igc_xdp_buff *ctx;
 =09=09unsigned int size;
+=09=09bool eop, tsip;
 =09=09int res;
=20
 =09=09desc =3D IGC_RX_DESC(ring, ntc);
@@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector =
*q_vector, const int budget)
 =09=09dma_rmb();
=20
 =09=09bi =3D &ring->rx_buffer_info[ntc];
+=09=09tsip =3D first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
+=09=09eop =3D igc_test_staterr(desc, IGC_RXD_STAT_EOP);
+
+=09=09if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
+=09=09=09if (first)
+=09=09=09=09dev_core_stats_rx_dropped_inc(ring->netdev);
+=09=09=09res =3D IGC_XDP_CONSUMED;
+=09=09=09goto xdp_done;
+=09=09}
=20
 =09=09ctx =3D xsk_buff_to_igc_ctx(bi->xdp);
 =09=09ctx->rx_desc =3D desc;
=20
-=09=09if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (tsip) {
 =09=09=09ctx->rx_ts =3D bi->xdp->data;
=20
 =09=09=09bi->xdp->data +=3D IGC_TS_HDR_LEN;
@@ -2851,6 +2886,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *=
q_vector, const int budget)
 =09=09xsk_buff_dma_sync_for_cpu(bi->xdp);
=20
 =09=09res =3D __igc_xdp_run_prog(adapter, prog, bi->xdp);
+=09=09total_bytes +=3D size;
+=09=09total_packets++;
+
+xdp_done:
 =09=09switch (res) {
 =09=09case IGC_XDP_PASS:
 =09=09=09igc_dispatch_skb_zc(q_vector, desc, ctx);
@@ -2865,8 +2904,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q=
_vector, const int budget)
 =09=09}
=20
 =09=09bi->xdp =3D NULL;
-=09=09total_bytes +=3D size;
-=09=09total_packets++;
+=09=09ring->rx_in_frame =3D !eop;
+=09=09work_done++;
 =09=09cleaned_count++;
 =09=09ntc++;
 =09=09if (ntc =3D=3D ring->count)
@@ -2889,10 +2928,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector =
*q_vector, const int budget)
 =09=09=09xsk_set_rx_need_wakeup(ring->xsk_pool);
 =09=09else
 =09=09=09xsk_clear_rx_need_wakeup(ring->xsk_pool);
-=09=09return total_packets;
+=09=09return work_done;
 =09}
=20
-=09return failure ? budget : total_packets;
+=09return failure ? budget : work_done;
 }
=20
 static void igc_update_tx_stats(struct igc_q_vector *q_vector,

