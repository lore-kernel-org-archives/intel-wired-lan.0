Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D9606A336
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xAuA+jEU;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=avh7A5Ax
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0027040305;
	Wed, 28 Oct 2026 08:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJA5bo57oNWo; Wed, 28 Oct 2026 08:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39DA3405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176526;
	b=p10oArVpu1EJydGtRRcUdY1UAdXRplz6mPbdOFwDk5mXI7dvN4x3/7KnxI/2kh3ZgpOE
	 JZGfOR3GO17nx2YEFfUfFAUAIHAdOfqn7mi+We+FT1Ez1M/Lknho41/brwjoWS1mcnbUG
	 PI6ygr9YD7+RxPp+NaDDwXzJpYz753m4semfFzYk1BDA8MeQ5yQfoq4LQlEbpgAA+P7QQ
	 wj/P+0v5MY/1O8N8n+tKOf1ejqXstY/hwi4FNVXutAPqTWXk6gxra5pZTwCtFY4lz2iCY
	 D3c5RgB/AOeY0cAerNRjawXKNxHU1TGGC4fO9/fpkDg7d/rfluRi/kA/E2hN8NVQt+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
	b=pBOEvBN7+23Hu2B7nHn4Urssj46l/1A1Wz+JMyAgg7fEijZHgG+/f0RJuog1XpdxPf+i
	 6SwNggEfOnB1V2Lvnjuq8o/yqmIGp6MTh8OsS5ZzqMd0+i63ZQIn/TU3QuHwSVmC4KWak
	 zn+eyZxFcHcHsoYRf8Y/bDWG1SdIlIrfIrl8KpXaBVi8EODcyP5bjLZVJ1W0W319c84GG
	 fG9lq4TeUS0Mh7QZXmk32/3y93wvyvdYIiiMDC5ParEhs3GTnql81+26+5UI9wxlVpXd2
	 WHAMrao4XZgw64qMnLV2tx04szjk/qYs00eigc/3TYOZdLEBrFPDWCNzOGJCoBtc4ZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=avh7A5Ax;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793176526;
	bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xAuA+jEUmfmRvZBLO/uzWlxlgj6We32lnybVZJR46iLUImnGGR/lDdQgSymqzhmzX
	 ZWfrEkMWCsKPqyYM8QTaXTYOQP4sKCWl0sP9LEw+lrGzBzNLCl55R0ovxp9dNz4Oe/
	 5eZq3Zk6TE34E80w4PvIjODx6JOuREN7aUI2Kix0rCcA6NEhRDbz7+xxEvgQvbs0Qo
	 j2GaJXgaJX2QavkerEUWq/eMiYXQIVENk+ct3/9DFQdJE4wrRUrU3XCbWgVDxNLDyc
	 RaiUknCkLfdd8PWY2cB9QP2Izew2arYcf8pk7zs/6dNSAsi0cZrGAjzQOkCy1IyYNd
	 3/2yMqu4olJzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39DA3405E6;
	Wed, 28 Oct 2026 08:35:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59E78972
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B95F405E6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmpTUYyLP28A for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 08:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E17B40305
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793176523;
 b=VMIDiezCWhMjKZT0jXcAqxJVOR3fzazrgg7GBjjjTg2WZGHF3cEL8M5aUgFj/zHUj/Zx
 Z6K/3nIexAB620xwT0dIB9eb6xs3bq1XZ2ZGrpgi1KxNm4TBSW71DqKNIYKEEZS+Hbkgl
 ElognmMHJA83HhbCGvkU2Gf5BgzMPTiDMZqvM6sc2M54xL1Q/O8mbyzXK85lWGD5dl+PK
 0NxjFTwgYPTm1oVX8IvYz3PrIOhN6Phd/+SBqbKIgoUoMuaGRG4infdYXBiDKdD9IRwPO
 FE250/7laZwCzITO329O3VH01k7MCOhW7gvj1a9mLN0DUiAY2FfzLj8dCqInQr+Uzxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176523;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
 b=lY7iIG7UuS23KKZd3bbyQZct2aaaaEXh6JUiuLnd1j7fapPMg/kibQmAWqZX9yGTsdds
 eX9oIT0jFpMG2ZlRU9RYsfrqvb3JCaHK11ZW93s+E7KPNcDO5MNCgeVO3ro6JDpvLheZ5
 9vqYq9E8jo1A9kxEnS8YJ7Roh+ElMZh9RJlV5dEaJ4YawMyeMXPBBqwvV+Cudq4peXpDv
 v0VKg5/w5XR+ZQWXghlRm4jtfILEdbejkUcxgeMlBrdFvY99Nw3uR8O6DwdFxscLQUzzY
 nl9H0pPOLKiwF0wvK3IyWIlfT8hH1bTyDR4v49pH9eN1tNKyIZugX1eOMPKk/EcCA8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=avh7A5Ax; 
 arc=none smtp.remote-ip=109.224.244.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.20;
 helo=mail-24420.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=avh7A5Ax
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E17B40305
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793176519; x=1793435719;
 bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=avh7A5Ax0jWQ66VAFqlx/uTUK5s7ru3RsqJ+yVCJcFAx3EB0LpRvXfcZJr6EgFqcB
 mTQvvo7znYeGaPbzG/9FRrmaTSTKXHZzLfs9QHPaUMX/KA8NHiCDW/GHmKtoOpjAmX
 2i041iR13+F3x/KtPjsevsTYkoFGCx4X0G7hE0JK0jHkA91eCDCQDiOVnxmmAzN2Hk
 K/YT3r52EMgWFF0tOVjMV8886NxSWpOEWyT55Zn96epFm9arB6+NSbR0+de54p9gZP
 7Q9Xhit8EN7YdygrGJRPcYaCoO9y4NG3a0R5iHXcaQVnY8nM0HobZxE5dBHKzstQO8
 Z47wZFxjynLmg==
Date: Wed, 28 Oct 2026 08:35:14 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com,
 maciej.fijalkowski@intel.com, andre.guedes@intel.com,
 aleksandr.loktionov@intel.com, avigailx.dahan@intel.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 2/2] igc: fix AF_XDP receive buffer size for 2K UMEM
 chunks
Message-ID: <20261028083344.3047350-3-p@1g4.org>
In-Reply-To: <20261028083344.3047350-1-p@1g4.org>
References: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d759728150bb8cbe67e82d639351f824e9829844
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

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

SRRCTL.BSIZEPKT has a granularity of 1 KiB. With a 2 KiB UMEM
chunk and the default XDP headroom, xsk_pool_get_rx_frame_size()
returns 1792. Programming this value truncates the hardware receive
buffer size to 1 KiB, even though an MTU-sized frame fits in the
usable UMEM area.

XDP on igc is limited to MTU 1500, so configure a 2 KiB receive
buffer for XSK rings. Limit RLPML to the maximum supported Ethernet
frame size while XDP is attached, regardless of PAGE_SIZE, to avoid
oversized frames spanning descriptors or exceeding the usable UMEM
space.

RLPML is currently programmed from igc_set_rx_mode(), which can run
without RTNL, for example on an IPv6 multicast join, and could then
use a stale XDP state. RLPML does not depend on the address lists.
Program it from igc_setup_rctl() instead, next to RCTL.LPE, and from
igc_xdp_set_prog() while the rings are disabled. This avoids
netif_addr_lock_bh() usage.

Validate that the XSK frame size accommodates a maximum-size frame
with two VLAN tags, FCS and the optional inline RX timestamp. Check
against the maximum supported XDP MTU, rather than the current MTU,
which can change after the socket is bound.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++++------
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 11 +++++---
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/in=
tel/igc/igc.h
index 17f213cc9..ad1062f85 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -765,6 +765,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw, u=
32 offset, u16 *data)
 =09return -EOPNOTSUPP;
 }
=20
+void igc_set_rlpml(struct igc_adapter *adapter);
 void igc_reinit_locked(struct igc_adapter *);
 struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 =09=09=09=09      u32 location);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 41b293dc1..6b418dc71 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter *=
adapter,
 =09ring->next_to_clean =3D 0;
 =09ring->next_to_use =3D 0;
=20
+=09/* igc's XDP limits MTU to 1500; all XSK RX buffers can use 2kb;
+=09 * RLPML limits the receive length to fit after UMEM headroom.
+=09 */
 =09if (ring->xsk_pool)
-=09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
+=09=09buf_size =3D IGC_RXBUFFER_2048;
 =09else if (ring_uses_large_buffer(ring))
 =09=09buf_size =3D IGC_RXBUFFER_3072;
 =09else
@@ -830,6 +833,25 @@ static void igc_setup_mrqc(struct igc_adapter *adapter=
)
 =09wr32(IGC_MRQC, mrqc);
 }
=20
+void igc_set_rlpml(struct igc_adapter *adapter)
+{
+=09struct igc_hw *hw =3D &adapter->hw;
+=09u32 rlpml =3D MAX_JUMBO_FRAME_SIZE;
+
+#if (PAGE_SIZE < 8192)
+=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
+=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
+#endif
+=09/* igc's XDP currently does not support jumbo frames. Limit the
+=09 * accepted packet size regardless of PAGE_SIZE so it fits in a 2kb
+=09 * XSK chunk.
+=09 */
+=09if (igc_xdp_is_enabled(adapter))
+=09=09rlpml =3D ETH_FRAME_LEN + VLAN_HLEN * 2 + ETH_FCS_LEN;
+
+=09wr32(IGC_RLPML, rlpml);
+}
+
 /**
  * igc_setup_rctl - configure the receive control registers
  * @adapter: Board private structure
@@ -874,6 +896,7 @@ static void igc_setup_rctl(struct igc_adapter *adapter)
 =09=09=09  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
 =09}
=20
+=09igc_set_rlpml(adapter);
 =09wr32(IGC_RCTL, rctl);
 }
=20
@@ -4117,7 +4140,7 @@ static void igc_set_rx_mode(struct net_device *netdev=
)
 {
 =09struct igc_adapter *adapter =3D netdev_priv(netdev);
 =09struct igc_hw *hw =3D &adapter->hw;
-=09u32 rctl =3D 0, rlpml =3D MAX_JUMBO_FRAME_SIZE;
+=09u32 rctl =3D 0;
 =09int count;
=20
 =09/* Check for Promiscuous and All Multicast modes */
@@ -4147,12 +4170,6 @@ static void igc_set_rx_mode(struct net_device *netde=
v)
 =09/* update state of unicast and multicast */
 =09rctl |=3D rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
 =09wr32(IGC_RCTL, rctl);
-
-#if (PAGE_SIZE < 8192)
-=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
-=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
-#endif
-=09wr32(IGC_RLPML, rlpml);
 }
=20
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/etherne=
t/intel/igc/igc_xdp.c
index 9eb47b4be..a0f1ecb2e 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -34,6 +34,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct =
bpf_prog *prog,
 =09}
=20
 =09old_prog =3D xchg(&adapter->xdp_prog, prog);
+=09if (if_running && need_update)
+=09=09igc_set_rlpml(adapter);
 =09if (old_prog)
 =09=09bpf_prog_put(old_prog);
=20
@@ -69,11 +71,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *adap=
ter,
 =09=09return -EINVAL;
=20
 =09frame_size =3D xsk_pool_get_rx_frame_size(pool);
-=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
+=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2 +
+=09=09=09 ETH_FCS_LEN + IGC_TS_HDR_LEN) {
 =09=09/* When XDP is enabled, the driver doesn't support frames that
-=09=09 * span over multiple buffers. To avoid that, we check if xsk
-=09=09 * frame size is big enough to fit the max ethernet frame size
-=09=09 * + vlan double tagging.
+=09=09 * span multiple buffers. Check the maximum supported MTU, not
+=09=09 * current MTU, as it may change while the pool is bound. Account
+=09=09 * for double VLAN tags, FCS and inline RX timestamping.
 =09=09 */
 =09=09return -EOPNOTSUPP;
 =09}
--=20
2.56.GIT


