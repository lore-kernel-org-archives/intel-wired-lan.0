Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C6CA6017
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 14:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E43E360634;
	Sat, 10 Oct 2026 14:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mi83pM0IHZ6q; Sat, 10 Oct 2026 14:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 502C660638
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791641148;
	b=Hhuw5PKikjkJiYE6Tj7re/FT0xBtjNtx8AQX/NzH6QZ/ytv8kKvDD4T0JAEUWz7TEEps
	 lR3ctOg8+nmlqaqzgYJrcrudsq2fYpGAeXEutlZ8DAIRrVkcre7Vzjor2ihXhYNXlR3GJ
	 rAuO9LMYxD1PuH+O+aJijanjQpe7iIVwEIOQVuuccQGDJypT6sEu49AF16uAU0bCC0bIw
	 FhFagQNJrdMmYYGvludwUmh0IBqlTKhNa4B6JhOWGhounQ8oLBuT087Y2iDtMiROwXtRu
	 SKCYLPgukZm7hA99iXI+pBcv67CeCFNjze3ioES3NSIgyQRsAkVC1jIC7M6156J9OyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791641148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GyknJpqFfggtxhblqqqi57Fv191t8GDatIYjjn2u/JA=;
	b=SLbK5CmSAtZOTLEjPs43Ia0GU3y0CEovCcK/LxInste1WJyqRsRq/j8cMrU4GtaMbBfn
	 RZy09ogF9f1fdB2xA9U23mIpv14m5aPKl+m/WmDoCnJBu/z5gzUvTaYYdIOF3Fh3FPo2+
	 eltq8kIZwQsP8yCprbH3ymvZSTkZHgSglKL+0dtUKEHTCLls/jlDde4rKVr8z/ODP7Cda
	 8wGgMODU9bOky1wOWLXQhL1A8UOXaN/lBunbSX8SBC7OlL0uFFJR8fAhrbYMs54tvanbX
	 9N9Fj7Lr4k+VKkcbENzgnmKqKirceBBJpmlFr8yZean5RR/HKX0GcNGWhyEZi0xHz1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791641148;
	bh=GyknJpqFfggtxhblqqqi57Fv191t8GDatIYjjn2u/JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IVoukkxYPzYwVSY+YjQ5QdiVNSTrmfCdmmVRkHS8wc0iG99UXyzE1JLGgNM5EsOdt
	 jIIyavEEead8QojFc9kp2+7jlaZaK0NMjV3z3kqM0z2DtqcP/HjehxWAVg1TSBSv4n
	 l6sxqXzA1YItcxS7KZNgHPb7ice3PqOX5jfKUcvBkznG6noc3+I5EsZk9R3nXQdCgt
	 R+Z5v8NTEVykrgUfyzCIprDTTVfSV9SPIi+pBU9vXOX/D+IoDHCI9+lMYcQwr8nMlU
	 7VDNquuFfJB8HjXsi9DGLqvo+lrqVov3Qy6f3oO5zecRzaSeWC+4J0gVGFTU4L5izk
	 cqSF4jm+dX4pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 502C660638;
	Sat, 10 Oct 2026 14:05:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8FB7105
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAE8D400AF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pR0QuSJVhQZc for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 14:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DF41E40004
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791641146;
 b=JDxxjao+/WsDoiuLlzUYGTU2Zhv3PFTGZVp5kLRVjx21OIuPbF3AGSvU/nhi1E4bfbxr
 9QAlH9cE/Jdx1qx2nODTVdZHEOQ6QkMuqf6VL6gztGggVoNjpvPGCUYT2CptIZ95M5YD+
 uB/y8NkHL39bC8CN5ko1CMcxB+iIK4tbMpvfKrcsvPf1Wv6d0U7K4mOkKJH/NETZ8YPhO
 gkZcUXSfp7WmrJHcNbQm/dlZ+aJvEeRkcIz7OpGIZHTYogH8B9p83OHRM9tdt0649nXtd
 8GYxwC/NveCo8i/1j/suAaUpE1ZSAuKlUyRvb6GDYReIJuFPTyk8wT8ejVmeXnlphSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791641146;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=GyknJpqFfggtxhblqqqi57Fv191t8GDatIYjjn2u/JA=;
 b=f3YsjX3atYs1fZ7teEwsnxtCqF4rOHOlU0nILT+p7SliXiZnj4+ThjNccZuVPsiT/z2L
 yg4er3IsWVbi0q4oMzYxfboUmPwmwOCXZtbm3X1WuntD1aXh6jQ0pLwt4CCpl6l0o6yG+
 hesSbKdmoPsjeTSB9HTvWtPS9I0osYVIEKToLcXSnzGWpfOncoRkKM9rcCJTBZ7tKxdT0
 e9yho1Zd2ptFqODMOBTRRm/iUtnghyShuatirHvjQuv7n9O/j6aTg+FDmp0j4lfNnvTpY
 tL3rtPvI7QWsY7XtgM5q97tVmSmvMHUy4ftYwcythJNM9THBZyOOSMknfxqjjcxBHPg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hpsFX85s; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hpsFX85s
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF41E40004
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7689943C3F;
 Sat, 10 Oct 2026 14:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE1E1F000FF;
 Sat, 10 Oct 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791641145;
 bh=GyknJpqFfggtxhblqqqi57Fv191t8GDatIYjjn2u/JA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hpsFX85sisLmYIOVIujbckkjWQzvbR4VG8YU5nv2hZcP0Unh0CDMZFlk357+cKfaa
 hNP2TOAljwO6WpvQm9jP2erAvKMCCXI50eB7DXDrDD54HaU4uo5Yx7mgnFO7QoBxYw
 zGuhfmwht0TbRxtGPYQzuSCSGrgPVMttq6lum+USoB+3BSMjY0nsg0KWyOqa7Gh608
 0K/4kZyGAbL/gURVxQZ4NobN0uEQRRkIfHuKi/IH7Ba1U3ivMjZyhNo99skTPvXnRp
 ddX+4bv49B/7OZrkNpzsWf77HD2ydvM8kVuWlF8j6RC+AlWTNBqV6SN9l8ogD0fqFf
 vY4FIYCwuek5A==
Date: Sat, 10 Oct 2026 15:05:41 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Message-ID: <20261010140541.GQ83879@horms.kernel.org>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-4-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008125754.3520773-4-xiaolinkui@126.com>
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

On Thu, Oct 08, 2026 at 08:57:54PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
> pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
> but neither of the two error paths below it gives them back. A NULL
> from ice_vf_vsi_setup() returns -ENOMEM straight away, and the
> release_vsi label only releases the VSI.
> 
> ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
> queue mappings and the VF VSI of the VFs it already started, and the
> eswitch attach failure path releases the VSI of the VF it is working
> on, but neither calls ice_virt_free_irqs(). The caller then runs
> ice_free_vf_entries(), which drops the last reference on every VF, so
> nothing further down the error path can release the reservation
> either.
> 
> The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
> the leaked vectors stay reserved for the whole lifetime of the driver
> instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
> pool that ice_set_per_vf_res() divides up, and after enough retries
> ice_virt_get_irqs() fails with -ENOENT for good even though the
> hardware vectors are idle. ice_dis_vf_mappings() meanwhile re-points
> GLINT_VECT2FUNC of exactly those vectors back at the PF while the
> bitmap still books them to the VF.
> 
> Release the vectors on all three paths, the way ice_free_vfs() does
> for a VF that is torn down normally.
> 
> Found by code inspection of the VF setup and teardown error paths. It
> was not triggered and no stack trace or error message was observed.
> Compile-tested only, not run on hardware.
> 
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

