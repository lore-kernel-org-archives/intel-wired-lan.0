Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF01606A31E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TrTEUxic;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=vT8iCsfj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9D6C607FC;
	Tue, 24 Nov 2026 12:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JN1tvEArGBPg; Tue, 24 Nov 2026 12:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6B3F60664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795523980;
	b=jY2hZYAnIr6QVsH/hIiaowJ5h5CE3iQyA3ELewIzHS6NO1rAhMlSGxRKaKMlxFsaUBa2
	 V1GekFbWWKQQN52dIqgkoJKci5cakzle4AxtjD/zkqtyZ72TzCPqp/4A0WurvoXRD+3fT
	 D1MS1vmDZpYthrVtyKbk/1xQyak2vBsi0wdLMxs946tHuHNuahiYb1f/AGs0AlZ4dEsc6
	 5koXPJ4L+rRCYXMo9e6VXwmNo2qdClXtrbXS/V5qkXJnCF+x+Qmb01AaepKsUZZoHRKzB
	 euA1zPPncWNiwZKIq3ocWozQjTvyQ0D4h0klVAcma0akOmIUMu43Kqvcuk3Wu+iI77A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795523980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QtORVVgQvN/m+JUMAsht2JEt8w4lO9qAkjqbkmAaSCA=;
	b=QHF3ez+f0Ay1x5meKNQNK4WWxMMPi3vcWj8axIHW95vfJie7LStb7ZU6Bz13QHB0Ta4p
	 YDDfZLWAvKN4SjKAtiL3mmFgwN3hTXAbgYCk2OBqJJ5LrG9hcV3W1jtj+x3FVx9N2Rk06
	 M5czr1YUNyzKQK02sZFSGmz28kkWDeMklIeznKvOmBZUGIp9qYjQDxGo7m3cigTaH7frx
	 tx1zrKgBCTBEP/H5SVj0y+d2W6Tw0JSsf5fV4KDpCUxvSexFj1YTtSAwlHqLYyfkVsGC3
	 P9a473rFnRPBe0KxErI028J9KXBtmBCy5ISKzsy9GeIk1+CZcts3JsIUJCW+iCZcKuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795523979;
	bh=QtORVVgQvN/m+JUMAsht2JEt8w4lO9qAkjqbkmAaSCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrTEUxic54vXCoxwpLmm1t8xY3+tsEKmrVtUFc2xxbCpsIln9LJBozNORm3zGSdO/
	 qTFgbyGRt/UnWApNizSJmfxDe5AdZngrv2AzICPE6d+xzCPr4CPJL0Li5w+iTxguEe
	 yMfcX8oSOtBW+sivLDlX44O+M2finxITyv2CO1+DNMmDWNMvcI4YiZeWwQaV41NPg2
	 jU3/shvL5kVH2NKWupLmWhYh3Lc0IB5klw0CdGLjyAfh8VwrtDkxZMcSlP1+uGr3ai
	 epS3bK6KbHFPzk6czPN3pTaFDAaY8nBq2NDSwhfF5psaFxaDdxZNvxm8toJUverphC
	 yO1xsdn7J4y+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6B3F60664;
	Tue, 24 Nov 2026 12:39:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 457CF79D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 12:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42D6580D09
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 12:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66dOoXs6NqL1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 12:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B168180CB8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=vT8iCsfj
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B168180CB8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 12:39:37 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jYj7925GvzKm5m;
 Tue, 24 Nov 2026 13:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795523973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtORVVgQvN/m+JUMAsht2JEt8w4lO9qAkjqbkmAaSCA=;
 b=vT8iCsfjaMtpt0qQMoZFmWskzxyxlimRS8aq4UROs6OvNEAVpS+nmYJhfrn3qB/Q0zqUM/
 llBAEN6EJ6xj3Om7lTojm1+HdXHq420TUFge4mzWLBVo+YK6MfROilfZlKpFmQMMrWRbS8
 Zn08BcoVc2Zz1pg8wa/u6HcKs9k+kHZi6nFVTsw+fCw72iytVi2rALJUbtXLKDId19r8S9
 lto8OPXQvsAsI8MmVf7/knS7Llp5KtwvsewWJb04l8azXyPQyty2fndlwkGfISTxqTNRbf
 uFJ3DKcSrVkqydOvZIdyZKI6OCxRJkaT6he/cbXWKZMvrbD8qSm/N45IjXEFQA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <cdf95f8fc50d0ac6374eec389ab1c9c0acd6bc84.camel@dirkwinkel.cc>
Subject: Re: [PATCH iwl-net 4/5] igc: let dev_watchdog reset the adapter
 after a Tx hang
From: Steffen Dirkwinkel <lists@steffen.cc>
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
Date: Tue, 24 Nov 2026 13:39:31 +0100
In-Reply-To: <sashiko-outbox-230897@kernel.org>
References: <20261123-e1000e-tx-hang-v1-0-ecb4309942f1@beckhoff.com>
 <20261123-e1000e-tx-hang-v1-4-ecb4309942f1@beckhoff.com>
 <sashiko-outbox-230897@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jYj7925GvzKm5m
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-24 at 09:56 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] igc: permanent Tx queue deadlock in igc_clean_tx_irq() [1]
> --
>=20
> commit c5dcfb32c435e778dcb0ad6b827b371a99667e5b
> Author: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>=20
> igc: let dev_watchdog reset the adapter after a Tx hang
>=20
> This commit checks whether a Tx subqueue is already stopped before
> stopping it upon detecting a Tx unit hang in igc_clean_tx_irq(), so
> repeated hang reports do not keep resetting trans_start and preventing
> dev_watchdog() from resetting the adapter.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..a2d383f79a29d 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -3281,8 +3281,15 @@ static bool igc_clean_tx_irq(struct igc_q_vector=
 *q_vector, int napi_budget)
> >  =09=09=09=09   tx_buffer->next_to_watch,
> >  =09=09=09=09   jiffies,
> >  =09=09=09=09   tx_buffer->next_to_watch->wb.status);
> > -=09=09=09netif_stop_subqueue(tx_ring->netdev,
> > -=09=09=09=09=09    tx_ring->queue_index);
> > +=09=09=09/* The hang is reported again on every watchdog run,
> > +=09=09=09 * but stop the queue only once: stopping it again
> > +=09=09=09 * would also restart the Tx timeout, so dev_watchdog()
> > +=09=09=09 * would never reset the adapter.
> > +=09=09=09 */
> > +=09=09=09if (!__netif_subqueue_stopped(tx_ring->netdev,
> > +=09=09=09=09=09=09      tx_ring->queue_index))
> > +=09=09=09=09netif_stop_subqueue(tx_ring->netdev,
> > +=09=09=09=09=09=09    tx_ring->queue_index);
> > =20
> >  =09=09=09/* we are about to reset, no point in enabling stuff */
> >  =09=09=09return true;
>=20
> [Severity: High]
> This problem wasn't introduced by this patch, but can a stopped Tx
> subqueue remain permanently stalled in igc_clean_tx_irq() [1] when
> CONFIG_MAX_SKB_FRAGS is large (such as 45 for BIG TCP) and the ring is
> sized to IGC_MIN_TXD (64)?

This is a problem and I can reproduce it on igc (I226) with
CONFIG_MAX_SKB_FRAGS=3D45 and "ethtool -G <if> tx 64".

This isn't a default config and isn't related to the patches though. I can =
send
a separate patch to fix it if desired.

>=20
> A couple of lines below this hunk, igc_clean_tx_irq() only wakes a stoppe=
d
> subqueue when igc_desc_unused(tx_ring) reaches TX_WAKE_THRESHOLD:
>=20
> drivers/net/ethernet/intel/igc/igc_main.c:igc_clean_tx_irq() {
> =09...
> #define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
> =09if (unlikely(total_packets &&
> =09=09     netif_carrier_ok(tx_ring->netdev) &&
> =09=09     igc_desc_unused(tx_ring) >=3D TX_WAKE_THRESHOLD)) {
> =09...
> }
>=20
> Because DESC_NEEDED is (MAX_SKB_FRAGS + 4), CONFIG_MAX_SKB_FRAGS=3D45 mak=
es
> TX_WAKE_THRESHOLD 98, while igc_desc_unused() on a 64-descriptor ring is =
at
> most 63.  Once igc_maybe_stop_tx() stops the queue, the wake condition ca=
n
> never be satisfied and the queue stays stopped until a Tx watchdog timeou=
t.
>=20
> [1] https://sashiko.dev/#/bug/linux-8616c413-3d5c-4d57-9eda-b2849ebf6eb4
