Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBCC606A33B
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=IBrwQloV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASb+OXEq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03B1440748;
	Mon,  2 Nov 2026 10:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klLCsS-S5sdX; Mon,  2 Nov 2026 10:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54D9240730
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616480;
	b=sRMmlZUv/9vvg/1dgJoMitJ4dwfiP7gOuasG86bYkVDqJzOlO7ANeRz3LTN2vOJui523
	 oBd0yJgXcZ7qlmBGNuY7uicMH0nSTdQNW9/u5L3WkDgY6UvTdiSpDYlrog/ZJtMHhV3ch
	 N0WnbWoXB7VZxlEGmb4zIYe7mVC2w6eVuI2VJ8pg9I2bKtcS5YR5oSl7E0xRRp21vZyrJ
	 JqorZC/vIdQYdX9hmXF7rCRDQYflNQD1QIX0FMMvPNybh69i8eJkhRJkICzUNhsxXTP1u
	 43V6Phk/zSuR0lxw4/HnNEFDqrghfzJ2tybLyNJRJK/uzIbn532Hd2BMWIBSP1UVZsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=T+XCZlvYvkjk5BF780Tiv3zUsXQtUsUyJd0qG2uowUw=;
	b=IBwVlKwHL1G00H7NajYaq8RbePOgb36XTX0G6OoR86uLMlflCcp9VAm8Jg8K4O4ibXPL
	 4T+HND9Qi6SJ2wNzvEBhvU/BsMKvmA8D/3xx0pxO0paCxlmKNykEXldJFiziOx7UjhSiH
	 YiKikPeC46nLpMUM7/Ir6IU0dM2mWHJ/vTJFngLpSkobFSEboS/B6wzrqRGTZQlNaXdMC
	 BTgUiiTLfZK3yCLmTZHQ2Yh+OACBXHN7LMYuRUXR5MLLwJ7zJskcryUn9fWbbLAJQ5G9C
	 RB70eDRiLhRc8HSEu0wo8Yzzd4+mVJ/jPDc8MpgTx+Oj+OC3A9IoRkmqS7DVlEWZSng==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616480;
	bh=T+XCZlvYvkjk5BF780Tiv3zUsXQtUsUyJd0qG2uowUw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=IBrwQloVFu25Ye0D61oZlfpLy6yVtvgw2RGZIn8se/F5ivfPkeB0nXNAbBA1ptrJY
	 GnTD5RiZFaP7jxBsMsDXDRPq7JrMyGzCkycHk0Jl2y6R6UF7gft25p2mRCkhcByM2L
	 LWR6+0DW+FQFSJRGv6X79PQ/HXNhaoU349pLPEpoPIRnbkiHQtmDtJ6b3DjCLD6Hfd
	 QVNUfTwWUlOKz9h/9MlQc5mNgzWlg+lnDrcjtxnrjs10jb4c8Prlok3wGSFMgBTO1h
	 6FF5WvrJnbylo5qGGCYJIHutoDApAgTBg4Enf3jBQMDBwxBftVEg2esz5G3JP/pDTo
	 fOH+sK95ZSrUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54D9240730;
	Mon,  2 Nov 2026 10:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B80BD3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CE266076F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rk12V_kx6e2 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCD3B6065F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616476;
 b=WpR25lrZHCyWQuSuQ+vhrmBc7OZ4z7wPY7K3aw06v16AYHYD7TQz/tchHrc/EoUZjj4t
 +/GlSEcE2eDw2KOJ4alDQ3IS/FwGnWaaiziQW8ZUnkD1dJrgO4MkeqpV/OA4BFjpwLvLS
 nCBJ4L+o+MnKNDf1jJF0QVHdWmnZ6Lu0IZ5KsfiOTUrbN+C9mbjyFSaewTBT6q+GHcZ71
 CEaQAA9HcdrIxswqIdlPF7swhjKMBDPSVNCxRbIPS4aaPQlfCoSolSjMxn9e1npsI+Aq2
 SoMpeyEKby6uqL0FYhq55GnrZIgYY7JeagCzMRDiUD1McLJx7Y4guX/S9k9nU3G+qAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616476;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=T+XCZlvYvkjk5BF780Tiv3zUsXQtUsUyJd0qG2uowUw=;
 b=pVn4BBRMBTljVBjwj7GDjIi9e9t3gE4VfWv+7R+/L1mI3EkXwgjgx6F0QeyThA8L6WXH
 x9y/VRXvtswAO8OXrfClVvvPJb0TCfvm8jT4A3G8l8LqgNpx5oeSNocKWSu/1ApdVlZQa
 sKeZyIpjbro8nyBlE+0v381Kyp8wJPSfL8nPVRh1C2DROnWIbxJcK1FQYRBam46Sy8P6/
 8RqrG9Myf6E/ZeJ6tkqdIyuLM6/3I2Z8HUKl36h2MlQvjJFHLGqxMuRkhJcSJIObyzkZ8
 sA4aG21+hxTrQHD7OhHjj7ryag69KZ1+10HDvhF9go6RoSktnbormDXJO0NATVdR6YQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ASb+OXEq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+tkusters.aweta.nl@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ASb+OXEq
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCD3B6065F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:47:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C125400D5;
 Mon,  2 Nov 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793616476;
 b=sy9ZR3BrQ8I4QJHRe/r2Pz8c3L5C62MroasfB2dZTg4aU9vbqRZcRmcy76lBNIofJubK
 LVjgwEcTgDz+0vHIKpq0g3mAtr+ZjkdHcJutgq+S2h3S40NYKcptFldEZzqxTdSCa2OZM
 CTqpLFDGGvp6TapAsXfYblyUl4pz1MZlR5Ib71nVUZMd6UvdmNQ0xgj8HrxDnDPsjPWog
 EBJirc/JDeyj1MRC2qffYlbiAQL37BmYx/QKubzzVqrt24agD+vcteJPL2BjQBi5VzKd1
 1t5LIRwnENdG7HkzDc+cedZAUkrti4WbqhSN68PKIR0RKrqUskp9F+fnUw1uh5BYViQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616476;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=T+XCZlvYvkjk5BF780Tiv3zUsXQtUsUyJd0qG2uowUw=;
 b=VoWVe9Fiu0C+p4ERrvEqYTi1PIHlMOwRsG9GqqTq+O65yBHqJAJRFwWvxoe6N+diiqVT
 23x+0X5Bc9vIlngIlUoEg1vz0BNMisK+1XZ3FtiJEUXnl336h4+E11+Owd3800LA0U+F7
 YFfTdQCeiaA4hmHNTu7as7Ox/TLiAvNAS86+6IOHRvoPA6Ra655MCXzW2+T2clJwVNSr8
 YFwmMvraJ358oe7B8binYrRkhPnbKSh3gIqLgSsWS0XbpCu3Cwxo79mvku6r//4fzKec/
 eCDjydaiMRiCUy7V6U+eglgm439f0hDi3wRw3l7u8LwHSIATMAj7fp6r4B91A4uP/Fw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 035BF1F00A02;
 Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616476;
 bh=T+XCZlvYvkjk5BF780Tiv3zUsXQtUsUyJd0qG2uowUw=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=ASb+OXEqzW/PPS8dNCok0PKiHQrEn27Wg36PJr1zzh+e5JQuDBj545fZ/hYlpIF2u
 kS24gGk2kM9tVhnMUpiJ2mbLOoahV1DkZwmmHFQqThfdAH+xQ3RI1yJpdIOVfhKggD
 v7CBRwfgKvM+Sh93qr5uYRkKsCqTpnBRGpv2RtdvnmTjxCxGgnX4R+RA027q7nFGiO
 6k9vtZqCY74I2gMP9n43U+WLdaWAokT7uqbkt5LEZxNRT/0xyalw7KDDA/KE9m0Ll2
 ONmmSYMf1iAESyP2FzcO63rITlW5/+rmh3D/lMgSYyWHdvLAv1UJglQ3fVx1N2d6A/
 QfDts3nO8ScVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 546E94648C;
 Mon,  2 Nov 2026 10:47:54 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Subject: [PATCH net v4 0/2] igb: only strip the Rx timestamp header from
 the first buffer of a frame
Date: Mon, 02 Nov 2026 10:58:12 +0100
Message-Id: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRe6GoC/3WNTQ7CIBhEr9KwFkNBsHXlPYwLfr62GEMNINY0v
 bsUN42Jy5nMezOjAN5CQKdqRh6SDXZ0ORx2FdKDdD1ga3JGlFBBRN1i2yvsJxwD7uyEtTkS3nA
 AVguUmYeHXBffBTmI6Potw1PdQMfVtM4GG+Lo3+U10TL+c5AorrFhqjGCcC0FPcsXRLl396JOb
 ANT/guzDLetYtBJ0hgtN/CyLB98Gc3B/QAAAA==
X-Change-ID: 20260619-igb-rx-ts-fix-cd70585ee316
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
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616473; l=4574;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=V317TYBLwQ5WuNCyFF4RLDMHWynYiHCEBd2nD508LPI=;
 b=ryqI9RDn2jIBrVdv2VZ0VDC8gJhkzqTYx+tZ+sPo/GvZamUxOjOLhrxVtuZwgWWzZWNbzkepK
 yPQNoyJ5XEQDyZDQzBaN1EYLdx1gQ29UMd4z8BCbz+X4Cy5DrHzCYz2
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With Rx hardware timestamping enabled (e.g. by ptp4l), igb strips the
16-byte inline timestamp header from every Rx buffer of a frame instead
of only from the first one. A continuation buffer that starts with 8
zero bytes loses 16 bytes, so jumbo frames with zero payload arrive
short and are dropped.

v3 used skb == NULL to find the first buffer of a frame. The Sashiko
AI review pointed out that this does not hold when an XDP program
consumes the first buffer of a frame that spans several buffers, so v3
was sent back for rework.

The same question came up for igc. There, Maciej suggested not to track
frame boundaries in the data path, but to make sure that frames never
span several buffers while XDP is attached [1]. Paul Moses' igc v3 does
that [2]. This version follows the same approach for igb:

  1/2 limits the receive length (RLPML, or the PF pool's VMOLR with VFs)
      to the configured frame size while XDP is attached, and leaves
      room for the timestamp header in the XDP buffer size checks.
  2/2 is v3, unchanged in code, with a note that it relies on 1/2.
      The Reviewed-by and Tested-by tags of v3 are kept for that reason.

Not addressed here: the AF_XDP zero-copy Rx path. igb_clean_rx_irq_zc()
has the same unguarded strip, and with 2 KiB UMEM chunks the hardware
buffer is rounded down to 1 KiB, so frames span descriptors there. The
igc counterpart is Maciej's buffer-size patch in [2]. I do not use
AF_XDP and cannot test it, so I would prefer to leave that to someone
who can.

How to reproduce
----------------
Receiver with igb (eth0), peer with MTU 8228. hwstamp_ctl turns on Rx
timestamping with filter ALL, no ptp4l needed; this ping method is
taken from Paul's igc report. One host with two ports also works if
the sending port is moved into its own network namespace.

1) Truncated jumbo frames (patch 2)

  receiver:  ip link set eth0 mtu 8228
             hwstamp_ctl -i eth0 -r 1
  peer:      ping -c 5 -M do -s 8200 -p 00 <receiver>

  Without the series there are no replies, and IpExtInTruncatedPkts
  goes up by one per frame. With the series all requests are answered.

2) XDP consumes the first buffer (patch 1)

  receiver:  ip link set eth0 mtu 3000
             hwstamp_ctl -i eth0 -r 1
             xdp-filter load -m native eth0
             xdp-filter ip <peer> -m src
             tcpdump -nn -e -i eth0 'ether src 00:00:00:00:00:00'
  peer:      ping -c 3 -M do -s 8200 -p 00 <receiver>

  At MTU 3000 XDP can attach, but without patch 1 the MAC still accepts
  the 8242-byte frames, which then span three Rx buffers. xdp-filter
  drops the first one, and the rest reaches the stack as a separate
  frame with all-zero MAC addresses:

    without the series    5154 bytes (header stripped twice)
    v3 alone              5170 bytes (stripped once)
    this series           no frame; rx_long_length_errors +1 per frame

Tested on an I350, kernel 6.14.9 with these patches, with the steps
above: results as listed. The v3 line is from an earlier run with an
XDP program dropping ICMP. Also checked: XDP attach at MTU 3030 works,
at MTU 3046 it is refused, as is an MTU change to 3046 with XDP
attached. With two VFs allocated (booted with pci=realloc), step 2
gives the same picture: three leftover frames without the series, none
with it, as the PF pool limit in VMOLR drops the frames.
Not tested: PAGE_SIZE >= 8192.

The patches, their descriptions and this cover letter were prepared
with the help of an AI coding assistant (Claude). I reviewed them and
ran the tests above on my test bench.

[1] https://lore.kernel.org/all/20261025065154.2037149-1-p@1g4.org/
[2] https://lore.kernel.org/all/20261028083344.3047350-1-p@1g4.org/

Changes in v4:
- New patch 1: limit the receive length while XDP is attached, so that
  skb == NULL reliably marks the first buffer (Sashiko review), as
  done for igc.
- Patch 2: no code change; added a note that it relies on patch 1.
- Link to v3: https://patch.msgid.link/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl

---
Tjerk Kusters (2):
      igb: do not let XDP frames span more than one Rx buffer
      igb: only strip Rx timestamp header on the first buffer of a frame

 drivers/net/ethernet/intel/igb/igb_main.c | 37 ++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)
---
base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
change-id: 20260619-igb-rx-ts-fix-cd70585ee316

Best regards,
--  
Tjerk Kusters <tkusters@aweta.nl>


