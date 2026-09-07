Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12FEC79FB1
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7001E40621;
	Tue,  8 Sep 2026 15:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hoRyt00zCgMF; Tue,  8 Sep 2026 15:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9999140634
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880441;
	b=ls+rn1Wagd6wGdbtKhtcMvXwFxVEZEthmITYp8oF7/G8YBIIF6Vyc0Z4fBzL24SBhCsf
	 eBsOlL9qgUdYLvjyEQntnJHNRny1bcG7OVAeb1lDq6b04U6sWYRZ1Jujke9wj0CgFejdY
	 OKzq4z0GmO2zsXEx2zg8h1TydGR3+C7keUKRRklCEGVrxiL6Ep8g+WCN88oq27ROTebo8
	 AVEr5CjXDVn4rjKw/XnnuPXiawrt2+QZ6FjSYWOOIJburvDrBHSSEwC/lWrKBExBpSna7
	 nLqmak+d/e/jLdkdt3TIq27o2dHTWxLc3Jb0lnMgpZkem9fnvrt6/5S2iK42G0OSgXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
	b=Sd/T0ehw6MXdI+2ZtBAp03UzW9Oxu1Lhq2wcFNILnDj1rCE/oSmed6jiQ+h9kl5kSEhR
	 rmEehIHv2pZCzCWkVbSi7EOsrzGDo5oiCu3HhZDhJSAwZK5UrBW6O3Ncgr7/wNiEbuAgx
	 pdKDqV+lEjiR6Ipy3qI1FSzWAQU+eScOuafQVCAoMUVV+Dxh0w9t5tDauzygGvh4iLQfK
	 W88viGQPZR++TiYROm1CHXhct/JD+2ZubDGyd1/BPtr099i96JnPATLLcMPqOsK7mFDmL
	 b6YUgtAnyyW1XBRXDsHWBzsZPHQHz6yRoKasAfsgx1ZzqpTcGTOrG6a4g4cNOVPIGUA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880441;
	bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMlXr7YtgsMkmB/A+v/C7uWk+yyjjAmKYi6kty22byKJAcnqX20kSjCQRCzRwD6H4
	 fepKfYWM/RXW3q0X+hrSJVPKuq7n4yWy62iuMdwv5kF1eUrpDWPS4q0ofuj0x7Qocf
	 3iMKWEYjXzgNZK5DMHn5FMk3JuMGpQN+kDg/oaqvbELhKKr3Aic08z433xPZHUuCzf
	 D2O7qcN/s5/UZuG3IgRpcZRZQNHu7M4L4dJXxvv720Mxn14/frekl+Q72qEa9wk/E8
	 dl7P5cRDNUv5/MYov2Kdws5h1FubrdE7AMFMyekjBy7O2c5vZ+UtR49YC8uGiJALTh
	 g/R8Uz6jR+YsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9999140634;
	Tue,  8 Sep 2026 15:14:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65A1CAEB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57C1E400F8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qy0V4AKXQ-H for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 82779400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788774909;
 b=TMjB/DIubMcrsu7NdwD3GCU0KmGHkoUQsD1GtSgaETE6lUzpl95C52s0PHr3h1QdjSrq
 JITqjdoSPmX68Ik4VBUlc4Nczp/VNnRWXxs/BL1Rpllgilc+9ur/c18LWK7l3+HNpNSRO
 te2SOUpSLxE6GMqikW+EZG+djgUnAXZWsJAELViCVAjrJEBYZTahlssauZK3jtfu1ZLKu
 z+LxO30USQ9owTejqwFEVRV6RwQ1SXu5fo6zSUQD9mmG+7Vbmj5te8mbSJDvPZfP+E96Q
 Ci0mN35g6kbN3BEr6LA9hkaUE+u/ONMlCuIdSwnMyrqpfCAtdk3qb7q75PMElGxx4MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788774909;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
 b=ra5F17veGv0h3NiolIuPioRd5S6x3N4U5fdv7BkcsDZWvbv4dC+ADFRZmqokxe+WWqp+
 l6BzZN9Xq5XD4dbnP7krZwu+yNIpEVBdm6L5BBSi7U7tVgOaqOCJhq2TWaDxUa9PtlLcJ
 uJaM808p/3sFNFWkpTkOOjkLdRMsWErfj3sPOUxcOattv3w33szreJM3r4oDnjjNgDRy1
 D/AqtDfaxklqkujvGlKj0FMxbwFV5S1HLmbqvEzK8pUmjGkvM2ZMVJsZTSw2ClRIeKN8v
 fyx0s1zGJa+cLHj1E04oMq/4Ynut64w1vAC6vdkfsEtEYdJpxWHtAFeWPq+ohKLMhCQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FGrxrhZU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FGrxrhZU
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82779400D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:09 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so3057440a91.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788774908; x=1789379708; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
 b=FGrxrhZUhXq8F18Bm+F8gJHwZUvmhuWxYXJJnJy0WcuQ2WT4aC+AvBaYzGXk24P3MK
 oF1iVb+YzaLSxyVP/vbP9iTHs+MUR7G5LZHj2E+w0BBUIeLimhYXduml4n5ZYxPWveyD
 BWGYSsIEMRYg6lhUeM2UuD4EJjJaZ8Y3UlqlyFiBl3aPCJyCHpzz+ASMfxrguEG9jFQs
 ZK/uDBJa/4oi9u371tAo/AfqNNNCcn2kPnVCs+pduaaMEbuo37nwOqB5PWN5XNw1xwkV
 cddsSp/Ku/DxzzofQwpdlxvAT7QPLobT0y7yqBB2FU2hoPQksvI/N089yZ3OWGNU7Uwz
 DqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774908; x=1789379708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gm+TyPV1iDM9aVdXh0QUxUBtbEP62ax0fUff+nPkYjU=;
 b=UiOn4HgZ/Eu2XsPyISD1u6n2BCzTWnNlSH5qTtm8NMkb0ptdWOw+wy2JZ1xdejfFf/
 jguKHiKc+92iXZBU3389W2datXCX+ENtIuyhXiMvDg7mig4us8N5Aqz+giOXJHgpe4RX
 4LVmcf451yDlrAVqTqIfg0KlY7LidC1tkGfJZwXEZ8ihvDdlH75JoP+5iwdUrX5/N0wV
 Qa0Y2wPZ8mAMeYmS9Kn4qeUQcCPZXa6/0thwbSaHtYT2UHN56KepR5Psvr7DtvxIbKkc
 2ZBxDRq1l6DXM1cjbmh2GZH3VjbZRkp0NbHGUtcGHanq8esGOVlfwoGnrE/fRAiqMRGD
 h1CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVnwEOJ+d2U0T+K4Hg4t5aRreAWgUSvWHg/2l059WqpNLnOitmX0do1UQ6vSYyKje1lreYl5XcW/YVvBNdOlY=@lists.osuosl.org
X-Gm-Message-State: AFuF++lCLsNbgZRyOv1//I6nFS4tPowCBrxWoUQYoPGrfsJ6P0fXPECR
 70w0MwKP692ApmjNjebx5bednRD+gIiqmrfVlOm0t3WjLRR08ePj/Ihe
X-Gm-Gg: AYBFou1ktscruo7821G6rerTuGR9GjSbTShc6zrP7a2wdGfVbTZpUua0ZYrMOJ14dFO
 QjJMLy7mZ+H96+eNzIujVOTklIekLAecZa0Os0nAzlaHfrg3O2t9ipZY0O7PyZCMbpxTh6Zy1qZ
 llNpigU+6L+3MilZJwgupzU1vF2c0UuRf4mWSGQ7QkcfTs9p1CU18oijpfs6o3hhIaAzqVjf7/E
 d99se5RkdYulRXiq1RWTEssgEGRBMpqmpIazLTxqikKDeDtQIhGZwqET6CKbatsWPKK0PT+s0g8
 FU8sqmjMUI1WE4Mjl6gUpKCfPQjrbLjTW3UzWBeV/9KlztZZuZD4Gs+BJD79q4EsBXKccJLm3z/
 y9ComZnkZl4EWDjGb70w/l2VjZEihhrlIlm2cG97mHqyrWifj7TwtTMUaRKkfdE7Eqc0ekbRIF5
 RVQyPKNdg/9UkZE8XkhZ1kZHSZRRD3jQ5cTblk3OIIZwREzjdllGqbNZEEe2+7pTRZRlyk9s0Vr
 VNphnhB07k1jw==
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id
 98e67ed59e1d1-39b2623abfemr31923733a91.21.1788774908390; 
 Mon, 07 Sep 2026 02:55:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:55:08 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 3/4] ixgbevf: fix typo "enble" in comment
Date: Mon,  7 Sep 2026 15:24:45 +0530
Message-ID: <20260907095446.27290-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

Fix a typo in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7ce46b4b4821..7eb4acf59dab 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
 
-	/* enble IPv4 checksum for TSO */
+	/* enable IPv4 checksum for TSO */
 	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
 
