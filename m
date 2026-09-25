Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE1C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 20:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABC8B81206;
	Fri, 25 Sep 2026 20:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dx2WLrw4uExc; Fri, 25 Sep 2026 20:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E220381250
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790368598;
	b=k9Z4hli7VHJTQsYv+epE6N/FA0AIovrDvIyVLKulMITZR1/QyphHwI9QKixo1YK+VjP2
	 pBZvPEfMyr0wd0CpAd9uj+NEnenMHtugoiAqgjx1MNVUF1fF4lVZPqQyjXNgQXlGbrwnw
	 m+pI0XGKma17PePHdC7KdNI1oVqnh+JloGtgj7TYsbx8yTl5++8JWa4Yn3e7vZnkQHkxa
	 pKgqBaFqSSZEKaf9+rBkBimTeskoR7coMWng4NrQjawcRAsz3JxRApMDlioVVWrE6vKwX
	 dXg7p/oS0FdwxQR09Pn+t71QIsj4jSASquYXSXxTkZXtPPzdaEJsl0kxfKKOuvmsWMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790368598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MCeIEH+/nTOajLFES8iXUlHm6Kt0VZFSIkJ0GRUqBEU=;
	b=s02JXpYg+AsM+spK7OYTAHVSDzJ9j+6pnzV2lWLkKtWULC+/aaSDbxE1YMJ+/DQF3xH5
	 xs11svgVuPVz5O4NhyyLxMmyxpZ3PPE4Z6najzmlNVhRECf3o/CK0cNzS2EHCitvai0rS
	 jl7T+u6qm8SxCefXSuTCoP9krgd8x6Tb1zvjSTKlVSthFEBYs7np0Yf4m1Ppz/9WZQfk3
	 rtXAHbm9kgjMuYTjnE0qHHcdEX+/NrVdId1VRdxf0xwoQRez4qak7RZR3F6xYcux0Bz7J
	 MRUDcF7XUo6Kwx0mbK92l8nst6o2AacqZc1bBpkrzOYu9gpUVzQiyWfNlY9e5vIoh2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790368597;
	bh=MCeIEH+/nTOajLFES8iXUlHm6Kt0VZFSIkJ0GRUqBEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=io0WGdOcE4QpKzQOeR+30jy766GcYBTVOvImiyPb4iP2+LOqiuZSrIkXs2QeG5RRI
	 DJJuk1tlpyqRyDOkfsF3S6LHjOkAQn55OEEFzRVkJ8I3215eqYLAd8wvB2Oo8BzM6b
	 R/fzqnPUnRAJZynZkRBPVrXITbo0rGqUpj1PvoFYje5nqw/ItWvmNotHaNYVWDS0Kt
	 SHcHulm3KHMrcBDLX7XVnQG5XsVnpbx9GWsPdAFhmYvaw9OAuX+X20KAq2EKdrFopZ
	 sRMZV8IYKIpe0LR/PxMFGbhKANWv6qCB43ynwKtcFcZcXkcQ5Ama7ywBKpISe0p8Nr
	 z1DYzLuPtSuCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E220381250;
	Fri, 25 Sep 2026 20:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D5F732F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33732404AB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snQD0bpYVPXT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 20:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3C6804049F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790368593;
 b=UhqSZH8b/+g3DH/m3ArBcbtoTorEUpg1gJLZakrctB6K05zzIwmzl7oTJHbbdeSlBGBR
 FrItS5KiSqt67RMFRabLd/PH40b1NoWdQ1l1n54tMrU3QzjSb3qxikt1bv4GevZizeXRo
 H+UiuvN8M0LUYgMlbaU129566fYo7n8nqh7tfJqb6PlLvGVrf0CByXZpCv+RyVeQTK9n2
 KeSd4vMvha8w4lTurIOf1HxFaPwS3IEY3OpIMx3WOZo0iHitaEP7JKFq4gZa4r4DUHMt0
 9/iykOwYig1wMBJVDEAozU9gwqDhSX2tnZ99GMcMnVgiQwUJ78BC+AsMa+5bHIUvlxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790368593;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=MCeIEH+/nTOajLFES8iXUlHm6Kt0VZFSIkJ0GRUqBEU=;
 b=Lc0Oa3abIXNUYTV0UeMSEoZrFufZogW/xRELczBfw7Gb27y1In/hMy33pPQnK/sfXzEd
 eq/b2BQLpmEXvkuqWpD+c7VMJNyr6reyYNtQdlrHKrrrmx4vUUO37IFEnBzd3XfRxsW7L
 kuUpkdqJavQ4/h869n8ZT1szVRADSIhAWLHM56rz2D5VaFQOJFjfM9trCEq8oo3wzeICt
 2KEQq224dYZhQPn3uFVm1VCueZdWau7GDluB2mGlJtqsIh7aoh/8dLj5ee25QQBcfl4la
 Rg0PeVZPHA9XM0vkqZoRhkSIAMQC71hRI8Y9a+KjK/Mh3AnzSbbPI+ucarTJ6uiVxLg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=otx7KBmE; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=nathan@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=otx7KBmE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C6804049F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:36:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79B1A432B6;
 Fri, 25 Sep 2026 20:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9531F00898;
 Fri, 25 Sep 2026 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790368591;
 bh=MCeIEH+/nTOajLFES8iXUlHm6Kt0VZFSIkJ0GRUqBEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=otx7KBmEdvM5AzKVdrxOpbCgWxoqyh46RwkBOJG26e2Ex8dmNJbzIOOuNoWvVI/T8
 /E24LpPUCaDEn0PZZkclidCWYq3knG/56d1LHhWJhjHqZh+vfezJhbgDwmIluSpLLl
 9oRGIz+jmaxYUE5/gVAx6WZqouUFJihJsjHaSa3JfKZpdXGCgaTzDKm3DKprXaGDMM
 LfEgjoSM90ytFM2T+owrzEqXWsWIjwhO2AFSudT36gX0ryi9ljjAi1DhlyzoYsSxyA
 87V+G2f+T3JBk4CkMf6d5l9c2M619bZyVWQXMwJ7Cy7FhasXZu+f6RhRpFFBGH9ye+
 Lg+JIFV+8Iang==
Date: Fri, 25 Sep 2026 21:36:27 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v5 7/8] ice: Annotate PTP control PF lock handoff
Message-ID: <20260925203627.GA1862486@ax162>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
 <20260924125916.2796499-8-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924125916.2796499-8-sergey.temerkhanov@intel.com>
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

On Thu, Sep 24, 2026 at 12:59:15PM +0000, Sergey Temerkhanov wrote:
> ice_ptp_lock() conditionally retains ctrl_pf_lock for read when it
> successfully acquires the hardware semaphore. The matching unlock occurs
> in ice_ptp_unlock(). Describe this cross-function handoff with context
> analysis annotations so static analysis can verify callers.
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
>  3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index c454f19a2cb2..8b7891ac25b0 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1179,4 +1179,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
>  		rcu_dereference_check(pf->adapter->ctrl_pf,
>  				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
>  }
> +
> +/* container_of() expands to a statement expression, which clang cannot parse
> + * inside a context analysis attribute argument, so open-code the cast here.
> + */
> +#define ice_hw_ctrl_pf_lock(_hw)					\
> +	(&((struct ice_pf *)((void *)(_hw) -				\
> +			     offsetof(struct ice_pf, hw)))->adapter->ctrl_pf_lock)

FWIW, another alternative to open coding container_of(), which I don't
love to see, is using a static inline function, which would likely read
better as well.

  https://lore.kernel.org/f147ad227b85439d56183e60e0332547b84441bc.1790360262.git.bvanassche@acm.org/

-- 
Cheers,
Nathan
