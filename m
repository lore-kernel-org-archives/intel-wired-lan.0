Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBB606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=oqy1jRrP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEjRnMMW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4992D606CB;
	Wed,  4 Nov 2026 06:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVJhiJ687KRi; Wed,  4 Nov 2026 06:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 813FF606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774419;
	b=q2KDO05lXI7SifPsG6zz+M4SZiYOVcCcxv1Uqsh13xqVDoD016ykjEH5UgVZTMITwyiL
	 jIy2iWuFvLCQ0vjlK4d9/cs8IylfzoiOy8LSzVtI9u6qOvqHApYPo3Ad9aPhCZ401Tqp9
	 0Psp9UJckMMNzf4/O7/xU9vR4ypktNng1Xk0T4DLzMpCF+SO4msx4hMBn5CHhNoCCoWeZ
	 Mw/modecIm44AT4YTNgMUFBrwLZbe7uMzIRGRUiWGmLMD6lGM4G1ThPBzlNhGkencPI9O
	 bDVqKM4F2KC8j8WQv+WiDa2xgdoDqGuxOM2Iyb3rfoZZS5QSqE9jJMjwipS1CDLIuJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
	b=RidEm/gPoSJYGOzZ768oZpmyn6gsGP3DjEB2orLVxjFPrVqbOCRfsF8uCSLSp7qGvRyF
	 wwfRrWDt1C5RBc+oWNj2G01DggR4F/WoPTQb1zRpCroHG27Hc5EMbwdk1GDVQkpIGcv/L
	 G774MCzNcfhP2fstiHMvnAAOurfKjSTn2WPft2lXUsnpj1rxpMicchEjjL/RtSxwaw/Ai
	 xsU0KdL93t4BE4K5ZrHX0i95mJ6b4A6EI/EMmtZCOKtRFnEMW4cRlNCNjczV/BhLVl6NC
	 V+X+sKjcC5k1wrS+55DcA4ulxq34Ak25s97R7CCI0y2Ivbtu6WlMQgoSplq0UG5VIHw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793774419;
	bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=oqy1jRrPKCiJMgNcHT6ShTPqDCsL17h6T60B1c9hux5Pub/1J3Juh5XgcMhoncKBX
	 UKOzPJB+CeLrJGIH6PEV75i4UbSIMetqBBRkEbhbDHbWPKlfhh5u0/SZVzQDF3rdVg
	 VaWXk2STlbf6iDaiD0/QUbiQq150wWBKXV48GWqE4abilQym9nF4SoBv2Hxo1HNqsZ
	 2WKERjKAuLvZzklwYDmocRpMPUQEcsil4umF3auRaWcu43T1mboc2p31c8hCmm1tFm
	 61z8AhMyiIpLc2Aq2Qa1mIx+kN/bEbn0rLpVETozr1ctFuAsiLXgTEAq7Y6RzjGKoz
	 fwPTT/omP2qDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 813FF606C4;
	Wed,  4 Nov 2026 06:40:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A10F7932
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8746280AE8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id onABhZuCFYyQ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 06:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79D85809BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774410;
 b=AspthveybGU6t9WLoZa6MB/iJM3eV6s19stuND60CbuHdkfgZgV51WgEpTctl6GAnbo2
 aNL9+riKkd6fyJK+thWl+Pgu+HS7Y0CyMj2Hj2NijBDh5NoN/FJoh4TyENUFbflluLn3l
 Ugj1cmKIGDU2+19pydnGGT1YA3bdd1hQncP1K2GBICyTsdYdq/xocnSau2V6WLTVuOFZH
 +F5HSM7TdpiT8jQDKwz2TWsnrA+50Kq85+1aBXKm9qCrwm4eCnEbjgidAsMK+r13W7dk0
 jGCS6jj448h7KiQJ3wMDbz5QKxDvzcqRkg+HNJI0gv1i8z1DedLAIkAIsZLpFAixrlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774410;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
 b=SLznm0r+On9E+0x7XZTrdnKtg+fK5cGnkG/we8AWQUA/CTQeNc2l4hu9lKzhhDkvXxSQ
 yZB5WacOPl0VJBhmPMQr7gIHxsB/KrkMoHImzf0RcQZ9uA0Tm1vImBT4TX7Ps2T8XGrFq
 ftq/mF0cvqi06A5vvi/EjT+192rj0CJ6Hh5Todt12K9lE3CmZNv/+H9DpgqWCOSNMFYSa
 o3EViKJb+FGD9tHhhUrtoxCn2hyjEyg2verjJGPKhTV3cHwld4Po2/69ShwHkNdttd8Uk
 Z/S1EG2O2/UIvi5dSDd5QL/swRmWD1F7YqiUZ3k0f8+q76PWJaJynz5aZ41m1JY48Hw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XEjRnMMW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+tkusters.aweta.nl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XEjRnMMW
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79D85809BB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06E1060AAB;
 Wed,  4 Nov 2026 06:40:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793774408;
 b=r9O6Fx43/LLVgssO05rPAKbz60SE7M5MBIOrpgACq4hygau/S6ovDyY/xqmF2dLVTzHr
 OLrTcrMMWdDl30ld43cwJU58ZHn2oqQj3jOx6QOwIVbkJxlbmBIVjviJJvhaVVZJdDQsL
 b0ArSLWlF7tix2FEbC7hyl639wSAEHDIKA5DoUQ98owA0cI63Yk8HtmZQ651FtL9JzfJM
 ShCGwZ1x4E83Nf9oelebO6C2B/U0DhbjorIR9jyQrV2DogYmUGn6puhnV2CRb70NUbjPE
 mKX28Z0/Bemfte5HFhjv28wxP3/1PTiJTFTAC/Ikdt5L1FxB0+FNDav9FDUwcB8QjzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774408;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
 b=NRZHG+H2eLDKirNnnEBnRiPESXnZmPEC3NQK81fnMgOIWbdjNAhkX7OVR+oW+pXDRAaK
 87YwWAnPgSy1C+2XPYtd4moi3nrmTYeqm1n39f/1Furjx8i5uPzS62lRZNzzw6pfRLG2o
 btHLn3yA/RAJHhmsY92q+yzHM4lOFqlHZqu6FE5Ex9tgHPa/K1Wt9idcU5WpCcIKyns99
 hwF6RfbF2NLHA9eGlN0hhGsv8X4xwkNS6FgtLKt06LzJLbHovOZAiHqqIIgBD8dHEKMAK
 /f2gl8ZxMNm2u8UYUOR4qxp0yZfIyKh8Hsy9ajfxzUvPOZaoA+uJwJbFXYF4by0KjEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 72AED1F00A15;
 Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793774408;
 bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XEjRnMMW6Uv0bRCEO9oFy9u/vnjqj/DGLg6d/F4Wl3rhkWhrSQKmcvNmvppb+8SQ+
 kQDy38HoGhteblPbut1+U4TYg98GgtHjsPbd/DZO6dY8o/qIragCkugg7VouygYqKF
 4coEjDb7AnPGUeGHxLPrBS0WHe1J/xQXEM862jAGiu4vN1AjafkM+4y1qv80hjJdCH
 fOdl3HqmxA3Z3GmZ4kg/BF/GQvmrOFTf0Idg7hX8dJh+EeCn9vbb/ds9tgQ7148tIp
 5OLsWTDUVt1wEU/K0QmG8pU2Em2VkeUeIf9CQHd5qB8YMM4MKU+/qtnoarbZ08tTNW
 mYn1lTWVN/13w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 041ED46CC7;
 Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:40:05 +0100
Subject: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Sven Auhagen <sven.auhagen@voleatech.de>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774404; l=3174;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=MkRF1V1g+97bXmg40zLUInt45xqgM/uhRHUJw6aF5q4=;
 b=5tLdWEbOPlIseyGjFHZUz7pLUptV5ZFvFzMDviMEiMJn7X3oDd3o1LhwK8jL8bbyqnyzYkk/Z
 +2nppyaYkr/DjOJt/1/Vjo80CY3L4/Yrb5INyDj9uCuW0SVnCsbshDK
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Content-Transfer-Encoding: 7bit
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
Reply-To: tkusters@aweta.nl
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

igb_clean_rx_irq_zc() handles every descriptor as a complete frame and
strips the inline Rx timestamp header from each of them. If a frame
spans several descriptors, the AF_XDP socket gets its later buffers as
separate packets without headers. If such a buffer is shorter than the
header, the size wraps and the XDP program sees data past data_end. On
XDP_PASS, igb_construct_skb_zc() then fails to allocate an skb, and the
queue can stall on that descriptor.

The previous patches make sure that frames fit in one buffer while XDP
is attached. As ixgbe does, also drop any frame that still spans several
descriptors instead of passing its buffers on: free the buffers without
EOP, and the EOP buffer that ends such a frame. The state is kept in a
ring flag, as a frame can be split over two NAPI polls.

This depends on the previous patch. Without it, every full-size frame
on 2 KiB chunks spans two buffers and would be dropped.

Not reproduced on hardware, as with the previous patches the I350 no
longer splits frames in zero-copy mode.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb.h     |  1 +
 drivers/net/ethernet/intel/igb/igb_xsk.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0495c02544d6..6613ea0eedb8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -393,6 +393,7 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_TX_DETECT_HANG,
 	IGB_RING_FLAG_TX_DISABLED,
 	IGB_RING_FLAG_RX_ALLOC_FAILED,
+	IGB_RING_FLAG_RX_XSK_DISCARD,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index fb04df82272a..7b098069fff2 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -269,6 +269,8 @@ void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
 	u16 ntc = rx_ring->next_to_clean;
 	u16 ntu = rx_ring->next_to_use;
 
+	clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD, &rx_ring->flags);
+
 	while (ntc != ntu) {
 		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
 
@@ -390,6 +392,27 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 		dma_rmb();
 
 		xdp = rx_ring->rx_buffer_info_zc[ntc];
+
+		/* A frame should never span several buffers here, see
+		 * igb_xsk_frame_fits(). If one does, drop all its buffers.
+		 */
+		if (unlikely(!igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP) ||
+			     test_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+				      &rx_ring->flags))) {
+			if (igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP))
+				clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+					  &rx_ring->flags);
+			else
+				set_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+					&rx_ring->flags);
+
+			xsk_buff_free(xdp);
+			ntc++;
+			if (ntc == rx_ring->count)
+				ntc = 0;
+			continue;
+		}
+
 		xsk_buff_set_size(xdp, size);
 		xsk_buff_dma_sync_for_cpu(xdp);
 

-- 
2.27.0


