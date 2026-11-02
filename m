Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BD606A331
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dTNJLDTn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spg6taB4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BBC880DE2;
	Mon,  2 Nov 2026 10:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwCr_oq6Lf7L; Mon,  2 Nov 2026 10:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44D4280E46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616479;
	b=f/aEsSKyj8ZWFhkM/Ptg5rSaJd80Smc/TlU3nnVGXvq/LRViByK6G3jmHS1yC0tdwOaw
	 Z1pE0wyLZJH6QjWcVRvO3jm+wyqTIcPGPPJMK4j2Rs9evLDXOQHEq91Os8tLD1GatHpes
	 uNJLTkHBOWMX2GcICiSauRLOy31st2N0SwQNDrkVdKpQ4LbVbXPswGh5JmWL0GiUphpAm
	 sKfjFw50TfUnL1w/IFhqVMuZVTFhL7W2Fkg9v8+3IxAYvk3J1tk7yC5fYFc1bUFrbj5iQ
	 eAmZEbnej9E+S27nog7uTddeLEVRlDxCe6cGgNG9vpcN3y8X0rkHrDsp+VVaYviCoPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
	b=NbyD8bbjUn0yk4qcjMwZDqcq+KWhzjhOcJLWv+tIzSAbqI6vFs//a4vJIyxbzBRVOGrv
	 ccLa8vou9vVRd002VCLA15y+1MF0I5aO7Kep8b8+RIxlagzi5u+IoTNCEmKy8UFtFeTpo
	 Ks2XkTHIkwNR8yVkM3MFFkHhCGJsQDDRCmTmBx854IIkrcUgnDsKaD505LrjHjKHDrD/3
	 CnekaIj5zFYUdyS3a+fV3pg4nA94KBxr6bRmL/YXhP0gVKQBMpS40c7LjPxwpmRomufRC
	 TwdGS67zma6UWBys07HFPQqbt8Y+6vhx9QhhNtSXS5MGsaNh3A+dDgr5Se9lDZvsfsA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616479;
	bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dTNJLDTnq2d8q3IZzGh/lXJZ06nMnf+3/G/SFmIywXfS3pD1m8pMOiIzthjWuUEyp
	 UgcMMPoHTb5PVUTMN8zjC754nMJpGW4pPbLeyRglgeMAJ0l1uI9AZ39KtXGsQHA891
	 8DfKRUR9gciLfYEj05fURB5tFtc7qRKujAtNcR8Lky3HBsCyX68YQXn+guoOh52LoT
	 RtbWrO7J5Ll+8wZxOLSbKohJGcLC88dLLUgPvIo1m4/GfixR/Z1BXsokWnUO0Eu/J3
	 W/DXxWNGLIamkkE1FQcdhfYsjkD+GmqngcVLhrIQOodhHAfmwcyXgcp3PXTONVkVzO
	 Qb8q0cHTCp2QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D4280E46;
	Mon,  2 Nov 2026 10:47:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41E7B362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F39D400C8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivO_axLivauP for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E96EA400A8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616477;
 b=nNEIY1UqH8G1ilebRb6Knv9WBRSTTEabMZqVkgWIoZULpGLEfIMiznvxkJ/pqOwmzU4i
 jsPjYznUVCYUFsxAF8lxclfVXt8B+Cjo9fOJbYPKWbxq7tq2S/YP4mI1oCxmJiQzFYSFw
 uqVpQhV3pOM4P5ZXo4msswSQPlzL2chj1tL4MIwGBnnywrV5wHstMkV7rjNpOWyGxjjHf
 Nx1aGL65+Y4cTYjueND7JLrULKiNOARGxDJZC/rIlOv+PEMxwsZtrjRBI0ql2j+4D1H3V
 UaYNKb9zFt7KWoUNslipnQw48/o0+nn7cIDlBQx3iWULOcla9WknEekr3beqr4uEgNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616477;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
 b=i4DqtBz0iz15R1eVwhv0QpVmiulG7hioNBnbxeYdWVCK4w5MDcY/D5O8jYtxEdk55J4D
 b+qA9IR33ZGGVFMEtm0SsRYjNAaEHB93fBb0Dd9YLEM2Pwk0NpIPftFtkZoMJo7EDv2L9
 Lu9CENkNi/bqwymYlghn/KsrZ7YNX2MXyh9j3/nf++xUAUJEtcQk0k1uWm4T0j9Nw7nCh
 y0piCfcHUFC2S1ZUQSMHcqjSHedEXtw/xZD4UPeZZFQZ/iTAylq2bbtqzmFV/nPioswtL
 xgEYYgTTU6+ZN49v4Jcv1zjbqbj3yy1fI28TluT/Kl4eFWWgUGGs9k7G0oVR6aoIauw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Spg6taB4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+tkusters.aweta.nl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Spg6taB4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E96EA400A8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2A7F413D5;
 Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793616475;
 b=I2i/F3093zMJfH7c5Lw8A3DIkxrtA5b8GauF5irW2ZZsmtJJogptD5bcT0ECYb45iHV6
 xfJJwY4+eRDoCyOF+qIvtr0mUmIDQR76/UyTAt/ncg4dKXbzevt/+mhwd507Yzv558B+3
 UEDTMrYgZnnInYsQxB2w1zf+jG4d0mngmzbO5Y1O0TeDJyMUqIp2pgblAiqDEgLMV9k5+
 8e755jYDBlyQnUx3ciED8QHd+1p1+1AaskFtFvHAKb9yPqkaB4aUlfN/kijSH5WEQWiZ1
 oCgO4lW7lwAwqTWP/5BMIHONFRqzMieR8xwexoyHcuep3SNdGBZYTna8/3mu0s+d0Ng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616475;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
 b=AHGAc1Q/QyMUiaggLvdGHrxziqs0xSLumIHXOwSJcyH57U6hT6csxWrGUBheYEAcE5xc
 jtgCWGt/EPs9rBHwm68e6Z86TjkZDvdGtrK5lPjOLZf8RpLmHK9FU/ixlx7jaDQc0vQTy
 ypYup5AFLOUsknSS+2VyXY/6cZf0cKMk0XcD3w1smY7miLO3BfVFOCbLjH5+Wtsf7GHGf
 L52/w6+Ud8A9l4nZdG1jW9c5njqRhvsu8WJPj+4+Z8tMv+qHsBYNx87Ox7Uo5OIsCpQB1
 F9g/L6HdmcyFzHu/K75lfEGnBAARsiFq5bWd8jK0tIKHoab/2gItdYOFrI05ciYRBlA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 031441F00919;
 Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616475;
 bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Spg6taB48VEEnMXxA2UXrX7SjjHBCLRDer5ciEmWIqcyRMJtoCLCPDrAPdQD7iUCH
 k7NBzhev0Jy+MRlxy3R6BH/sHb5Fu+PVQgzHo5W9JJwZ0kFSsdAHqJM/Vqgg4SSGHQ
 ORjfz6SlYYHR93Z4EJvwyekq/1sdqgvdHk8yXycNFb2m3gXYLYvTA4oJWSQEnKAJtZ
 xSLOccDal0tOJIpufDSaMADaN0unLx8f1DAsIRCgcMEK7ltK/sW90PIt6ablIPoLfs
 2yNtxCATqBxtfWSFSVyqNdsjpOKOfoQcLz8xNI7bgq/wzUTQG9v/K6oicJUrztMYa1
 fitl9enYBv1qQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 64FDF464A0;
 Mon,  2 Nov 2026 10:47:54 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Mon, 02 Nov 2026 10:58:13 +0100
Subject: [PATCH net v4 1/2] igb: do not let XDP frames span more than one
 Rx buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
In-Reply-To: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
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
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616473; l=5817;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=oeKPSFBLrPdgnpDjeb+PUB1eK71EhR4L/FqRyXpHCrM=;
 b=lNhogHtFrSl1tX+7vv+jRZAbbu0JyuYTp3P27fnxY514h5UT6bBIxPcHrMz2EZ/oHYct7OIZZ
 MosTg0j0OnnC45q9wWDlCDpB8I48toks5VIpFW2v1NMBanHsZX8qGHH
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

igb does not support XDP multi-buffer: igb_xdp_setup() only accepts an
MTU whose frame fits in one Rx buffer, and the XDP program only sees
the first buffer of a frame. The maximum receive length is not limited
accordingly, though. RLPML is only lowered when the frame fits a build_skb
buffer on systems with PAGE_SIZE < 8192 and no VFs, and the PF pool limit
in VMOLR is set the same way. Otherwise the MAC still accepts frames of
up to MAX_JUMBO_FRAME_SIZE while XDP is attached, for example at MTU
3000, at any MTU when PAGE_SIZE >= 8192, or when VFs are allocated.

Such frames span several descriptors. When the program does not return
XDP_PASS for the first buffer, no skb is built, and igb_clean_rx_irq()
handles the next buffer of the same frame as the start of a new frame:
it runs the program on it and may pass it to the stack as a bogus frame
made from the middle of the original payload.

Limit the receive length to the configured maximum frame size while XDP
is attached: in RLPML when no VFs are allocated, and in the PF pool's
VMOLR otherwise, as RLPML then has to stay large for the VFs. Larger
frames are dropped by the MAC. Also leave room for the inline Rx
timestamp header when checking that the frame fits in one Rx buffer, on
XDP setup and on MTU change; this lowers the largest MTU accepted with
XDP on 3 KiB buffers by 16 bytes.

Both registers are programmed from igb_set_rx_mode(), which
igb_configure() calls, and attaching or removing an XDP program on a
running interface goes through igb_close() and igb_open(), as does an
MTU change.

This follows the same approach as the igc fix that limits RLPML while
XDP is attached.

Tested on an I350 at MTU 3000 with Rx timestamping on and xdp-filter
dropping all IPv4 from the peer: 8242-byte frames are now dropped by the
MAC (rx_long_length_errors), instead of their last two buffers being
delivered as a separate frame. XDP attach at MTU 3030 still works, at
MTU 3046 it is refused, as is an MTU change from 3030 to 3046 with XDP
attached.

With two VFs allocated, the same frames are counted by the MAC but
dropped by the PF pool limit in VMOLR before they reach the Rx queue;
without this patch their last two buffers are again delivered as a
separate frame.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..5bf489cd7b06 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2894,11 +2894,13 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	bool running = netif_running(dev);
 	bool need_reset;
 
-	/* verify igb ring attributes are sufficient for XDP */
+	/* verify igb ring attributes are sufficient for XDP, leaving room
+	 * for the inline Rx timestamp header
+	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
 
-		if (frame_size > igb_rx_bufsz(ring)) {
+		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
 			NL_SET_ERR_MSG_MOD(bpf->extack,
 					   "The RX buffer size is too small for the frame size");
 			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame size %d\n",
@@ -5324,6 +5326,7 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int vfn = adapter->vfs_allocated_count;
 	u32 rctl = 0, vmolr = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	u32 pool_rlpml;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -5386,6 +5389,12 @@ static void igb_set_rx_mode(struct net_device *netdev)
 			rlpml = IGB_MAX_FRAME_BUILD_SKB;
 	}
 #endif
+	/* XDP does not support frames that span more than one Rx buffer.
+	 * With VFs the global limit stays large and the PF pool is limited
+	 * through VMOLR below.
+	 */
+	if (!adapter->vfs_allocated_count && igb_xdp_is_enabled(adapter))
+		rlpml = min_t(u32, rlpml, adapter->max_frame_size);
 	wr32(E1000_RLPML, rlpml);
 
 	/* In order to support SR-IOV and eventually VMDq it is necessary to set
@@ -5402,15 +5411,18 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
-	/* enable Rx jumbo frames, restrict as needed to support build_skb */
-	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	/* enable Rx jumbo frames, restrict as needed to support build_skb
+	 * and XDP
+	 */
+	pool_rlpml = MAX_JUMBO_FRAME_SIZE;
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
-	else
+		pool_rlpml = IGB_MAX_FRAME_BUILD_SKB;
 #endif
-		vmolr |= MAX_JUMBO_FRAME_SIZE;
-	vmolr |= E1000_VMOLR_LPE;
+	if (igb_xdp_is_enabled(adapter))
+		pool_rlpml = min_t(u32, pool_rlpml, adapter->max_frame_size);
+	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
 
 	wr32(E1000_VMOLR(vfn), vmolr);
 
@@ -6713,7 +6725,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct igb_ring *ring = adapter->rx_ring[i];
 
-			if (max_frame > igb_rx_bufsz(ring)) {
+			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
 				netdev_warn(adapter->netdev,
 					    "Requested MTU size is not supported with XDP. Max frame size is %d\n",
 					    max_frame);

-- 
2.27.0


