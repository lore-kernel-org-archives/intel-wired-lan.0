Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBD606A31D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2OGy3C3y;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=QvX4DShW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9FC3606F4;
	Mon, 26 Oct 2026 09:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mYq_N8MhxCX; Mon, 26 Oct 2026 09:17:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45D536066B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006230;
	b=IUbGXPtB0DCytxCnIAqW367TG7KkXmcSZCLiQ0nAIEZ0Op8yRzdwaDwzsV/6Vy2/VF7S
	 HSCvjANfxOduXLf5KTXq2vit5mGuTclHxuezFqnSLgKZ1Nq2lGJ7rKGe2DGS0HriV90Ex
	 Y8kokd2mjRZjTbP88H/zOpWKXThHalQoIrSLAmHFJAPBAv6jDxBjlE6zngEGvxVnACMJ2
	 WJSOE2D5ETuOr+TWTVaSHKSdgz4MXDmNaQM9BqqvSpmrsW/uzjo7xgUVK7vd1vTP8v9lk
	 n8E/D5MgppCY8y8zBNVxv6QiOFPPt/p8pWbm+n7W2G2eL3U/FPLHmzvYb5Mb7q9o7Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
	b=o8GEq5SLF3MPSEZvW5Zzrx+C11C3L1JYDkta/5hy3pHetLf2MWe0aZEb6fk3OCstncPS
	 TJKFrmBiAJv2jeEJTqxU5AHRwLsT1LRwv98OEu6Hrvp13pecNZhbSRL6XMlr5ieFCA+pg
	 D/zoOunjZ4h4hg9O6kFEjZL4UI05FWOTbF+9hmB3efScr2B4Nywsfwx4ed7Lr0ltQmp5G
	 EVb40UDWzv2E3XEStedM05m2RTwPl3odd1mjTsXjJnCzMckVdGD987UaxScRXbcPTnDX2
	 muXOqgXDY0r6limrtDDp9TG5f33q6jdIanb2dts7wC+kXMuFWUVCc+asccOHHbzYx6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793006230;
	bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2OGy3C3y67xzdnRQhRmNB9Z1xqNdLp1RkJB60C23JcZZpAkLQgjR4aA/IUa2pTRSw
	 R26S5152eefBFlWHHugDQtjgJZ27h9cTsmG0pGNwEQGxiQ/RmNT4VYlbqaddjuCaEG
	 cvgsbT9gpQVtGmpAqhMOSfa8a7oVrDvgqaIxZF2PmdKtJwFEwNxl+XrQ3+HF7tJtTm
	 HieayyktUJ/GNg5ISKxCIu8QCPjsF+6J9wT9TnrMztDs68mpc9iW2MqxcDOeBE529H
	 h2PSv9yt7MDgL67kAQAFMmiuU+eZssGrtZZmcCkscOSR7arRnPGhtBr31avFampnyl
	 Y56/xATuzswRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45D536066B;
	Mon, 26 Oct 2026 09:17:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E43D7334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1AF080DA2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xu9h2Vu5UTyw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0971E80C75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.104
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006228;
 b=HkR2mqS7MffoJRnvsC3u/mDE2Gz5Dv5JTwEyyHsVKVN5m6CVHd5IZdydWoMShzaQxEXC
 zvmXCgoihLAdrGJ3EumOnzCTmYaZ5B0aOUY+bf4LFKBb9MrE1/ny3YaaO6I0icxT2cZ0W
 segFkcsOZt8klj3JAWVRlStZBPHDoqfwiX5LU40J6HoBctUtQ3aU1arfYBw6Pl8GAVEoQ
 f2FfZf1+yVdBkK1iXN+3VTR13nQDhUzOfg4sitPoF1xlzLtl6tSk4FLZ+4nDBQE/xbXHO
 +NXwmKUMGhz2VFdd3CFmwxJe/uOF5w4okzyePO4FCVRXoRT+irEAFjeoZory4zwQCbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006228;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
 b=qoe8X1oW0uVC87MrAlZ4OlXcg/IKpT+LvkxN0eFVtNcRDR37vXPw2+al+Hyzv8iUhRAO
 i3EqvmQOwP+jWhtadUUnK5nNZgD1khAJ/8Xtc+jo3vSFaekv7CEIgjqcecuPRHMKIasnk
 SphVvXuAdh/yClToY5CtHnxuGnhiRA/yDeOJZ+InlvgkvQRo0T85DoC/HvEDc1fruXYQt
 2jaGuWASlFht4Mh2C8Kx7vxnZUnOlMG6LSAI7CVuRR7cAVBxEMq2v7eNfJk4Ri1u5V0UZ
 rZ+uzRltZ3REpbcC9x4l14fnztgu6ZJ02YMsKdFgKvgHtic14beWhwUmttMkQOap4mw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=QvX4DShW; 
 arc=none smtp.remote-ip=109.224.244.104
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.104;
 helo=mail-244104.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=QvX4DShW
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0971E80C75
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793006175; x=1793265375;
 bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QvX4DShWiQlarzx63EuJ27qPSMsKXikWtn9c9MpVR9U5n42FrS01TPCmeZgBQeTgJ
 LhEgA3es/K2NP6rglcyosx6ml10jR8NXurF6X3rKcTsr2QyQ3gpvVOSpR/HD6AgzfV
 wihoUA6DTP21Ypgz6+mFI3DnfXBcw7yOCnskJcOewc5k1lSQxHxQBu+VIVMMqk9wha
 udWcm2JmsO2nfUmoDpBr7KbBkmK95JYACuFxSQoLNKV72RDBVsj6T6up+Ly1si/H3E
 yOwMnNNgMU2Gf7hFnPcRO9jJdBgJGkseRvhfRJFse8oJxLRxo65Ij/XhtBcaWY6Eat
 EKvxOfoRm+AIg==
Date: Mon, 26 Oct 2026 09:16:07 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Message-ID: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d33c929331c25b6f759b46fea624f64bcb228383
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

Preemptible queues require software padding so hardware includes the
padding bytes in the mCRC. Padding currently runs after TX timestamp
reservation takes an extra skb reference. If padding needs to expand
the skb, pskb_expand_head() rejects the shared skb.

Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
padding error path. skb_padto() drops one reference on failure, and
out_drop drops another. This can free the skb while the pending TX
timestamp still holds its pointer.

Move padding before TX timestamp reservation and use __skb_put_padto()
with free_on_error set to false so out_drop handles the skb release.
Preserve the VLAN flags in first->tx_flags when adding timestamp flags.

Fixes: 17643482e9ff ("igc: add preemptible queue support in taprio")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 39 +++++++++++------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..f1bf4e462a51 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1661,6 +1661,23 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09goto out_drop;
 =09}
=20
+=09if (skb_vlan_tag_present(skb)) {
+=09=09tx_flags |=3D IGC_TX_FLAGS_VLAN;
+=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
+=09}
+
+=09/* record initial flags and protocol */
+=09first->tx_flags =3D tx_flags;
+=09first->protocol =3D protocol;
+
+=09/* For preemptible queue, manually pad the skb so that HW includes
+=09 * padding bytes in mCRC calculation
+=09 */
+=09if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
+=09=09if (__skb_put_padto(skb, ETH_ZLEN, false))
+=09=09=09goto out_drop;
+=09}
+
 =09if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 =09=09     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09unsigned long flags;
@@ -1669,10 +1686,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_bu=
ff *skb,
 =09=09spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 =09=09if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
 =09=09=09skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
-=09=09=09tx_flags |=3D IGC_TX_FLAGS_TSTAMP | tstamp_flags;
+=09=09=09first->tx_flags |=3D IGC_TX_FLAGS_TSTAMP | tstamp_flags;
 =09=09=09if (skb->sk &&
 =09=09=09    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
-=09=09=09=09tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;
+=09=09=09=09first->tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;
 =09=09} else {
 =09=09=09adapter->tx_hwtstamp_skipped++;
 =09=09}
@@ -1680,24 +1697,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 =09}
=20
-=09if (skb_vlan_tag_present(skb)) {
-=09=09tx_flags |=3D IGC_TX_FLAGS_VLAN;
-=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
-=09}
-
-=09/* record initial flags and protocol */
-=09first->tx_flags =3D tx_flags;
-=09first->protocol =3D protocol;
-
-=09/* For preemptible queue, manually pad the skb so that HW includes
-=09 * padding bytes in mCRC calculation
-=09 */
-=09if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
-=09=09if (skb_padto(skb, ETH_ZLEN))
-=09=09=09goto out_drop;
-=09=09skb_put(skb, ETH_ZLEN - skb->len);
-=09}
-
 =09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
 =09if (tso < 0)
 =09=09goto out_drop;

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e

