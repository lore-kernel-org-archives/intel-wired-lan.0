Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8892606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yAjVt18T;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Aiv/oyAL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8155340557;
	Wed, 28 Oct 2026 08:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc-T5Gh5ntFK; Wed, 28 Oct 2026 08:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFBDF40558
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177428;
	b=BnarpwxjpDVlmhjOMCxG+Xq37Hk7TDzXKhgqmikqdfYXUoZU5NSt37sTvAr93GlcVfcc
	 h2PaqWRgmG+DRnfHoRQ+bk7KLvswwz/6ot+xx/TPYYyBOzluQAS3wo+dIKUrXKSxGR2SZ
	 diDOC442mY9dgiGADby6M0ks8Kge5WTwmcxh6FIL7VufwrkuDZ8M8hEvVy9Uk553aTf8f
	 B1hNepnutmAZNkus+mn1NK6zdY511HparfCYy59ld3RxD+gEwmiwLUce03y2EF1l1ft1T
	 ID8v81kv/ljEy2YL0e+Rys0eEOax5Wgi1rFSOuybtgRkeNzOekGP6qITWW8G6ZaEEIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
	b=Y24ChvM/O3lRElCvA574CZMKciO+qMs5kGGtMg7pwjDIhvdaQfRlI08aaZq4dtkY3jqx
	 fGVfde+jNCVChPqvIAq2SZQTWvEBTgAOwmCZcHt1S6c0bXZQqsob5Tgqj7o2GUB1h88XG
	 Vd9TpK9hEOWKfsxK6n5Bl68J+WDp6HkMhCxheq0IX0So1Z29GED3/C9S6YYnJKn0oMYMI
	 sYa/MLoMncRkWtGGCX3J+mgeriPOHZfEebvi7UbtlegUnRZk9ReWEvdzRsXCua8HIfjOX
	 eRcpA1IPW4HmjuR1kpHaWw/i7nGRSiA0IROOZWSX+7XlumHAfu08ugnyBfZXLMzZjsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793177428;
	bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yAjVt18TZjx3Hhp0v//r/+GhJTEMMw590gO4U3BCMECFrlO4KTrJpYrkWeknkysd6
	 gmRNfIxfqVudcN97wklNIXklaHEaNCeLr6IRSDIGhHvohFJ7DkWqUnDG/u7QTonjG8
	 hqpSxb7r9Mu70/9JxutSEZJcjj6L/LXCSrsPTRA9c8zX7r0BTlyomlLRm4bL8DJrpG
	 xOZVhmXWuwBFIFlqfXnSNqnaTBQJ7IwW4+J2bcY8KUV+KHN1I6GSGBb2G+9uGEl4fc
	 G05jtE71owmjTbi3kY2wpRMuouYTgIhIm4zqnkMTH9+DpkfQ0oISmvgHNGVTHi9T8R
	 wTe80IOy4HPPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFBDF40558;
	Wed, 28 Oct 2026 08:50:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 656CF529
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B44780CCA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SfqyBlsZktM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 08:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6530880C77
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793177426;
 b=jd02L7CwScDVxApD2fstQANnUE+2OAsphXqBnqJDl9ZNi4CXZ6McE5IWj10dQcIiZsaO
 NqkKmD5Pme7neHMA7wpy4WZKZM7G09wZEBM060UrbrSMIey/YQ4PPxTc5Hk1k0cGdwXw7
 1B8igr3DOgvwEvLLIm5XxuidFZkeq9i2Q1S5ULBNCXKjFmIsBvinszCLUQHNrFlhmDzOV
 clVnvJmbqGObpBMGwy2JtgHvRDgLI0eUjWRHYBO+7VYP5RxENN0LuwvMAfQ3dOlkNG0PP
 wq/ek8c27nSY63bYFcAV7l13XgxXFYkwwkhP3T3HtUOcDGwBGkqiO6rHBdNoTyw2rrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177426;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
 b=nZS2MCh7h6qrdnMA8ObPJpg0lPSGJpXPXSutm2Cq4lrw+kVj9zqtwpEEVr2GqQz79yo0
 NRyB3ifTaz75qhHpa+LJ2lyEppHY9e8ShLRY4pBiTOwbYgiK7cHDJ1ur+hqbaOgUSSnK7
 R+Ei9Cv85iulIYDV7ikBMHvuZQqdWXMS/lI5fJz8LI/wq28cdFxvq4Ij+bA/ravBB/TEc
 pssHImRWeNTtUhRW7zpsQxiykAh8lYGzEuE4XxZbdZZyqXUfVrasedt0R5nYEggpfw7i5
 eldpRKlnDjzckrtM9ti0H6EKoL1XjlgN172Kfg8sH16NyV5cj7zSLN4+2Xw1ABivMdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b="Aiv/oyAL"; 
 arc=none smtp.remote-ip=185.70.43.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.20;
 helo=mail-4320.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=Aiv/oyAL
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6530880C77
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793177422; x=1793436622;
 bh=ZzkyzMXwhe6xNno6EsFST7VZQ034OlMe3wk9yXIAjBE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Aiv/oyALvt2n3RZQkF31lOr2djiawuA5c9HAMMHEy4LA6yEqY6v3kowkl/zJKev5K
 DpHG2UX0a2okCA3gHxrzt6frWe4oZhNA8m4mbeSSmvxiNDKKzGENE7Jm+oMMO4J5Lw
 9dUOxcjWPEUjRYW3E78JqSbO0jXBlX1OIutdf9u5flB2JxfNcmFo/JskbET/K//T+b
 HF7asdf3zAEPr0iob4qOo/M8Wq91Z8zWdrfA/FzD3oGhbnm3zHhAfDHm9KGjDhBmy/
 fXMrg2jIKbNqyniUQMAc7avD0jwf/uEPPlWkrA3n+Io0BE+qU3x21/BRhTi3LnVAoi
 Dgazhxj00nXvg==
Date: Wed, 28 Oct 2026 08:50:17 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, maciej.fijalkowski@intel.com, andre.guedes@intel.com,
 jithu.joseph@intel.com, vedang.patel@intel.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Message-ID: <20261028084919.3059158-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 3c834f9f3c809d2e7ba6cca99f25171716b11d0b
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

Converting an XSK buffer to an XDP frame allocates a page and returns
the original buffer to its pool. If the TX ring is full or DMA mapping
fails, igc_xdp_xmit_back() returns an error without freeing the copy.
The RX cleaner cannot release it, so the page leaks.

Return the copied frame on TX failure. Use the RX memory type so native
frames remain RX-owned on failure.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1..v2
- Sort declarations
- Update the description to match the initialization order

v1: https://lore.kernel.org/all/20261023141317.3904442-1-p@1g4.org/

v1 testing:
Tested on Intel I225-V with baseline and patched kernels. Physical
pause-frame backpressure caused 46 leaked copies on the baseline.
With the fix, all 72 rejected copies were returned once and freed,
and all 192 copies were accounted for.

 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe..d10dfbdb1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2488,6 +2488,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *=
adapter, int cpu)
 static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff =
*xdp)
 {
 =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
+=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
 =09int cpu =3D smp_processor_id();
 =09struct netdev_queue *nq;
 =09struct igc_ring *ring;
@@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *ada=
pter, struct xdp_buff *xdp)
 =09txq_trans_cond_update(nq);
 =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
 =09__netif_tx_unlock(nq);
+
+=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
+=09=09xdp_return_frame(xdpf);
+
 =09return res;
 }
=20
--=20
2.56.GIT


