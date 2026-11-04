Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E8606A32F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6/8t84vS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHVNzF4f
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867C7405C9;
	Wed,  4 Nov 2026 06:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pM9GynzAIRG3; Wed,  4 Nov 2026 06:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D0A640607
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774418;
	b=pooWlcPJxjfZUVQeXThs9kOjQWeo63tgj8tchRRvwXsBf9Mn+sieEp50WEBmlpV9Sg6g
	 GoBsfEtOB2YM5VX8jyPAucaWfjFFgJXLf+S3O5zFwRjB+yZo4s4ujN5lnLcBufyQTXOs2
	 FJvIe38z0Fb9T9KTZ1IjXxDN92yJTw11dju5IHzSV082tLiMCpS5Y6t0xqCvNk6TVYukG
	 j5WuTUjICoHtZyxiOkV/dkq+OnQUF01MfYFm4qir2hNRFTdLGvcfQNarGrR4bL7RCifin
	 efdi20rpN8vL/pP42oIP0z7QihJL1yOk6REeHjtXAfR6xrmXjfn9Ve2Q7vsO6K464ow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=0M9qnpPhOhCS0OHr3LGUVqA5/n7UzIomIqhvLOkAZgI=;
	b=Dt5qK+CjncwulnsfB4zXzM45f3AoKmlMvdeZJeD9Lixz23QeiTdY1pArgFxYWMM4SGrf
	 8nMRMmP3k9Rnp6BHsVUFtfUqbrOoqswTprV7hz3WPzqh4KqjT4SM8cOt6Oxtp2j9es2gF
	 ehOc4Hdcq+XaqXqQ27yF/bQgXimsS2mQq1MIE+EdBl0s+Yed65V+asYSWPyl1mKGOPM58
	 EcuCf9qAEX9Bgm8cS8eLzPOhjsRAxmSP4jRxrWaIUU8Ez8pQg/GMrh4AnDxvTx6u6YbhY
	 8vRWHydJ0M48jR7owaVzjVcw07urGcEhsp2upBN6u0K0Co1PqIIerUPMZr/nq5ZheTg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793774418;
	bh=0M9qnpPhOhCS0OHr3LGUVqA5/n7UzIomIqhvLOkAZgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=6/8t84vSmIXuWhV7FcA5YiS3MXwikbjZ88bx6Anxbgg8WQ+V9rfDPn9SXId2urwLW
	 4darRSajMnOmJjzyG7LJx4QXK4ylvfRAkL8LICq3rSvqv/D2K5EfQBxkNlHnP5mEAv
	 iriGHHL8wozAJjCx4oocKeseJ5XvSY9+AwPzdPUh3Fntt072yaHtGeF2Sx2PdjfP73
	 7hk4/sP5JBYwlFXIq97kvi8XgR21L7WaSzKPG5Ni15Hxlp927Opgf+Q3QfaftF7OIC
	 p5caUacMraQDExNUGsMmM73G+asvATIxhoQb9d3BgFfKf599x8U6bTA3eCqfwEDXgL
	 x4btmxTaVaGog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D0A640607;
	Wed,  4 Nov 2026 06:40:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DCBB932
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FC374004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnNeGZWXfjwy for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 06:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1916D401DB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793774410;
 b=WcKpieEdL2rRc39GE5yxa4MTj4sYEoXG2TeOwdUV8+wgZVFF0ZDQPfXxgaQfiwtMmIZ9
 SgsiyPAXu2dVlHzIk5TMadfAI1HtSWo0Kq1se/+0xSaMBu2Ihth8UpmSR/HqK9hZ9vX3Y
 CLjfvrVeuoOQbB4Hn1ELNgoeYK7QTD9VT/wVYC8/rVecqyyYFk2nuk11J3QmG5XQIvcOK
 6HVvHSYmNWEkksGf69W82gWPk3QXgjAAuj3b96eqxtpIveKVjCVAgcce3WDdETEcAw1IM
 sivRgdxQhR4CloCC+naRGzPmTFAVBQRv+0KhA+Dw8KZ+jxK/ja52sVegxBjyLWPlzbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774410;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=0M9qnpPhOhCS0OHr3LGUVqA5/n7UzIomIqhvLOkAZgI=;
 b=iZyQiPj85+upm27CY77AHVzIOsNmW1aoEYBLxRGmzNXD5rSUsfTaLUvi6g18fiGdNl+M
 Y94O+Eni1wG76LYmw9drOA4jNGBYYj4H0omExtLrlPMMegEJ23ccGdXem67Tj8eU/7NaD
 /qc/QJJnSzpZlI8RPseh+bhklJ6X7bN1j5IJnvyolAy8f/orQizvpHR4xWtQpuwfrhY1y
 ZDKEnxxGOTRQd/fh0ZSNt3tZVUgjJhs1kTrGk2PiJES+bF8URs/ScYTOrQq7MEIXe4qT3
 qts6rRjE+u4D5e+r83SG4oLCrQejln1MxBcAhv84mdGVW2S29XN084kKnS3JqS0J7+g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fHVNzF4f; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+tkusters.aweta.nl@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fHVNzF4f
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1916D401DB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 06:40:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97A9060D79;
 Wed,  4 Nov 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793774408;
 b=zB7e0hOhf692eaCmTJWRXuzQBNVw1sWfSfKfzE8WlAHAru/hLq1g9U9zFAnqJMKhLmiA
 xCqwIlZwIxOjH1QHLB59BBkQIQGFOLonHnul4a0A0rze3qHaXm1658wl5luzpYieOv+s3
 uh+se2Nu3YuUwThHhIyTPKTbVgyvRTwfchTyLvgTw8/3vHa/IUMoSXeA8EIoi4icZPTll
 cNrkuga0CGCaFXJXkB4k/qr+ScfB10hDMGvniE8IjOH0SccC/DLe5BAwuVMzXED9Vq5Rx
 jgpCkHUsdweyipDLv5Xcd/9XfSlEOsxmfLK71ci/TdyYYu1pCuKQVRUzDI30k7JGOQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793774408;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=0M9qnpPhOhCS0OHr3LGUVqA5/n7UzIomIqhvLOkAZgI=;
 b=amzwbmS1PgyPl7l67yeXVvZ07q3NKU2To1dRYEvwNmH0c7cov6jOfbmd+4MKjNE9UYtE
 cNu61xPrXA5uc0kDlXjIVdyzycHqjQV4ygcyL6HX5z5UXQf3HGmnH9aJ/ApJRo7p8nThk
 yFRpaHwRuE7NIe779oZ5nrEhQiIX6PgTRQp2BjGinaj87W7a/QUx4rctSNgYxqHK2FQfh
 0/EB3uNqR/U6xfenm58AouVWqKGJsxDX0Iq7a8NkQOkWemHH8uN6c/dNTdX28JQRuMKI+
 618819jfoE9o7rP9FH2RhGZTrAfSvm3iNihhWPxko/vdvrqt2UN7xuCzrjGhZSfxr/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 654701F00A02;
 Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793774408;
 bh=0M9qnpPhOhCS0OHr3LGUVqA5/n7UzIomIqhvLOkAZgI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fHVNzF4fdUymVWdyRggZ9TxOFE9KFc4LOjnBMqk0d+NpPCzZ6oTVW4njmjUUsLEX6
 WvdvAoSJ01/NAthnPNh/93O6ap4wjvMjqUnnadxIWKRyIw99cyfofjbnCJSCLMK3Xe
 790SfsaKiV62Y1uppKRVOcloc1G0eazV7xTSI9+9/Yy8VHwyUHlJSLkmnkwSwZkOWz
 ggebj37NKD0gKR6W/hDOUl6JxQUrkISYdq5LZx6tiQ4bIqun8BRT+R/9TFj7HKouqe
 lOnSzLkSm4Qv8CyGeRjopC8Ln7Tgm/PelzSsWN9MaWoWGgd4NtfZQchp085f51YZ0N
 NBo+LBKQnxNng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EA55A46CC3;
 Wed,  4 Nov 2026 06:40:05 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:40:04 +0100
Subject: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774404; l=7054;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=9KCsF2JdSscOWYhqwzpXNPqHFCXYoHVlmj1GZ5y3NZc=;
 b=80bromS/yvbSm8AKZHBEd4pgAkBuYNsErV25+AMEYW2CH/xvKCg9SErQk9V58j0RTQ71RboEC
 rx/jJX7ODvwDYNllAto6/tphrxMERkjaepuuvel+RpL2sjeWVoWg01G
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

SRRCTL.BSIZEPKT has a granularity of 1 KiB. For AF_XDP zero-copy rings,
igb_setup_srrctl() programs xsk_pool_get_rx_frame_size(), which is
rounded down. With 2 KiB UMEM chunks and the default headroom this is
1792 bytes, so the hardware buffer becomes 1 KiB and a full-size frame
spans two Rx buffers. igb_clean_rx_irq_zc() handles every descriptor as
a complete frame, so the AF_XDP socket gets such a frame as two
packets, the second one without headers. With Rx timestamping enabled,
the timestamp header is also stripped from the second buffer, and a
short final buffer makes the size wrap.

Program the same buffer size as for the other rings, 2 KiB or 3 KiB.
This depends on "igb: do not let XDP frames span more than one Rx
buffer": the receive length limit set there while XDP is attached keeps
the hardware from writing more than the frame plus the timestamp header
into the larger buffer. Without it, the hardware can write past the XSK
frame.

Refuse an XSK pool whose frame size cannot hold that, and an MTU change
that would no longer fit a bound pool, also while no XDP program is
attached. The current MTU is checked rather than the largest XDP MTU,
as igb allows XDP up to MTU 3030 and that would rule out 2 KiB chunks.
A pool that still does not fit when the ring is configured, for example
because its queue was hidden by SR-IOV during an MTU change, is not used
in zero-copy mode, see igb_xsk_pool(); its Tx then fails with EINVAL
until the pool is bound again.

This is the igb counterpart of the igc XSK buffer change.

Tested on an I350 with xdpsock from bpf-examples in rxdrop zero-copy
mode on one queue, Rx timestamping on and 1514-byte frames from the
peer. With 2 KiB chunks, the receive descriptors went from about two
per frame to one per frame; 98-byte frames and 4 KiB chunks were one
per frame with and without this patch. At MTU 3000, 4 KiB chunks
receive 3014-byte frames in one buffer. A 2 KiB chunk pool at MTU 3000
was refused by the new check on the 6.14.9 test kernel; current kernels
already refuse it in xp_assign_dev(). There, with 2 KiB chunks and the
default headroom, the new check refuses MTU 1751 to 1766, which the core
accepts.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb.h      |  9 +++++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 28 +++++++++++++++++++++++++---
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 19 ++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..0495c02544d6 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -856,6 +856,15 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+/* XDP does not support frames that span more than one Rx buffer, so a
+ * frame plus the inline Rx timestamp header must fit in one XSK buffer.
+ */
+static inline bool igb_xsk_frame_fits(struct xsk_buff_pool *pool,
+				      int max_frame)
+{
+	return max_frame + IGB_TS_HDR_LEN <= xsk_pool_get_rx_frame_size(pool);
+}
+
 struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 				   struct igb_ring *ring);
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cf9911137bd3..b286adedad5d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4833,9 +4833,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
 	u32 srrctl = 0;
 	u32 buf_size;
 
-	if (ring->xsk_pool)
-		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
-	else if (ring_uses_large_buffer(ring))
+	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
+	 * frame size would round it down and split frames over several
+	 * buffers. XSK rings use the same buffer size as the other rings.
+	 * While XDP is attached, the receive length limit keeps frames
+	 * within the XSK frame, see igb_xsk_frame_fits().
+	 */
+	if (ring_uses_large_buffer(ring))
 		buf_size = IGB_RXBUFFER_3072;
 	else
 		buf_size = IGB_RXBUFFER_2048;
@@ -6775,6 +6779,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
+	int i;
 
 	if (igb_xdp_is_enabled(adapter) &&
 	    !igb_xdp_frame_fits(adapter, max_frame)) {
@@ -6788,6 +6793,23 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
 		max_frame = ETH_FRAME_LEN + ETH_FCS_LEN;
 
+	/* the frame must fit the buffers of a bound XSK pool, also while no
+	 * XDP program is attached, as attaching one does not check it again
+	 */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct xsk_buff_pool *pool = xsk_get_pool_from_qid(netdev, i);
+
+		if (!pool || !pool->dev)
+			continue;
+
+		if (!igb_xsk_frame_fits(pool, max_frame)) {
+			netdev_warn(adapter->netdev,
+				    "Requested MTU size is not supported with AF_XDP. Frame size is %d\n",
+				    max_frame);
+			return -EINVAL;
+		}
+	}
+
 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b58cad2..fb04df82272a 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -91,7 +91,20 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 	if (!igb_xdp_is_enabled(adapter))
 		return NULL;
 
-	return (pool && pool->dev) ? pool : NULL;
+	if (!pool || !pool->dev)
+		return NULL;
+
+	/* the MTU check in igb_change_mtu() does not see a pool on a queue
+	 * that was hidden at the time, for example by SR-IOV
+	 */
+	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
+		netdev_warn_once(adapter->netdev,
+				 "XSK frame size is too small for the MTU, queue %d is not used in zero-copy mode\n",
+				 qid);
+		return NULL;
+	}
+
+	return pool;
 }
 
 static int igb_xsk_pool_enable(struct igb_adapter *adapter,
@@ -110,6 +123,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 	    qid >= netdev->real_num_tx_queues)
 		return -EINVAL;
 
+	/* igb_change_mtu() keeps this true while the pool is bound */
+	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
+		return -EOPNOTSUPP;
+
 	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
 	if (err)
 		return err;

-- 
2.27.0


