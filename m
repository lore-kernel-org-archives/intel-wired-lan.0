Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F52606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1mBPbk0l;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=GRxeK2Zz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2210F80DBC;
	Mon, 26 Oct 2026 09:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZCthgbpwDR2; Mon, 26 Oct 2026 09:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 684D180DA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006184;
	b=N/Mf8AC4AyeHrGnNR7ziazY9RP7hOWn75q2bvlZDs3pMOfsH8hexMKLeOET9iTz5kCyS
	 KAQoIJG5eJra+7CNsTQrYP+avdIJcScwXX8nBaJBRUfTzwA5n7L915K8P9feVIS/+UhRB
	 fololt+jmzq3K7jBO9ine+rnT8QC/fnrE68qNGj6hDpr6sb/kjNPncvI59Qz581FwBkY6
	 f7z84g70SaVGHunKQ/eY+SuI8ZCI+j0XPE0TrzIK6AO0Wc+To3Ej+CcVlaV43DirYXDZz
	 lcEwm3LdxcTzvrdYdZsDgiwTheE+6pOF5ChP1zacOkoP6qn7LfXLleleBvPCLDDKrig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
	b=CG17cRK8qoXCyZUhHXkKeSxsU/ecWlIgwuEPyf4sOKAtdSDZhyS7eiZDzcISNrj1aBjz
	 1dY1hZMksg8E9y1QqP1UQhr6960tu8TkHSEyFgYAy3Ydxb6XbmqxKrxEyefM5hxNckuEa
	 V1Ngalui6GHnDYLMr5cznL5aUlhiRGJMd05XEdp6JWZLOZebOSNrLGDX4sN9jCpS3mHdt
	 laKqXexTz2qbgbEnOdHJY1Xsls46bIewdViWTDA+h7ArD0lmg9dGlf0sOoNIdwZRURqmw
	 9UN5wEyYaDQMpJtvdBd6JD6d+pDZ4+v7tj1LKrMLMiWhNCay89uy9qDuxN+/uNIFE+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793006184;
	bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1mBPbk0lj1iar1xJ2sEKM6Pexg52luo8GgWPGkH1PNh6Vi5tbf17wPLSRAHYPZE/3
	 HXs5Jz1YMoObV4Yv1X82HRDEXF4OjrcxAEB4+1Nmrw98IRh2p6/7HOvm4BfoCmiHlM
	 2lAoTxDff+5DM193etjUw5CP9ylUJCr8/GEIzGRgxroDcKsm/ZdRkCVd3KM9/KD7nd
	 9MKqe8Ql5NjzYOvb2Xcvu2Ay6MCXf3wc9cU/MopEQvQPHc54SGjaj2h7U+R3jaCVkT
	 gFbm+1QFkMUEBQyVhdjBxqDq+fbJYi2QJqHYCCeDYZKqSCh03nd1MlqcArNdH8FfWo
	 0sIMkGFCdDiUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 684D180DA4;
	Mon, 26 Oct 2026 09:16:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3049334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9434D4004D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IieMqzoTcI4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF8C240049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006181;
 b=BhXU5jwApjYasDzT3m5Qp3MDHfO6SPKIdwzuY8eh4LS4fSDxp/zCryzn5bZyVZJlzzSP
 6Al4JGngIkmxvpvSLYHUKluqkX9+2gqucigZXLp/as6OfuXHNnf4i1GUVGQZ+JYWl7TMs
 KVOCtXu5zEfz2bs+kyAx/sgQdiI9WWmZRFiiOefRSozunDcWiRR4y7JyPwMQ4FssVJhNv
 ChPHq8XwnhnquvPe8VGFUTTlWGiBU3w8nD2VEh5C6cxXj7q4FxaHGJcTkdXOwlPRxA9Ha
 tTaiC28Lhk2WvnQhZfMyfah9WTAV8EeCayN51Go48y6UNziz23kvmNNqwvR2L778xxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006181;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
 b=Vab6582f9RZbB/RjpcnhQAXwmMjwShXWJn8GlD6VwH2FGxyOX5i2cl0AeCU6AOyk2I8v
 ddsexnXhPX7Yz3xFuKny8M12kSuTNGVdv0KwaNlceHWaH5gOY86rn8tqpwbKsFdizRUlW
 CnGn4/H7YJwnl7FnSZVqrYvk1n3Bbz1At8oJRuNGdGQlM4P3OKplNrFxJ5+6yOlvya5og
 PsGJHMmeADlxVz3U+R1MvWfFz4s3kwHaSFRwHvYc2dIXH2YApw00i6nLiMjPG6uG2BFia
 lkKr7L/M/ky+SzQ2yh03ZVQNru4aigLmJBZGfOeRYOShtUXzrpWULGu1u5FZe+xuNnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=GRxeK2Zz; 
 arc=none smtp.remote-ip=185.70.43.96
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.96;
 helo=mail-4396.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=GRxeK2Zz
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF8C240049
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793006177; x=1793265377;
 bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GRxeK2ZzxrecvFfI7aBG8Q7p17VGKybNmD9OjXLNnTn3rIb0uiooltYWkE3pMFShI
 y8sATr8/nVPBpARccFC8ROXDIuG6NhzPd2wyXquc9FdUIYPn68ta0z2JCn38u/3hml
 ABUfXD0U+Nxu5cCRo1fWaMbBdfvyfb8THvc88oDnCvBj4B7aksvihJq28EtLWAbyyr
 wP344Ux9jcx/u6IXni7//2D0oJJUbhfS6+2CGAvhHb5tWWr9nxBfdZCyxN6TX5obGm
 m87RZ/ywdBGFKxG+5MZEz/hw+UGIXMsBfbArEsedeA9ZZVdSAo0bdfQ+E/HKGlX8sR
 RPrekvep89v3Q==
Date: Mon, 26 Oct 2026 09:16:12 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX
 timestamps
Message-ID: <20261026091549.605810-2-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d27c8f97c5a8bd6919b770c2879e25d6acf1a237
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

igc_request_tx_tstamp() takes an extra skb reference before transmit
preparation. For GSO packets, igc_tso() calls skb_cow_head(), which can
reach pskb_expand_head() with a shared skb when the header is cloned.
Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
preparation to fail and the packet to be dropped.

For non-GSO packets with CHECKSUM_PARTIAL, igc_tx_csum() falls back to
skb_checksum_help() for unsupported checksum offsets. This can also
reach pskb_expand_head() through skb_ensure_writable(). igc_tx_csum()
ignores the error, allowing transmission to continue without completing
the checksum.

Move TSO and checksum preparation before TX timestamp reservation so
the extra skb reference cannot interfere with either operation.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Fixes: f38b782dccab ("igc: Add support for TSO")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index f1bf4e462a51..cd4c9815fca7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1678,6 +1678,12 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09=09goto out_drop;
 =09}
=20
+=09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
+=09if (tso < 0)
+=09=09goto out_drop;
+=09else if (!tso)
+=09=09igc_tx_csum(tx_ring, first, launch_time, first_flag);
+
 =09if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 =09=09     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09unsigned long flags;
@@ -1697,12 +1703,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 =09}
=20
-=09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
-=09if (tso < 0)
-=09=09goto out_drop;
-=09else if (!tso)
-=09=09igc_tx_csum(tx_ring, first, launch_time, first_flag);
-
 =09igc_tx_map(tx_ring, first, hdr_len);
=20
 =09return NETDEV_TX_OK;

