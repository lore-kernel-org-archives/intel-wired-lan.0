Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2050C79FB7
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 14:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F77D6078C;
	Wed,  9 Sep 2026 14:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huygSq1v2ncQ; Wed,  9 Sep 2026 14:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 069DF60769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788963388;
	b=Uc0ytnufDXsnrQ3p0B8gR6CVHIWVzxOr9ynPWpKhXe5ocMjGV6hbQAiOmbiERWg51ZHx
	 lozixrWF1BX6EHRhZoYhMfr/VahALDyzkjZdbfPgsyrnRaeQ1V8Ton3O4BX4jtPjbY8cR
	 XSBH4J6VaxFXIhMabbuGpLcG2D1/G4fPo1SnB6cAIeMlx+A2zXyBCYz8mvhSNlMCQSyiY
	 4Qztv4UHkvwnvQV1oo2KzFp7S87N012fTkbvns3hmwDzhqelPmQtqZQibS/QG4wjvjIfy
	 yp5KexUUsNx9AXeNMKhK3JXWZPqHLpPwMjmklqopXBRabCZ4r1tTKK2Wzuun6CqMQ4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788963388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Debian-User:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4gJWK0CsCanIqr2CcAL6KVdYWNAlhC1u6+5ypr1xDm8=;
	b=SZRGpDxvzEjXhSdteUjIt/y/HijLKhxbLC8E2Dor9zmTwwWB2jgjYXlnnPCq7dIiK+WP
	 ZLIO+QP/OVgEUt23U0NMRpgq6F5Ov0qr7yXY2Ac16Z4PZYPIXO6RgGhQYEgmVVsF7nYyo
	 Y82jTttDsQHz81wfqufV/mfIyC0qEcGuMK4tVhsspiukdnU8T6pIykx6X503ypYixRsfU
	 m2j1QonHFDd8JxM795O4WmTYKvNJ3aV80mVhVeWT/FQ5NtqyNllOuIrtmB+mPe/Rkdr0I
	 ZfqwU4OfrJ+e3NM+DQUNpyVgY4K/ehIXd/zyAsHxGIDxsDnaE5pOmO/KfivzNahvEnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vqdKoGkM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788963388;
	bh=4gJWK0CsCanIqr2CcAL6KVdYWNAlhC1u6+5ypr1xDm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3kLpLls7WsdBJ5ZIQjiZQazlAIM1rLdG/KYEyDNTZmDK0u1bKc1NeZF2kot+MiFe
	 FemQocubJ1lReGrnYJGDKQR3O46SmWg+kwrpERlpwXImFGOyFy7MJXouaeJWy5dY8J
	 VlzDhOIkOVx9y1NZN1kfop66lD+MczzmEHUvp8huFc5ia4HFQwG2w/DK+WwzxyecdU
	 TQ+5fLxiCKPB4aPZxFv19UWVsfxWNAuYw+QLZdxSpLVljXjbxea6slbtDdIWGqLZZ4
	 489RkeO3k2NS5N76cKhk4a9nDDLIUUueG7V/NSsceGZbV2GSm+Uo0xXb7KXuzmp+ic
	 n1vX8CiLjsecA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 069DF60769;
	Wed,  9 Sep 2026 14:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E8EE755
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 14:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 820A660769
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 14:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3bzU-i1B-1r for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 14:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A7015605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788963386;
 b=Td6zajw9KFfl8WUZ5njYf2XyaX7XnW5oXqs0LRu/qJghoXopr6SmBFJAOAsaaOntL0y6
 5LV1ocAfj33qTKYkQM6u4C8INn8W6Wr/gjn9+tPSWU3imJeXTD6bB3bUrWiL8aR7c/7mn
 SUYQiG44GTC1IsLRQFSiZ2rGs0hmNGTQIoLuwHpIgBVQ0WORA1LoZwzMikuJ+9z2hJVeD
 u8t4EI35/96bwh+lsYjNLAsMVRGbLiUY6RXLHjZfWs3U7MCzpJ6TpCnnKxUP6w4dg6pm1
 QpxRTHU4gouZhXK6L7A8mjHsfaLPwva5MGjufSN1EhpvKcqYfmaK4UPGFvHhs3vmt0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788963386;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Debian-User;
 bh=4gJWK0CsCanIqr2CcAL6KVdYWNAlhC1u6+5ypr1xDm8=;
 b=KdgykL5mH5jfHQ5zoXv7mWjxeL2RTUC+KMOfeeTMjT76hniPze/BdmoFXqXtPNM6K6zQ
 MF/tBegKElNjG0hV4m528qv2vnQapTqw13fsIEY2//V0ZQYy2g7TCRrtOT9CFoNhvd0tw
 M+fsf2VxdyyTr2Jl+MagxhtShJgo/faP533aLoIP8CvNWQv+Fg6yZDKeOnpM5SU9wofID
 Ur9vzXex6oTPldRUP0nxmoztYZLudau3vTyMSVE9Nn22I2twJxkS/aCMsQvMDK7660m/f
 OS9rQmBl1Xy1Wpgt/vvlBur2E+vcLnBTA+cjzMaye6G8p3AtxgvcZoUo1+urmG0L88Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=debian.org; 
 dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256
 header.s=smtpauto.stravinsky header.b=vqdKoGkM; 
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256
 header.s=smtpauto.stravinsky header.b=vqdKoGkM
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7015605D7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4gJWK0CsCanIqr2CcAL6KVdYWNAlhC1u6+5ypr1xDm8=; b=vqdKoGkMqI3l0Mzokkdx6VXH/n
 foZpguuW3YclQ/ZVT6v840i9RDe+kEtQW5iJM3vrIKGKgo6CuD2y+ltV0VhDLSmVk0IIof45Ckxi5
 uTcLhbRP7My87tHahpjnFL8YWY22jLZaC/m2qsb7XQi2k3mfSeNHclDqvC5krIIERBVDHQ0JFJtHS
 PoLcGpstJQonj4MyTYpbJGuZBLIXod3xZgW1NTf1reMs4Vmzb68udEyO1xBLpgY5rPMS9eLqL5ZRY
 8PBvZuxjXQ453EXgtMHq7+wkCctHvAICvFd1UAYIfwUGx9IFv18kNglsbtwVevcaZhza8uM8D+M4X
 vmPdGyBw==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <leitao@debian.org>) id 1x4J5n-00370r-18;
 Wed, 09 Sep 2026 14:16:03 +0000
Date: Wed, 9 Sep 2026 07:15:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, 
 jbrandeb@kernel.org, benjamin.h.shelton@intel.com
Subject: Re: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Message-ID: <aqFp78nsYmT8gRDO@gmail.com>
References: <20260821020201.1337338-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821020201.1337338-1-kuba@kernel.org>
X-Debian-User: leitao
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

On Thu, Aug 20, 2026 at 07:02:01PM -0700, Jakub Kicinski wrote:
> After forwarding net-next during the v7.3 merge window we started
> seeing:
> 
>   TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_printk: REC->q_vector->tx.tx_ring->q_index
>   WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.cold+0x39/0x4b

I am seeing this in one of my hosts as well.

> this is due to extra checks added in tracing subsystem in
> commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()").
> 
> Printing happens long after the event was recorded, by which point
> the pointers may be invalid (the ring or the dim instance).
> Copy the eight scalars into the event instead.
> 
> Fixes: 3089cf6d3caa ("ice: add tracepoints")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
