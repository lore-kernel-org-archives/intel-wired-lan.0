Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717E606A319
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OOC5rqoI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpwyzFYx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8EB7404C8;
	Tue, 20 Oct 2026 23:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1fsoFP4IRUx; Tue, 20 Oct 2026 23:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE1A04057D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792537441;
	b=qBWNANNYeyNjHTVaXek5673CG6WDHnjvk6WSeeMEqqmCrV96LRgaZ8lhwohChHwBbTzT
	 KqxfAoZkhREsx1FjqmV+370CmcwjovX+r+l1n/X0h6ZmCDTvse6mGU3fv4nKejctHyIwv
	 fUU7OEAGKnxZ2eT/hlmZoF/qvtWbcVmE0R84ww4poOJMPe7O4CQq46CvFlB6s3FwepxRY
	 YB9ylvOkw21+wkSYDUYaLO2zN1rU7UePXXJatHwIS4uAVoA4m4hO6Q3cciGRGDqfkqUgv
	 8opXSmsBAJr6s4Aj6b0swkv2XKumhcIOjo/5j37/0JykZTovRD3/BbCcymy5sIWt86g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792537441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
	b=BoYLm0pQy4LnAdVc454VV5wRKX3sgTRgSWNgJD6V1BOOk6nnYn48faHSTri131633Qbo
	 SNOl6kf7vIqyUIxddcgLMam5YyZYDjly0sXm+eoBs1QPtiJD9HeyVv81dzSWX1VXaHD2m
	 0kk1qtPF8lLPJfWTfAWxz1XlD0TvuFdMvWkZJ0q1/iHcYiyNQzfYAqgQR9FpsIsl1Azi5
	 Z0C8+7C978gHBhF8Wymr3zlXD0Ivr8Ci4ucnTrfHxPBW5EzN+lVq6GyMqGhGZX9pIIMB1
	 9YxMimJSFJI1uNocXm8987oFYHe8xemoEd298XI3Rdh0z9TvsLAbe623FSy3xnuhD5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpwyzFYx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792537441;
	bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OOC5rqoIBZxWiLPuDVyls/PTNoLHIAfXAJkA2Z7zhUJRyptVr2+Co5zpyNFyDYLry
	 VJa+Q3Z6uKWHYmNwkJOD+PnKXNsqjoddVl1JxDey0w+hoZi+quEwAsVBIgwK+p7wTM
	 AxF96631Y3HHpUjcW57HHb27x4CjP4PpsGESmVoaa+cR1q//c2Ka+5kmFC8hFnc68x
	 h2+CuqOII72Ba6LKpvjn1crBaDa4+akBb/kRC3HVUcCEub4ua0tR1MFzLYnzbFCc4O
	 iHqOzO2xQS/i/SVkIRSMDBMEEELjjcP5c0bHSVwJgVo8uSAt4dbr0B+O2Wq/Dn0N+x
	 +EWg77CRi4uWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE1A04057D;
	Tue, 20 Oct 2026 23:04:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 650A2769
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 23:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 573874057D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 23:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PS4XldKV6D9z for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 23:03:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95A59404C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792537439;
 b=sChynn7DafCSrmXyCG/YE7RRdwzkn3NwIyuxqyLwu6CeM8b5syvRwRDkH9MHoeI7mBFi
 jpC1FvasPcZm5D8hLjhZWpEGBMuesu0yVZ8FuMDqfoyHCpoyhdoeaULftYF9NYJjfltat
 73+L1gJYBEPHv44pJxwv5QAcu0k1cA3WERnWz//pWpywBVDFmIDD5x/iXFjTxzS1otau4
 8aVfCGqBwVOp0GHh3XIVwNbufbkiGVaRXKj7mKYshETWVBnukRYX+BHI3RARpNVMUTo3i
 EVteiA+Mzmbv3nNyFISOO4NGkfsN8EhmbEq5VZwwi1ZGZMv1RnEm+sM2KpEytfVtsCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792537439;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
 b=LQ+j0ECEXupzYhc2PhBlYI0unqNvEGhaFw+P9fm8uSTJp6DdwNv6b3xEkxkTYF1c2M9p
 iQqfReDzMTcAOPWSW626jn7a7ViCOI9rjX0m6ocBZ+Aa1Jd9x1wEgri1EV+QfC8GjSLfi
 Vq3CsLx4HBBnErQONG72Cb78/vDukkgX87Y89qHYzmQOP/1FJBZh+GXpOQ020H56TMqe9
 p0v5SFVc/URlL/BnIOHnKw8QJsXMGT70J1QUbfWLs334uR6QPnrhVe3Xg9d0cQNnVktY7
 y9vfGfSuZPg2Hz2U2QYfUX7BiDhenwVjLxD/2Vk0DEx6CeKPtypm6wkHifk8/5i0LTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FpwyzFYx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FpwyzFYx
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95A59404C8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 23:03:57 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c441e267930so6845166b.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792537436; x=1793142236; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
 b=FpwyzFYxVxjgOuNnqjDR1mrQL1BrWU2tqgadvCmyXT0DilNmUUkqcPBpXzWm/gf3vD
 1AEIBa+Z5lKiiFGbexjehWZFzeNiHyznEOh601CfzbfvIEOrwW6hhvJ4cbG9HY/dMkoR
 6xM7djdpphxDD5FKIv+M4ECyzF9kkO1PbBVL2vihvjyyVrVc+z8APMB8P6iXOw7Rf5rv
 Y/XuMWwjmYG66OIDvpuMEOY0/gI/DyKB8vvm1361SlXa3MgeVVsmio1jY4kwFfQT2r0E
 lubq7rYQt1U6JDQuI57Bx5hDvwZGvyfo/QxRW4fumGBtTwlTpeNB1VkvwoLgwc+3JS5F
 2I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792537436; x=1793142236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
 b=dJSOda4cBRX8r2Xg5SVcPJP5X9k4LiJfH/wug0KSx9lHamVxjr/sfV7vDzKo5K5by2
 7KB2l4Cvmng9aJ28ypDrvxmRr/pqiAVuOQ+4os9AsBejtdBWL3o3p2HkF1qOhWgZdALE
 Lb1z/YDxgbp1UpaMMcEYAf3YAdOVPqLawtlBSVTedccFfkQITp66kqlR6OFS/2tCMg3j
 gBXpQkpu0WFmjPlWyQsw9PzvuKn1azl5StwFhyKcGvl/kNBe/FXUqxjnA0I0qGxX0bri
 GKeohM0yaruBy5NfyROZZ7gP3vuOD3PdvgiVm/LqPt9S3t1wPZocJ5ndPiLdVyoiHw3e
 NivQ==
X-Gm-Message-State: AFq9FYJgtV32/qlAPai6USV9nGq4XjyaMycnmGWh+snA2+VnlSi5/f8r
 TeztnX8en1qUTkHlBnR2iPHG7wV9927UrHCP27HghViaDn+5+C34/5pFXsrNCXb4
X-Gm-Gg: AYBFou2ekXcam2FvdRFbfs/QXSmG0LcTFe+vwPIlbHpRJoh+TVdgnYoKz8zVdEeolTL
 SK8cWWfBCfIvclJxO6p1TNaUFCpXe8xAGsii9PlFj1319nx5ul85FGZVhfs+ujenvgZLbPpXawZ
 XZk9sATvztAaay9oxlFtrGPvIxzHsgZKAdhX9EEEX3MIG/gJdgO5hqB2gD4yKMKdLtVty6pGGyE
 y8U0ZtkVsWoDU8Ic5WD9yGMYWgdAkqZdAxc/kT+vdNTsayHzWtDdbDQCnvbAEu3PIyzFeFQKM1E
 1wLbOsGXmWIrst6WxiyB0NTImZPedLJJJxqtrSrha6T6YAUUKubtGXy1oSNEn+poAZBW/6NuGp8
 vS3MRru4eYO5e4oYgeztDBgVTOk87yZV3t/vbBOfReiSW/1bfm7czXZGbtgf4e3Ekj9BbuccGp5
 wXRF+uOfrdZSElGqCgNie2JQiILD48X76XC6k/Qv8fTQVicC58Kwo9edF+el9oaNqxCvoTuES9Y
 AcZALJuWdRnCZGOhOmKAuRIHkEFxb1Yj4UHDR6XKbHZsFgT3dLX95fCHQKX1towNyc3xraRdmYF
 FMQ6R6WQ3PhIj0WACyO/cqxbvgg=
X-Received: by 2002:a17:907:2d29:b0:c41:55b4:d88b with SMTP id
 a640c23a62f3a-c4679708c7fmr34909466b.43.1792537435956; 
 Tue, 20 Oct 2026 16:03:55 -0700 (PDT)
Received: from localhost.localdomain
 (2a02-a466-79a7-beef-68fa-5691-e1e5-a015.fixed6.kpn.net.
 [2a02:a466:79a7:beef:68fa:5691:e1e5:a015])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46790366d8sm18433266b.87.2026.10.20.16.03.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 16:03:53 -0700 (PDT)
From: Andre Brait <andrebrait@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, g.goller@proxmox.com,
 Andre Brait <andrebrait@gmail.com>
Subject: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts data
 and hangs Tx
Date: Wed, 21 Oct 2026 01:02:11 +0200
Message-ID: <20261020230211.75665-1-andrebrait@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On I219, a TSO packet whose first buffer is long and has a 4 KB
boundary just after the TCP checksum field makes the NIC send corrupted
data and then hang the Tx DMA. Forwarded VM traffic (tun/vhost-net)
produces such packets, so hosts bridging guests onto an I219 hit it
within minutes:

  e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang

Right before the hang the receiver gets TCP segments carrying data from
128 bytes earlier in the stream, with a valid checksum.

This is the erratum Intel documents for the 82571/82572 (#76), 82574
(#17) and 82583V (#7): if the first buffer is larger than
3 * (max_read_request - 4) bytes and a 4 KB boundary falls just after
the headers, a read is repeated, wrong data goes out with a correct
checksum, and the Tx DMA hangs. e1000e never implemented the documented
workaround.

Apply it to all e1000e parts: limit the first data descriptor of a TSO
packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
pcie_get_readrq() returns 128). The rest of the linear part goes into
the next descriptor, which e1000_xmit_frame() already reserves; the NIC
still segments the packet.

Tested on I219-LM (8086:15bb), v7.0.14, byte-verified traffic:

                                        unpatched        patched
  packets placed inside the window [1]  hang in seconds  no hang
  guest traffic, TCP timestamps on      hang at 387 s    60 min ok
  guest traffic, TCP timestamps off     hang at 402 s    40 min ok
  guest traffic, VLAN tag from stack    hang at 1176 s   40 min ok

  [1] 785-1013 packets at each of 10 offsets, 54- to 70-byte headers

Unpatched, data was corrupted at every hang. Patched, no corruption, no
Tx timeouts or drops, and hardware TSO stayed in use (26.5M segments).

Developed with an AI coding assistant (Claude); details below the cut.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Assisted-by: LLM
Signed-off-by: Andre Brait <andrebrait@gmail.com>
---

Notes:
    This is a follow-up to a first attempt at fixing this issue
    (https://lore.kernel.org/netdev/20261018203215.77371-1-andrebrait@gmail.com/).
    
    Gabriel replied that the stack can still move the headers after
    ndo_features_check, which made me look further. The condition that
    patch relied on, TSO headers crossing a 4 KB boundary, turned out to be
    only part of the problem.
    
    The NIC hangs, after sending TCP segments with the wrong data and a
    valid checksum, when the first buffer of a TSO packet is long and a
    4 KB boundary falls 1 to 16 bytes after the start of the TCP checksum
    field. The headers do not have to cross the boundary: with TCP
    timestamps off (54-byte headers), a packet whose headers end 10 bytes
    before it hangs the NIC too, and the first patch did not catch that.
    Forwarded VM traffic hits this because tun/vhost-net builds linear TSO
    buffers at arbitrary offsets.
    
    Intel documents the same failure as a TSO erratum for the
    82571/82572, 82574 and 82583V: a first buffer longer than
    3 * (max_read_request - 4) bytes with a 4 KB boundary just after the
    headers. Its workaround is to keep the headers in a first buffer no
    longer than that, which removes the long-buffer condition no matter
    where the boundary falls. This patch applies it to all e1000e parts; on
    the I219 it prevented the hang at every offset in the window.
    
    The full investigation, tools, captures and raw results are at
    https://github.com/andrebrait/e1000e-i219-tso-hang/tree/08c29e379bac
    
    Summary of the runs. "ts on/off" is TCP timestamps in the guest (66-
    or 54-byte headers); "VLAN" has the stack insert a VLAN tag (rx/txvlan
    off, timestamps on). "hang <Xm": every run hung, the slowest within
    X minutes; "ok Xm": ran X minutes without a hang.
    
                          ts on      ts off     VLAN       placed [1]
      unpatched           hang <27m  hang <7m   hang <20m  hang <12m
      first patch         ok 252m    hang <6m   ok 72m     -
      check in xmit [2]   ok 60m     hang <2m   ok 47m     -
      SPT/KBL regs [3]    -          -          -          hang <1m
      split at 4 KB [4]   -          -          -          hang <1m
      this patch          ok 60m     ok 40m     ok 40m     ok
    
      [1] buffer placed so the 4 KB boundary falls inside the window;
          "ok" means about 1000 packets per offset without a hang
      [2] an attempt to redo the first patch in e1000_xmit_frame(), on the
          final layout, segmenting in the driver; it could also stall the
          queue when it returned NETDEV_TX_BUSY
      [3] the existing SPT/KBL IOSFPC/TARC0 workaround, extended to CNP
      [4] first descriptor ending at the 4 KB boundary
    
    Every hang came with corrupted data, except the two with the 4 KB
    split.
    
    Limits:
    - Tested only on I219-LM (CNP); an I219-V hung the same way in
      production. The 8257x parts are covered by the erratum but untested
      here. Runtime-tested on 7.0.14; builds with W=1 on dev-queue.
    - The I219 window (1-16 bytes after tucso) differs from the documented
      8257x one (64 bytes after the headers). Intel may know whether the
      engine differs, and the I219's actual max_read_request.
    - Not addressed here: since 95ecba62e2fd the netdev watchdog may never
      reset a hung e1000e (bugzilla.kernel.org 118721, comments 29-30).
    
    The AI ran as an agent with SSH access to my two test hosts. I set the
    test requirements (byte-checked traffic, controls that must fail first,
    identical setups) and reviewed the results and the code.

 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 63ebe0037..704284188 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -219,6 +219,7 @@ struct e1000_adapter {
 	/* Tx - one ring per active queue */
 	struct e1000_ring *tx_ring ____cacheline_aligned_in_smp;
 	u32 tx_fifo_limit;
+	u32 tx_hdr_buf_max;
 
 	struct napi_struct napi;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 834a5b888..f5f5d2230 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4143,6 +4143,15 @@ void e1000e_reset(struct e1000_adapter *adapter)
 	adapter->tx_fifo_limit = min_t(u32, ((er32(PBA) >> 16) << 10) - 96,
 				       24 << 10);
 
+	/* TSO erratum (82571/82572 #76, 82574 #17, 82583V #7, also seen on
+	 * I219): when the first buffer of a TSO packet is larger than
+	 * 3 * (max_read_request - 4) bytes and a 4 KB boundary lies just
+	 * after its headers, the NIC repeats a read, sends wrong data with a
+	 * correct checksum and then hangs. Keep the headers in a first buffer
+	 * no larger than that.
+	 */
+	adapter->tx_hdr_buf_max = 3 * (pcie_get_readrq(adapter->pdev) - 4);
+
 	/* Disable Adaptive Interrupt Moderation if 2 full packets cannot
 	 * fit in receive buffer.
 	 */
@@ -5632,6 +5641,8 @@ static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
 	while (len) {
 		buffer_info = &tx_ring->buffer_info[i];
 		size = min(len, max_per_txd);
+		if (!offset && skb_is_gso(skb))
+			size = min(size, adapter->tx_hdr_buf_max);
 
 		buffer_info->length = size;
 		buffer_info->time_stamp = jiffies;
-- 
2.56.0

