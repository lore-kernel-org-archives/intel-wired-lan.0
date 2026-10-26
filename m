Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F3606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=L46UbSpr;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=beLj96EI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDDAA405CF;
	Mon, 26 Oct 2026 09:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3RHyTP4uMP2; Mon, 26 Oct 2026 09:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AE37405EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006193;
	b=oNRA2Rr5pO4Mg3Xy+b67qZjWczsXJXlFwXHKXqs3uHLI71V8AZIOMZgwwSmd8xnGja0u
	 +oh439/bVjCGMKxzAa4mQvCaDt3cWrKhYrgSKX6npAl/X8xFPOJVMY7sIZ4ynpHcO39mz
	 My3qML9okZYzbtTep7/YOlcMFXoRGktQneOtvg6tTqnAr/8z87YSN6viCI5FRBdUJPrIx
	 oZ/P1j7fkLDS31pii2v2AJmKa2myPyxz8C/WUkE25OtwjJ62W1QTR8OMqO+NZek8g/uEc
	 yWzuc5yz+l34q7Rs5yOQJ+l+yxqwWvAY1VSBLujm7KvB2qJXL0Bed2eN8sCoDur47og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
	b=LBuXUKuyQ5R/xbvpSMLBgMpYZpNzr8MrEinpVM1S8CCzdmhzjkAtrvKk/Q2VVei3uwaq
	 bJkQeNGmOMdA1l1rjQ83e3lVCWlE6mEpHu8jOmZ8JOIW/v0nTWUJNMKkdO4HWCn6eiJD6
	 dhIKQvb23eR9swZwhuKE+fpE3HTChobniW0vxuFQvk9cydMT36/BDZk5+7+kMeIVB8FII
	 oW+JICWj5cwAM+9bwLjsI3/0SW3GjfB5SiC0Qpo25GBQir12pE0qbcI0+TsTZFfLsbpIV
	 JQYL+knZdY+4epO2gP7yo5XigKHRiTsxKyrTYYXxr9F453YcdfyxHq8CptlImkusLTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=beLj96EI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793006193;
	bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L46UbSprjyVuPa9aEKB5PzU4cWroODfvLSu8+IG4fV5QgU9TBh4kMkEMUTco3f5HF
	 NUixjS547wu/ZYR5VJxiJYP9GIWzg5dzeHnTEfPZfa0FlwPtBpjmdDHc9eM+ODs6rg
	 jioH2h2pIiayKYFU49OHgNQJHUtZs1jvUi9ZhxpC+a5dfhSbAH2idDPpQtdRMbuXLs
	 Oklxhj06pVlNkw+q6aZjlxGstjDb5KocOpW2NXbw5rfDZdc1vGLqbP6neD61n4SpVj
	 /x6cfl6FYdDu25EENZmwYxDOn+7Ah0Tp/9ijydxECE+e7ieF2+uv39TyeleJDe7TN4
	 qR32zguG9PfIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AE37405EE;
	Mon, 26 Oct 2026 09:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F454235
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219EC405EE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TrCdakZnoBbA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7D4E405CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006190;
 b=In6PVy7hFlMJXSHNUL9ZHk42e0M7Ar+mjlxRCEBTOBYmPMBQF29WEXSitKDaW8O6IPAi
 c2IIVn1kkRNhRVzxITJqCRBoDy9T4vsx2LGqz1y8rmfxwBqWyyZLncR74NyhmqeWtbQsG
 QSMVj7caaJaGMKR/MsUJWP53XzM9WumRtZ65IlOpktst2BZNRKV3+x/+p8YxLkar406KQ
 JMig/KpDpZeYf/WimnC2g5sb6rq/sbWr23I9Bsfc/cxxLMkGpNX6Ub/Dtviy//otx5mzW
 GSGn8wyx5QJmIBpDC+F1MrsYXUMrzbshKMIouF0QP4ktS3tVpOyX8q8FC+ZGWjtWlog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006190;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
 b=W5WAtGLb+If9xvMhPwCiJsd3l1Kv/u7LPgWk6GySffc5/R9YVJvsg6c5lmKmwtmmKZiY
 ci6aglzLuZZh0iq6FbPMzhsl5O5/T1BBXs2TuuMd8jozrrbk8vQ9NQIJQHlUsBrcJrcUp
 HegbO2Z+0apceQkl5Iedrk0U23/c0rTUU4zk3MUCUXHjh4FHB2Z0ua/jDwCDyThq7tzWD
 Co+wCG6Oia6Z7ZBa7Is29hkpbcAEWNX+8x5YiSEPI9cZ1zQ1E4YIHpGIOIrBXLB9rGNPo
 /nbMHnLArWnM551QUFSFXF5PHP0vr6z9Ws+HoNZQlChoNbep+qgl4oKZw5ltzglNpKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=beLj96EI; 
 arc=none smtp.remote-ip=109.224.244.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.119;
 helo=mail-244119.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=beLj96EI
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7D4E405CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793006187; x=1793265387;
 bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=beLj96EIW19JDsM2etulD9M/cG0l4KatJN5vP/dsT8gmPCa+1i4tQHY+PZCB/UKk/
 eJEQRYwqvjSpggu98rec1Lo4FBBj5VhyVYw0HAsJh+NEKOiwKva1T6lQhWAvfwT+Vo
 eSMIzEnZIIeMbUdwvBajMmfB4mJVVUkrOTa0HTIzLXRKVhmoaI7IFgfKqQZIDQpx1z
 CZX6A51yX16pcX/2BZQSv7aADMCD1fEcT4GZyMDjjUuMSeAE6qPatLgM+rWIFDlMFg
 q5mPWGkL52rwixPQQL+5C+Rc7EArIEd2PaqvZPZQNsd3yHziv56iFaN8wSX/LYsH62
 gAka4m+ml9K7A==
Date: Mon, 26 Oct 2026 09:16:19 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX
 timestamps
Message-ID: <20261026091549.605810-3-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6fa17044f218a9b5dc8a444b577e6cd4e46ef864
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igb_xmit_frame_ring() takes an extra skb reference for TX timestamping
before transmit preparation. For GSO packets, igb_tso() calls
skb_cow_head(), which can reach pskb_expand_head() with a shared skb
when the header is cloned. Commit c7d8bc3dd511 ("net: skbuff: don't BUG()
on bad arguments to pskb_expand_head()") replaced the BUG_ON() with
-EINVAL, causing TSO preparation to fail and the packet to be dropped.

For non-GSO packets with CHECKSUM_PARTIAL, igb_tx_csum() falls back to
skb_checksum_help() for unsupported checksum offsets. This can also
reach pskb_expand_head() through skb_ensure_writable(). igb_tx_csum()
ignores the error, allowing transmission to continue without completing
the checksum.

Move TSO and checksum preparation before taking the timestamp reference.
Add the timestamp bit to first->tx_flags without overwriting the offload
flags.

Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and=
 interrupts.")
Fixes: 6e033700887b ("igb: Add support for generic Tx checksums")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 31 ++++++++++++-----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index d4a897a8c82c..04c0053dbaae 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6559,6 +6559,21 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09first->bytecount =3D skb->len;
 =09first->gso_segs =3D 1;
=20
+=09if (skb_vlan_tag_present(skb)) {
+=09=09tx_flags |=3D IGB_TX_FLAGS_VLAN;
+=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
+=09}
+
+=09/* record initial flags and protocol */
+=09first->tx_flags =3D tx_flags;
+=09first->protocol =3D protocol;
+
+=09tso =3D igb_tso(tx_ring, first, &hdr_len);
+=09if (tso < 0)
+=09=09goto out_drop;
+=09else if (!tso)
+=09=09igb_tx_csum(tx_ring, first);
+
 =09if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09struct igb_adapter *adapter =3D netdev_priv(tx_ring->netdev);
=20
@@ -6567,6 +6582,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09=09=09=09=09   &adapter->state)) {
 =09=09=09skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
 =09=09=09tx_flags |=3D IGB_TX_FLAGS_TSTAMP;
+=09=09=09first->tx_flags |=3D IGB_TX_FLAGS_TSTAMP;
=20
 =09=09=09adapter->ptp_tx_skb =3D skb_get(skb);
 =09=09=09adapter->ptp_tx_start =3D jiffies;
@@ -6577,21 +6593,6 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09=09}
 =09}
=20
-=09if (skb_vlan_tag_present(skb)) {
-=09=09tx_flags |=3D IGB_TX_FLAGS_VLAN;
-=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
-=09}
-
-=09/* record initial flags and protocol */
-=09first->tx_flags =3D tx_flags;
-=09first->protocol =3D protocol;
-
-=09tso =3D igb_tso(tx_ring, first, &hdr_len);
-=09if (tso < 0)
-=09=09goto out_drop;
-=09else if (!tso)
-=09=09igb_tx_csum(tx_ring, first);
-
 =09if (igb_tx_map(tx_ring, first, hdr_len))
 =09=09goto cleanup_tx_tstamp;
=20

