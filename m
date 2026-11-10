Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DA60A2603
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OIHVJxMg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpi8Epj2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1F0A40A0B;
	Tue, 10 Nov 2026 17:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uPz2OevlKnRX; Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C317940A03
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333210;
	b=PZCtJ36zCihX4t4d0qQ3coAXdq4Yn58p7NKlepdlLja+tKz/DoQxOemdvcTAvIISlZ84
	 PcF9992NvzlX455941m7NbrngENxOXOuvervUceeIZyuovUhKHSEXaYrWeIlvmwwmebgZ
	 YfxEp7yIP862iq65euESA/eJXUrqfnPz/I0EC1T14WYNGiMG7RPgN5aiXbM8u6fd1vdHK
	 rtvrBs11gYMitDnaa/eq1tCzSLGOePdxp81RE8H3ida2/XirOYTw0sgWPwzLHbkFYpB2V
	 nvEKrNoLxMrrah1aOVSnFoTyLVQQCehLWTZlI8RlyemS2omMrtTxnv4VMKa6RkSB5pQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ebrgguzYZNPO98ahlAUGmK5SoDtGwXJz8Q3pxsxvEgw=;
	b=ApMVj6Fzro2zJKunX9tVrDt5tKR250WML6QMxcf5eg2YQ7rBnl8Wcz2ZTrLDZjSo7dyD
	 Q7nWBjlH9GUjCofAWTbbsLcWYgCvnXH8hppYLgBPthHpm4lckiq9HeZZx6ij8G5w6ep4s
	 sRUw+Bsyn4DmyNQVUxxO/FVNl5SjyWfrgClt2AhOjeq5DnCep8FCYmgYEpH8juWjf6Xp8
	 ox5TGmBOg62DInHSGqBvRCV5hMGfs7yCuzMZ9NVfoM+4EmfSrat07/Ldy52G2HPvmpGKR
	 UjeYjDqROgAOR2LLQbxd0PaKgNoy83FqYDCx06HTth8opg+V77JLxUxPmGhvCkIWCGg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpi8Epj2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333210;
	bh=ebrgguzYZNPO98ahlAUGmK5SoDtGwXJz8Q3pxsxvEgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OIHVJxMg41d0jRF0Vsd+Gu1LblW4qUZ3/c3ygtn6KicOIQGIWY+gbfG39V4nRSSgK
	 5mC+/LXeuv/3KLx827LVvZEi6tNwj7YcnhnDVgPq7D6zXEhw/iLLzYDnlO2USsEBiu
	 blIj1moxZLNvrk32TbE1dW8DWSu13H/ptzWLZuBa9fSyKmAdcxdYYXSEQDIxN470a+
	 vsO0kXWF86Oc4ctfol8b7oPUsAF+X3WSX8gwb0teEZZ46Kpmlf78EXLpZVIfZPj3wW
	 uNNuvlMb3FS3u8/FJC0TacVO0UMUNnqsHp29vOXUbX2Yp2DFZ6wyJu9JvOZruFEqfc
	 jzAL5YiHd/bNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C317940A03;
	Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAB3028C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A089B40A0F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-l59PRvdiGe for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90520409F9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Rpi8Epj2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90520409F9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5CBD4383B;
 Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD211F008A6;
 Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333206;
 bh=ebrgguzYZNPO98ahlAUGmK5SoDtGwXJz8Q3pxsxvEgw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Rpi8Epj2hAbMGS9noZ90k0oah0cdappeJZcbQPqArf6F1P6oyjOuB9F19VFsQBRqI
 BTDRBmrLMRK59Px5MifpXTi8+0nYI9q+6dud24HN6qd9SBTEYVCJB8VRdrioJdL3/J
 m2TB8nqYGRQ8s+VhX2kSTnU6PP8CFdF2STZur3jU5W5CT1U9wYVnGBV6WS9AvinRf9
 5iE0W4OQsMw7Nl3GYZnFsrHZZoOveKiMm5G0BqqOmxhegLnLSCRL7ok/Up0BuA3zGV
 i6MhyM0WSzoHyek3oJXGyGAso/leIDGchY8lLvyzCsywGpY/hr6Qej17ir1eWmJdF5
 X6HN1Av2KZCJQ==
Subject: Re: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:24 +0000
Message-ID: <179433320479.994134.13826920591104367019@kernel.org>
In-Reply-To: <20261106121005.1327603-6-ivecera@redhat.com>
References: <20261106121005.1327603-6-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch turns dpll_lock from a mutex into an rwsem.

--

dpll: convert dpll_lock to rwsem

This commit converts dpll_lock from a mutex to an rwsem. Core functions
that change the topology take it for write. Netlink requests, dump parts
and change notifications take it for read, so callbacks of different
domains can run concurrently.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index dd09f52817099..8eb7468234315 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -19,8 +19,12 @@
>  #include "dpll_core.h"
>  #include "dpll_netlink.h"
>  
> -/* Mutex lock to protect DPLL subsystem devices and pins */
> -DEFINE_MUTEX(dpll_lock);
> +/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
> + * to change them and for read for the whole netlink request, part of a dump or
> + * change notification that uses them. Driver callbacks are serialized by domain
> + * locks, which are only taken under this lock.
> + */
> +DECLARE_RWSEM(dpll_lock);

[Severity: Low]
Should the assertions in dpll_domain_get() and dpll_domain_put() be changed
to lockdep_assert_held_write() along with this conversion?

Both helpers still use the plain form:

drivers/dpll/dpll_core.c:dpll_domain_get() {
	lockdep_assert_held(&dpll_lock);

	xa_for_each(&dpll_domain_xa, i, domain) {
		if (domain->clock_id == clock_id && domain->module == module) {
			refcount_inc(&domain->refcount);
			return domain;
		}
	}
	...
	ret = xa_alloc(&dpll_domain_xa, &domain->id, domain, xa_limit_32b,
		       GFP_KERNEL);
	...
}

drivers/dpll/dpll_core.c:dpll_domain_put() {
	lockdep_assert_held(&dpll_lock);

	if (refcount_dec_and_test(&domain->refcount)) {
		xa_erase(&dpll_domain_xa, domain->id);
		mutex_destroy(&domain->lock);
		kfree(domain);
	}
}

On the old mutex, lockdep_assert_held() checked for exclusive ownership. On
an rwsem it also passes when only the read lock is held.

Every current caller holds dpll_lock for write: dpll_device_get() and
dpll_pin_get() via the alloc helpers, and dpll_device_put(), dpll_pin_put()
and the register/unregister paths via the __put helpers. So this is not a
runtime problem today.

However, the read-side holders added here (dpll_pre_doit(),
dpll_pin_pre_doit(), the dumpits, dpll_device_change_ntf() and
dpll_pin_change_ntf()) can now run concurrently. If one of them reached a
domain lookup-or-create, or a final put, lockdep would no longer warn about
the race on dpll_domain_xa or on the domain refcount.

call_dpll_notifiers() can keep the plain lockdep_assert_held(), because it
legitimately runs under the read lock.

These assertions are still unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
