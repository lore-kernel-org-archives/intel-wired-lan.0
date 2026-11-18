Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2317606A320
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xgMZ0AQh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPl8COpf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CDE5810A4;
	Wed, 18 Nov 2026 14:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OdAf4VdQlx5z; Wed, 18 Nov 2026 14:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 106F681247
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012376;
	b=Q8chJ+CL3CgtJErxi/wRdL4P/0Ir0n/1mFWXtxT4tLg0nmeijvrgUckpzCUe/Lda4+WX
	 RGd8X7z4ZGm+YYq8wHJFSz4NDWjfVQcddj01yLrGamuK8L2BAJvEsokFXztaeFlSFzJwa
	 Rd7e/79oocJhwIF8mcwwGpz6am+gXCr7tPMRkspaEjpS/IOeZT68Fsg6yEAzWgeDac/1H
	 RHLDGGL3P7ZutguzBzyBPabH2JwBNG9i9AysR4N+drgkNvErxSj/QkdElVCb4AQ4oEDGz
	 L///qCZCH9oMN6V74f9hmEZMvodTGJOusRIdklD9epBjXFwR/R6h3y1oJAcF7zMUQSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1qMDZq34OBzonT4rJzzUXxJIMu+zEtHTKKfbGDY12zc=;
	b=qzJcpHLfYocOZWo8HIgXPmL/39PJhoxzoAWIqTI2d6ksIkHw+2WRoPndBXQMbeP511ih
	 WeL4lvcW+Q2QGxnybkeEWz779AweC3iGzzzwx/6ZqHSULzXks5nsh0R2UwG04jAYdP7cV
	 g1tNs19SA7whvERvl7WcXY3rS0HnipJESBybY82D01rs8Ag0SbyE7xpcODjT/IaCr/5nG
	 bZIxqp81olmrMnXCSjq0nVi9c9zzn9oRNsdXQoXKnGYFbkvVPe2/GDjbPkBi4KlyG81zV
	 orvBxzGAcTVdvlkesmy8SkpsHIqN6+IVklNqF2g5zPl3QU3qhTJrSp0dChV9RJdTPZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPl8COpf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795012376;
	bh=1qMDZq34OBzonT4rJzzUXxJIMu+zEtHTKKfbGDY12zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xgMZ0AQhfKQW+slagXIARXkZ48q1AZZnrZBxagsH/iwrbjeDgiYsHObOIoB4QFyFA
	 Al1CnuX0WaD/gulbkaqzTW0inLVzzHheyWqNBE0+rRM+ZawFfBWdgUny2e/ZBNu1W0
	 JTXm/6iVmGTSNeZehYPZLJ7B2o0dSUpcjohctMVCyxkPXbsOl4mrNjWTznYvwybC2w
	 XHO5qQg0zyPRq5/t064WwsTl6xaUJTyXTEK/se0pmbfLDzG17i0SRf88gdXqparE3Q
	 B6DpNPFsX0wpqYF5r7mPA67aOWRfkxAqopI3QWK1j9GPpl8nFbfW0UkoJPxNb82yu2
	 bfVQ6t9JbGhyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 106F681247;
	Wed, 18 Nov 2026 14:32:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFE0C49B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5BC681247
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:32:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcbQpOqsBWZM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:32:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B689D810A4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZPl8COpf
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B689D810A4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:32:53 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so707617b3a.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795012372; x=1795617172; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1qMDZq34OBzonT4rJzzUXxJIMu+zEtHTKKfbGDY12zc=;
 b=ZPl8COpfOLQgvtBqovA0hOj3lD3yx0Qvb1ffBSHQJrLcRWjY+DylwpQymywIJeRP0l
 lVE0F0D4d1gEXGTu2gaf1kCvGIYxBhmKSzRQdXhXstq8JF6DqXCVgE+VCOvbqSw2Z/X6
 1VO085XWBrPo6WGsQxzSAjYNecI6QMNPw8ui4s6tzVyLHT/ITsbv99bQMkLQJjy+btMY
 2iGp3VpxqRla3knm6zQZ6DV71/50gF/NTwGSZgY/1iyLeimmu8YPjIFikv9Rzpv2LAWC
 qr90cvJpCPIQAgZB7GTVuxiqWs/LojTcz8Udmz96hIiS5vCXWdfLbP9BeYeX3NSBq3E8
 9iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012372; x=1795617172;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1qMDZq34OBzonT4rJzzUXxJIMu+zEtHTKKfbGDY12zc=;
 b=q4Ejy9ch5TJVcaXu0ET/y+oW0W324W5Jz5PdWs0e/qkFwZ17ZqXQpzsmyQe/lU7M8Z
 j4bm9o+pF034t58xrTNTHghAUGw2fIPVEnROgzUhepibfnL59cJ7j+ztGjwghYGzx4jK
 weGzuCxIwnZOHbVnvdw/4VnwdWYVgsRFcxgYwyAH1nKBnwHk5kPLXaqGke488IooIGYy
 jYs3GIcTHJBS1Hn48jHaF02yrwB1Zrp+jPFC97Kq583V1KtdFbEJxs51XQrpG0j6T9So
 q7Czri8c1DVzu7SFHT5XIpoSpz7CRfZFGDuSV4J19rPXd2aawFrHs5SWZjWwDhWHE4qD
 CU+g==
X-Forwarded-Encrypted: i=1;
 AL+hErGUUURCZQhMTKV92ChAhwUdiOLPGTUAW2i92orJzi2fZTztfAKF7njLiboEzBpT2FgWzk5qfiMSgpGJE7TZhxA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+5pihunRD+EUZ36KsltTB0LQWj3iz8+x9vlgl1ITsqnuI6vnF1
 9i+3orGQa3O8o1KC4D1nLt/IkyhxyFI8T3731uwIaCC7HE5S93EOGUqlP8CSPdasAms25799Wip
 AEvFG0UmiGwY9nNfXxifYBZe7i4gbM4g=
X-Gm-Gg: AYBFou3a6lDrpLkmUUxYP5W35ar+F13scr/ehH6ume3WggPuzss5czUx7j2G4/r23Ew
 V28bY6W+Ek2smEu7NPYCTws2UUPWu9wcPwO5oBXKzYDqIxDRKMDqxb4dirit/lT4Rj23qe+PbDn
 8f276Iix5dUITZ7krDZ6i+XqDtmMv7SZwKjqsefb6+zv+S2zJFZGGikWPKqPBYqFnp+FNc80zHs
 nK1HKECjRodpwqa0/EJ9Dt2080NLagn8yOkNZVHN+lXJ7f6gBDfVL1NGZNKucukFZIzGsYbBLJa
 p2FhGDJOg2j2sXIDorQcUpeZbMUqLs1g1Wp94aZFBBIqc04Y1+0yr4coMeJUhYw5biHlNrnhOG2
 E6lOLYdaWcmutl5qAKPChm8C5ZswJwwFNmMPzVr4=
X-Received: by 2002:a05:6a20:5483:b0:3dd:a006:ed90 with SMTP id
 adf61e73a8af0-3fe89c1711dmr2945264637.38.1795012372364; Wed, 18 Nov 2026
 06:32:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118135920.1063665-1-magnus.karlsson@intel.com>
 <av2zp3AEAB08afQa@boxer>
In-Reply-To: <av2zp3AEAB08afQa@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 18 Nov 2026 15:32:40 +0100
X-Gm-Features: AclHuK83Zhoh0Un-O_cRJvBPrfMisFYI3l_ZXfwUVVUkBX2p1rY_2JB6gEzRg1I
Message-ID: <CAJ8uoz0Cr5ZFA9GTybTgw7TB_0+hO3yegayBg0r9n4L8cnTtkw@mail.gmail.com>
Subject: Re: [PATCH iwl-net] ice: reset xdp_tx_active when cleaning a Tx ring
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 15:18, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Nov 18, 2026 at 02:59:20PM +0100, Magnus Karlsson wrote:
> > xdp_tx_active counts the XDP_TX buffers on an XDP ring, so that
> > ice_clean_xdp_irq_zc() can complete AF_XDP zero-copy frames in bulk when
> > there are none. It is incremented for every XDP_TX frame and decremented
> > when such a frame completes. ice_clean_tx_ring() frees the frames that
> > are still on the ring, both through ice_xsk_clean_xdp_ring() and through
> > ice_unmap_and_free_tx_buf(), but leaves the counter as it was.
> >
> > After a ring is cleaned with XDP_TX frames in flight, for example when
> > an AF_XDP socket is bound or unbound, xdp_tx_active therefore stays
> > non-zero for the lifetime of the ring. ice_clean_xdp_irq_zc() then
> > always takes the per-descriptor slow path.
> >
> > The ring is empty after ice_clean_tx_ring(), so reset the counter
> > there, together with next_to_use and next_to_clean.
>
> Has that ever happen on your side?

Nope, but I never use XDP_TX to be honest.

> Maybe to be sure we are not leaking buffers we should teach
> ice_xsk_clean_xdp_ring() to decrement xdp_tx_active for ICE_TX_BUF_XSK_TX
> and on ice_clean_tx_ring() warn if xdp_tx_active is still non-zero?

Sure, but does that belong in this patch?

> Feels a bit rigoristic, but I think I stumbled upon some off-by-one bugs
> where we rely on ntc != ntu loop. non-xsk clean goes 0..count.
>
> >
> > Fixes: 59e92bfe4df7 ("ice: xsk: Borrow xdp_tx_active logic from i40e")
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 35a480a1e172..f26646825a1e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -228,6 +228,7 @@ void ice_clean_tx_ring(struct ice_tx_ring *tx_ring)
> >
> >       tx_ring->next_to_use = 0;
> >       tx_ring->next_to_clean = 0;
> > +     tx_ring->xdp_tx_active = 0;
> >
> >       if (!tx_ring->netdev)
> >               return;
> > --
> > 2.38.1
> >
