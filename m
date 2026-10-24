Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AB606A31B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Qut3Qd1l;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B98jWev7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40DB640ABD;
	Sat, 24 Oct 2026 00:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZayyWPM2_38; Sat, 24 Oct 2026 00:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47F4B40AC5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792802807;
	b=pzQcOqG2KNA1G+BMaAEDzCgM7K94PsDhagFHt6RICTo+fCFeHYdZwghJMs6R0cfbC9tA
	 FZDoJnUwsx0sBOB0jXtyQkfjZuej4gWKHEijqVIaoMyw+rrgjJazjlwbXooH87xjAu+9a
	 8etpkVkIh7lbdPhuF6+8x7Tnl3ppF336dMFsa8lYiusuLjPIZ7IyVLIho6/KVQylFWJBB
	 9MU2CA9D8vbGx1i+mHEFQrsQMMbv74VsrECQ0pOKUe/FTECzNjyy49BfPy1VpYTPFST3T
	 f/h6L71gJ1Ys1YcCwYuPQlIGgN1PxeuVOpQNYBfS06waUYYjyXx+OXW6ZVOKI+vBppg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792802807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
	b=FYAQndI2wU0RzCDd7MRjGBz3n9o1bWZyneTd2e6gJX8xdu7lXjl99LNJuf0D29ZFjGB9
	 yL9iMieMeruc8SiOtV7/9Q1rk76ODRp94diwP5ykkblRcO2I+i3fqR2UG8iM6YNdMfFGx
	 kf8tZ4LWARbzkhlNje9/xq4rBs16jl0kmEPxQegcKy5BVc0QY3u3mJ5wuq9/QkkglWruY
	 rokdJLSRA21cWYdCvW5geBH7ptXXbYs7IcJC61FYGmkGqCfgNDJizP3++ACfV410ml/hD
	 DUGdYfUo/gkfqZ0wjmWRAlEfYrss0sUenlvPYnj+XWdu3i6IW2jPLKpyCqfYJ6l27DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B98jWev7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792802807;
	bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qut3Qd1lVHHP3vxM6OeuX9xkDQQAgjpJqmMI9X9IEyx+IuQXs0Z7Tqkda7HtHpBXH
	 ANxJ9tIlPlAd0HeinDnECTuDqWFS7ryM0aXhjh6LZPHkHm3mRnWgrbr3gSXAqXKWPI
	 fwNykzsT6l1e9LIZW++8NMKpkVMP5HHGYMt6CgcAyWXUiA8nTooWoOMn7ZEozg3ToV
	 I5YnWJ3o3ReQIUcJKkptp74ltLg2ut9kDpp3KNzN5NQOyhibvrPoa1vj9EN57oUIk6
	 SpcOIpnxmfxxazH2bd2Ked5hM+LHSAPuSEtscgWAOYZxzn8SWDFGWwY6UspgtD9r6H
	 ykLSrpVbJLcKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47F4B40AC5;
	Sat, 24 Oct 2026 00:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 648403B6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 00:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 560B840AC5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 00:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bw0ZgWUipnLy for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 00:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11A6D40ABD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792802805;
 b=UvjIOg3vHxAgKo4PLWS/EW1UTWyibcM/432fUTHctNGRnQQs0pXQxrSOFmk+HXinsiZC
 MTig0vH5+ZSRrFyB0Hlba8NPfLD4OBSllI/QLGasfjfy9s/O7OOHMZE0roc/CIL7Ogozm
 r2nRTGFdoZ/GcICh4bDydFrENd2Xs5zEHSCDGwh3BpTyLiIfGXFxLgV72DnBVegd1Ah54
 TYZ/tY5QnyKCE5REUOZ4P37jWNDykbG3qNX4oJEiBJb4a4cM5kXBkWM/r9lChhoFpUig6
 T56K3IUCZiTV8a1UTfoVQGE/E25A9iwhTlIFmh/Nq+Kw/3bcX9LtLAk5KPMB73pBivg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792802805;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
 b=XFvBlR3HCGdk1/em/GRHbXGD3Zqq74KRpHp9kDPdczJrrc2Pp5xOTJmmmM6zXkhqeaQn
 dd/kEXc78/DKd5Fur3aBgimrDOQdNkzmwVcQ6JLrUZ2WKEaXXBZB5A6HZp2rzZNWZ5Ch6
 PV9BB9Z/LouPxsTIdq+YF5gU8F9qibkft2TrXoDP00Pkr/jMaVAlG6CGOyathNKuwFZ4n
 gAf99P65myZzyANMy2t4v7VJOUptZIaI0zk8NWgYW7OhJiGEHf4LV0sC9ol+1nMxMsBpd
 k3GrIJtFJ4GeJ8hK/Wun7HF/AHeKj9DZs43P8iMD0sLE1X8EYBXtY++aogfkcmCfWvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B98jWev7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=B98jWev7
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11A6D40ABD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 00:46:43 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c414e5d282eso165111466b.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792802802; x=1793407602; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
 b=B98jWev7ZWrUTHNe80cDa+ebWNF/PswLOBT0SRW0SyOmDJLxHHHtbl9TrEiD81uVEH
 7y64Hn2FNRJB+FtO8sySXSgtlIAp8YEGW7EfqOAyh0KcGp05aUAYmLmrHulreovIPVXm
 pOyk+HMgb7kzDSmdgK4vtm1g69wHs4bLD60+a338CmxxEgndrxzShWeowKCmxiupfm0e
 mBMWrKFEX38vVL2+bav93V8ufIFZv34ybrvi6KFCf8TqNPZdIyQlmJqRL/svuhYtZGxQ
 DCIUmOn9OyNy/UsLfi1V6zjjj0IzPlVZXk3ot8uCu/DPQhl2fo5MSpgLxUQvi3Knb3ik
 lvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792802802; x=1793407602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
 b=IAQI+FxxeuTmedF6GQgc1ObHOhjecvfRFhiNwPGH+GIoIgI0wrUS86pLDlX9zBFjxx
 b17m0dsOhmHwaUkbVza48j56oKkxPxRjKt9Qhv5OR8YHFU9r5j1as+VPC9RE/+vm36aL
 rnbxa1jDRLBAzi9G7Q8kFQ0Hl64Fjnc0P4ko1mKdZ5yuw2hTIvgfGEoOWIQOZ9pJ7xjN
 otrpO+ifP+kwC9tmbrqx8DPlMhR2akN5NVbI2Ij2F1i1gAPvYwlyRUN7ggZVTbz2iKqo
 +2tPw59b0jnk0xvLUwq+JkuKY6NfGSBO3YuFffmOf0M0/qWFAxbhrmNDbZbts+fXWf3l
 4LJA==
X-Gm-Message-State: AFq9FYKaILuzfgudpNQA/IMC+zMzF8E8ah69kwcV8GZd2MQF0WfsyOx3
 CZJOF+A1zdr6TgXu5EWytUDLNnX4m1OTAV8QxIapLkbvxSHpk/vVpa4MCj6QfWMJ
X-Gm-Gg: AYBFou2OHyEn5WyL8Y5XQNi63K1NLN8I0m0FBBC15OJs91cD8G4doEC3m+bdimUEGTF
 SKT/piPsJtknE6kbpUcsLpb9TWQnMpBCleIeOciLw0mZ/7PCAXW4ttACaeAF7UVaY9QZcnI+zIn
 WFzKKzq0hmOV6pbSsIKjfjPPuhnMuuBF6tMsDYM/5UJbaQw5Y5uXN8FbB5S66G971Y6TzU33I/D
 ZF5cV8ToEYrJiqwq1Rbp20x0OnCz99o+i+8bEZ7iJuWQLqD6r6ElZNpjXlWqhpwtBl7aQkdC7g/
 HHG3b/achfnb60siROIz8UMX9jPnMM1reQnKFa87zlSITiZbLLlruOVPsYf1KYSZ3gmlngiFeQ6
 mDqCt0HcfZDCV7l+OcUbrTnQZgiJCH6YLmsuzG83iOllxwsMH/UwGh6uKHEjIWbNBNXKvy5K+Fq
 /pexL7IsLt1uIqPnH1rPxQl4tT3+MTrn5uoCr/UumtSAZbENYUAlNaI0BS+M1Otje8d/XjoL5Od
 S+r5yXmQ65d3gF0MpiBZUHYrO6sHg7lcKdxSHTKbV0eA4qEHRUJCkwrLGG29SK/eGDhqlfzzi54
 KKODn6Rdl9rQw9VG9Bxgc2x70i76/zeLXPpoVenIy7FGS50N2AbDiioDInFysl/ttdQFL3t59f/
 wdDFNz44Nygt6Br9z+nWz/lUIIcsOdnw=
X-Received: by 2002:a17:907:6d0a:b0:c31:be58:5dde with SMTP id
 a640c23a62f3a-c46bdea43d2mr54564466b.40.1792802801610; 
 Fri, 23 Oct 2026 17:46:41 -0700 (PDT)
Received: from localhost.localdomain
 (2a02-a466-79a7-beef-592b-860d-a608-4c37.fixed6.kpn.net.
 [2a02:a466:79a7:beef:592b:860d:a608:4c37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd79b8b7sm25738566b.78.2026.10.23.17.46.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 17:46:39 -0700 (PDT)
From: Andre Brait <andrebrait@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, g.goller@proxmox.com,
 david.laight.linux@gmail.com, Andre Brait <andrebrait@gmail.com>
Subject: [PATCH iwl-net v3] e1000e: work around TSO erratum that corrupts data
 and hangs Tx
Date: Sat, 24 Oct 2026 02:46:30 +0200
Message-ID: <20261024004630.24579-1-andrebrait@gmail.com>
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
the next descriptor, and the NIC still segments the packet.

The split can take one descriptor more than before, which
e1000_xmit_frame() already reserves: it counts one descriptor more than
e1000_tx_map() uses, a leftover from e1000, which spends it on a 4-byte
TSO sentinel that e1000e does not use. Comment that count.

Tested on I219-LM (8086:15bb), v7.0.14, byte-verified traffic:

                                        unpatched        patched
  packets placed inside the window [1]  hang <12m        no hang
  guest traffic, TCP timestamps on      hang <27m        60 min ok
  guest traffic, TCP timestamps off     hang <7m         40 min ok
  guest traffic, VLAN tag from stack    hang <20m        40 min ok

  [1] 785-1013 packets at each of 10 offsets, 54- to 70-byte headers
  "hang <Xm": every run hung, the slowest within X minutes

Unpatched, data was corrupted at every hang. Patched, no corruption, no
Tx timeouts or drops, and hardware TSO stayed in use (26.5M segments).

Developed with an AI coding assistant (Claude); details below the cut.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Assisted-by: LLM
Signed-off-by: Andre Brait <andrebrait@gmail.com>
---

Notes:
    v3: incorporated the changes David Laight asked for in his review of v2:
    a comment on the spare descriptor in e1000_xmit_frame() and a matching
    paragraph in the commit message. The code itself does not change.
    
    v2: https://lore.kernel.org/netdev/20261020230211.75665-1-andrebrait@gmail.com/
    v1: https://lore.kernel.org/netdev/20261018203215.77371-1-andrebrait@gmail.com/
    
    The investigation, the test results and how the AI assistant was used
    are in the v2 notes and at
    https://github.com/andrebrait/e1000e-i219-tso-hang/tree/3764faf44ab6

 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index 834a5b888..cb3b530d6 100644
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
@@ -5905,6 +5916,9 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 	/* reserve a descriptor for the offload context */
 	if ((mss) || (skb->ip_summed == CHECKSUM_PARTIAL))
 		count++;
+	/* spare descriptor: e1000_tx_map() splits the linear part of a long
+	 * TSO packet to keep its headers within tx_hdr_buf_max (TSO erratum)
+	 */
 	count++;
 
 	count += DIV_ROUND_UP(len, adapter->tx_fifo_limit);
-- 
2.56.0

