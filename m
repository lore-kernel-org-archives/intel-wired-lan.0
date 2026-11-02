Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B860A2613
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mJEjWih1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYzv+WkJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81C0340750;
	Mon,  2 Nov 2026 10:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3QNR08i8ByET; Mon,  2 Nov 2026 10:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D08B40719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616481;
	b=C4ETBWrc8YZRYuIrvWKxKG6Km1jdaGHwXwcdzYuW+bCwM4P0x+ESA0Sb+I/mnTtzzSgY
	 rY0kR8EczXnwNQj/D0nPIZawouEhTddxnuPZPq7p0SCZLBW4RoCVQV4obUDWQZcNGuBjY
	 m+lPszU08vKe0McIgdu/40LXlrGWFc8TQfjs+jFHs4gMMXuJMxUJep3aXTPxNcr3+IYmD
	 UG55fIdgnuRS/cqX1p2Uvt1plgK3/X3I+Q3xfhdi1y6cNFO+prn61W9tnTZ3ig/WYViGa
	 8qEH3RakN+6LlPv//P7zmWjm+eCqHwpaYKuLLd8KaXd15ka7qiHqKMc3XQk/KPTnxCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=T+RZI7e7a503JJKBr5TErd2x3kUYSI+ZxpBEoVMoGJM=;
	b=omzlppPcFl7fGKUuRKNXjLyYwcpPGAUoX1YLcbWzRdDVTgfsi8NVJjlaRC2OfhWHfTml
	 xznAWIBfBVISn2EefpxfTVcCDKRdTu9euNRT32cI1zuJJaMwIuAcnfky/f+IIhkq2OF0M
	 WD1PkE42uZ6gdjsZUa5RjPD0c5Ffe7pbU2y9G4TH9fNG170tbx9DLDmADaWbkYUrmc7qM
	 Dy4Bb3m2Pzz8A1GjV5f/eMkjKVHIvp712zjZnCnh0pnqjaRLyjeBu7PdaGhquGPW5Mw33
	 qX1yz8LAq/bze+9WrGt79N7xRTAMyPW4NoZRvTP993Pct5AM9vvFNJAjph/thVJnACQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYzv+WkJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616481;
	bh=T+RZI7e7a503JJKBr5TErd2x3kUYSI+ZxpBEoVMoGJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mJEjWih1sRE/YFt6lEDxD5vk+H2QFkVXFY0g8NNFqpSEHAEC6Iwf2fWh14YhqAJsq
	 5KUtqLUzMenmDM4qal+eN54qawPXaxPyrL/RKSuk7KJcf1yuhgeBfZV7xlbZwImB20
	 RkZCN56g8X7RcoUTQBffsNs30I3iRIez3WAOU6xE/dQ0oH0Eb6xAboWUQ5HTggm4rI
	 WtgJTb+6IpLv3pqUJDL1YhUFp123V41E76WtNAd1UNZglDsTRwD5D8H81hIwQ0SCOD
	 BLfJ5A5FKlbnO8P2h/2aoXhsm6D8ei6Z0ULgWDYYu8/5tk3becFQ9u7WZlyXBBRh7L
	 zIp5TZUESZ01w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D08B40719;
	Mon,  2 Nov 2026 10:48:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3DFE362
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B96F040730
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37VaxH1HnmuG for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F377240719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616478;
 b=U1qhKpY9KkjnJKwmreMnUQQv8PblZGGrkH+jjRgUdhzOEI3q9BfC1l2gJCCer5OFpXKX
 bPsPvc2UL5Lt0iCIJJ7ICgoWW3Zpjd2zqi062Hjjm/T9IhSVpldwLiFC4Oa5Ieaoq3Jyy
 HzAGjdvMpKfZfT3TB3Jw6M/IpbVhgLSOIsJ9QzLhn1TRr9F6hIDI4qozLCbKwO7DQ+Jxh
 6mjPtsvFpCSqE/IWX+vIYPEe3YTjU5gw8GewHkyibo3LtwHELkSSR4Yx03oOyCDCvS5Nu
 HP45Vwl/h/1v3x4h0HGu8OpUiy0J/abFzwwtwz+XbzAT7D8n3IhULjfZL78y5mhbXew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616478;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=T+RZI7e7a503JJKBr5TErd2x3kUYSI+ZxpBEoVMoGJM=;
 b=cqfnLfIW1RKI9IS13C3UCtUoyobnwva6FIiZsjLTYoHRhHItb4SiwKpS6saQ7hjr39Kh
 yJLz5PTyOWRlCRtvKXjvMVC2tbXiOkqP4ee/ZE83myR0ktc28X5wLNuZiEeNDPaiSpRY4
 nX1CFOYRgF/v+XNxmS2I7OaGz/foG1j79cfq3HjeA4gtMJUs5SCH73PTnjkX3QXvdHGXd
 THZDxLmt7ll53EqfkIIlByDT+lKOPldLuyDhNrikirIO2tYEZhJ6YCEUZy4Fd3ssHxww6
 U2JQo28aCodZl/jWutLA3NSe1Ja3ocxMeCXlFvFLJnUpqYnoUOK1mqESICn6vyv9e1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OYzv+WkJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+tkusters.aweta.nl@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OYzv+WkJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F377240719
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBED060F1F;
 Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793616475;
 b=WVqcCGBhTnb6+4fi+rPYGcRTrnak+coOkJ1xiT1KOJzV3WaAwN/T8tY0NpUDKVbm2+D+
 72TwDWgAGz0YwnHEzvPWrnclhhzFlMFX20U29e9KclHamqdTgFJ23XUVD3DvrDWSGHa+z
 bsfYr/iGkVzMKRs3wFABuwAxZW92suTjKI9Cy82nFuDdF/wysYmiT5Hg8ZRQUZ5lT+Wf2
 tIdIXta/HjgXD80fGKT86OP8Bll6MnZSmcWlTRD6izzBWGpv3s2ocoPiYjm4KdZwsNYue
 UvT44MlUHVE9Tfq0cHAQ0R2CBO9GDf57iuJa3UiduKNrC2TNnNGRpDXmmLLIFgB8XXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616475;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=T+RZI7e7a503JJKBr5TErd2x3kUYSI+ZxpBEoVMoGJM=;
 b=VORQTAe3MBh1PuqaJfRMw446M+E7s8kZS4U3qZQZfnpLg8jdbwfGKKfdL6wcBYrDRY8j
 AFg+rSkS3852ToaGVBzysiKUgtN441/e/BV+zl26UQli1BYj4y6JWYsAD/pNkTyAadxCQ
 5fUHffsL6gscjdtFVLPYkQ7li+SmKuoZiz9NbXxbhirXViVKVvwmMKC1pxtJiMlct9RwO
 le9aZbxICwVvfwbQEQ3C3zPkRgMjhQ+Xkvg/8cxFbH8vOV0rgsFjhBSOalKaSaXB0fmY+
 ku9FfaBr6IGXwKzxQrdfbjoiMaLdFuNjJU2zRhKzkcf4qttVHsREgF/S4mChVpl94Dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 031791F0093A;
 Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616475;
 bh=T+RZI7e7a503JJKBr5TErd2x3kUYSI+ZxpBEoVMoGJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=OYzv+WkJwfrtldpL/Yko5UKJk6OLW+W3iXPGlwipDa0+k3U46hTjh6tVt0L5W9DtA
 n32s4TmFFJp9ht6Ya5Rp0ZsIkqovJZtxcT5YJeuUqnMV6KBHt1AvTQ6RM0jP/FTBwS
 iA0uv1uiCUxoTZZwWxRgETD/J3NxTs1TA9vjmIQND49ynDDRwFroCjgjedHVwZgWuM
 KRUIeJFVGQnJhyXB1AmV0qR+zokSpXrl2vtJm6xU3lhh0JDOqu+o1XX4JCr4W3F6R1
 6aW+lRX0Qn5B6AgvvwrkbopWmGbOgsXBTAz/yfef0rddL7ouqA4I2bTp3md49JGo38
 SBLegs12OXukw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 72A964649C;
 Mon,  2 Nov 2026 10:47:54 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Mon, 02 Nov 2026 10:58:14 +0100
Subject: [PATCH net v4 2/2] igb: only strip Rx timestamp header on the
 first buffer of a frame
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-igb-rx-ts-fix-v4-2-8785124c5d23@aweta.nl>
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
 stable@vger.kernel.org, Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616473; l=3972;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=0UiloOh6U/B/tS429upH2HnGmu+A3rF/YZDhNcwUk1s=;
 b=8QWdz2XSCtqtw7EyzLikUTpweynlVp8P122E3NuY6pSby5O4QQwGb2eRS6ULk6G6k4ddNGW/9
 l/o2v/0bcVzBkRGmHkkvL5sIl5L1P80vvuhk7OZOiXNB9VT1hsY7gbA
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

When Rx hardware timestamping is enabled (e.g. ptp4l, which configures
HWTSTAMP_FILTER_ALL), the NIC prepends a 16-byte timestamp header to the
first Rx buffer of every received frame. igb_clean_rx_irq() strips this
header inside its per-buffer loop:

	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
		ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
						 pktbuf, &timestamp);
		pkt_offset += ts_hdr_len;
		size -= ts_hdr_len;
	}

For a frame that spans more than one Rx buffer (e.g. a jumbo frame), this
block runs once per buffer. The timestamp header only exists at the start
of the first buffer, but igb_ptp_rx_pktstamp() is called for every buffer.

On a continuation buffer the data is packet payload, not a timestamp
header. igb_ptp_rx_pktstamp() already has two guards against acting on a
non-header buffer: it returns 0 if PTP is disabled, and returns 0 if the
reserved dwords (the first 8 bytes) are non-zero. Neither is sufficient
here: PTP is enabled, and a continuation buffer whose payload happens to
begin with 8 zero bytes passes the reserved-dword check. In that case the
payload is mistaken for a valid timestamp header and igb_ptp_rx_pktstamp()
returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
that buffer. A frame spanning N buffers whose continuation buffers start
with zero bytes therefore loses 16 * (N - 1) bytes from its tail.

This is easily triggered by a GigE Vision camera streaming dark frames
(mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
the all-zero frames arrive truncated while frames with non-zero content
are fine. There is no error indication.

No content-based check can reliably tell a continuation buffer that begins
with zero bytes from a real timestamp header, because both are all zero.
Fix it structurally instead: only attempt the strip on the first buffer of
a frame, which is the only buffer that can contain a timestamp header. In
igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
so guarding the strip with !skb restricts it to the first buffer
regardless of payload content.

This relies on the previous patch. Without it, an XDP program that does
not return XDP_PASS for the first buffer of a multi-buffer frame leaves
skb NULL for the rest of that frame. With the receive length limited
while XDP is attached, such frames no longer reach the XDP path.

igc has the same bug and is fixed the same way.

Link: https://lore.kernel.org/all/20261028083344.3047350-2-p@1g4.org/
Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
Cc: stable@vger.kernel.org
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5bf489cd7b06..c4eb9f589fbe 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9072,8 +9072,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
 		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
-		/* pull rx packet timestamp if available and valid */
-		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+		/* pull rx packet timestamp if available and valid; it is only
+		 * present on the first buffer of a frame
+		 */
+		if (!skb &&
+		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
 			int ts_hdr_len;
 
 			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,

-- 
2.27.0


