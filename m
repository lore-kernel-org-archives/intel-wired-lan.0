Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68948FB5E8B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 23:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AB0C41093;
	Mon, 16 Mar 2026 23:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbvxaX6yoWge; Mon, 16 Mar 2026 23:31:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6465410B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773703895;
	bh=3sg0rNsK9i6651ldWiAXg/gl9hLCFOcU8hjf0CpNrpc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0yN96DYIkboI6gFP9SAI0jbn1+cDglwJVa19XCHg1ZVAw/4zl9OyGVJdfAfM7LJb5
	 Ai9UKa2WeSl3oJdTxMYQMVAKjvOVr+PGnXDyiHxoWpO8XK5k8F5hvLf8fTjynvVu1k
	 J2VnpDLMw5O+hWnu2Ji7lcvQ1MCje4TsUIFzOWfv6O8/kysLvQLUHT2McWQBr/5tga
	 l5XDBCt5rCqCCeru1TZY1NwXR0Wxb+VVd7lhraX4sn2CNiKbeQ21kHvJzlvcGFzgJ8
	 4ucj1BHt9GQ5LS43O/nQwEEBVCRMJSB5S+U2bm77sc12jqDsIQv3VjPBDIB7xlKgKM
	 6kbQrdssDJikQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6465410B1;
	Mon, 16 Mar 2026 23:31:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 24FB43C6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 23:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1673B4093C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 23:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mc_x0SSO64Mk for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 23:31:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7364240074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7364240074
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7364240074
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 23:31:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4589360018;
 Mon, 16 Mar 2026 23:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A749C19421;
 Mon, 16 Mar 2026 23:31:32 +0000 (UTC)
Date: Mon, 16 Mar 2026 16:31:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Message-ID: <20260316163131.2ff161c5@kernel.org>
In-Reply-To: <87a4w9p95i.fsf@all.your.base.are.belong.to.us>
References: <20260313071322.3489243-1-bjorn@kernel.org>
 <20260314093518.43b820b7@kernel.org>
 <87a4w9p95i.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773703893;
 bh=mokbVaSNGRbUCQQ4SGbI4E3yKDImZ3QdINhNbLzi8Po=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hN1fRzFkuoAPo5qf7cCUj/3UZ74Zrg2FGMIpeV+WXs3DgSmup1ufDh90hMZjFc0TC
 DFJ5TZCjZPQKQKjORnD6nXc/kg4X+SL6SJtuFZKzc/SmJH8x3Lpni7zXRGSJmC7zCx
 g7VH7wJOZJqANs6wbO3dzR0eI7+48NtQaOEffLB3o9yHJpLmt0FdQpGcv1EWJJtNb/
 ADvmnC44FS9xSHGIWnlJtVwSRO6c9ouBQkKC+O0VI4rosda2SYh3oAyxbDRgyDV0SU
 SPJVnJB69/VFFVSBjUhPhbnu67KO1WBCN7X1nUwGRmGsi0HPAY8in067EPcMCo8ChC
 2fFBt9f9P7NSg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hN1fRzFk
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/3] ethtool: Dynamic RSS
 context indirection table resizing
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 15 Mar 2026 13:30:33 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>=20
> > On Fri, 13 Mar 2026 08:13:12 +0100 Bj=C3=B6rn T=C3=B6pel wrote: =20
> >> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> >> the queue count, because the hardware table is a shared resource. The
> >> ethtool core locks ctx->indir_size at context creation, so drivers
> >> have to reject channel changes when RSS contexts exist.
> >>=20
> >> This series adds resize helpers and wires them up in bnxt. =20
> >
> > Sorry Bjorn, I was typing the explanation below and I realized that=20
> > we may be violating user intent. We should already record the user_size
> > from rss_set_prep_indir() as part of the context (and presumably some
> > netdev state for the main context?) and don't allow shrinking the
> > context below that mark.. =20
>=20
> Don't be sorry! Good catch, and glad you caught it now rather than after
> it landed.
>=20
> I'll respin with user_size tracked in the context (and netdev state for
> context 0) as a lower bound, so resize never folds below the size the
> user explicitly configured.
>=20
> WDYT?

Yes, keep in mind that AFAIR context 0 is not currently tracked
in the xarray. So maybe add the size of the main / default context=20
as a field in struct ethtool_netdev_state ?  Or we can start tracking
it (partially). IDK what's cleaner.
