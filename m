Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125060A381A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=68SS+W2m;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ruy9uac3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CCDF40A12;
	Tue, 10 Nov 2026 17:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_kNQi0DvfXP; Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B8EF40A03
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333208;
	b=Gg3XzEORmq4rm56bLQQGXAgESmDc+i/J1/QHHh4tPuIhCjn4RXUGURcLvO1IHP38oYTr
	 BWJJspHoo8PKMGLCcPemwqfFoyHAX+297JRKyN+KLw4Ti8ECJJVT28lV7SQTErwq2+aMA
	 BJC1SSmIGFSOBpoJ8vuNNhYpU7EFEt+dTptaPbNJsDqDslLKjKRzTeGYy3RkE20W+geGc
	 RQP9+raeooJxHM88K2Sk5E8BTLJYlSmNi4pBvjIDY/tKpNmaoQwOjuDpgJpANLTvUzV/r
	 X2jJQg84oT9kcM6UohSjxNWvFs0yFSNu89nuc7UE8Y4nJaHbvyLrVjIL9S30WgC/pnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ab568wwvPbStL1asXtzTrQ7hg5GKYsBt/+WIszdq9+A=;
	b=l5QiZzEU5U51Pu5IlwsfqJxGYBlU/05Tseh4NQhDHmJxk+Qe66h+/qgOHtYvetOFseYz
	 IOpzB2v9LnOtBZZKNFe3c747uqiDNhoCmDj/PuQOjH2JEgWECcjZaFy5JE4+8mhVP+NmE
	 2uPb5j3F6Lb0P2wx1VSaxgQBOcNYAGz/2ir+0mLMlbdV5cNIe9k8Gogy59/9N4H7MaLIn
	 qoU4uNB5zR+06UlUOh88jamwidq2wHMZaCe1XSCkwoiQ65m3MKdnFtdmTqi8S16oqV2FZ
	 xJoU+nYxYVf9ZffAS47CgWSbO60QflTejwpVsB28DgEuF2zS67002CaECdi9hq8MWiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333208;
	bh=ab568wwvPbStL1asXtzTrQ7hg5GKYsBt/+WIszdq9+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=68SS+W2mdUHfTBrLIXrAOckauSa3BsQ1nFZXRI39HUqQUzOpnE1IpTnk1xewBvzKq
	 Z1RnygXanf5ChV8vBYdoD3diCf/UJ29aRXdyzHx5hmo+AbaoAMnPlp3x48Yjz6S+Ki
	 klVXAJBddF/PKNA4MEIXca1Cb/uP2Ie5WTktoiSFXNbCyjofq2vPWGO0nxFecteqD6
	 5VB7714HYOCgY3nG9ZiVpNxed7WAKN2klrvwco47bXZdzS4Yc5+pJNTl3GFdP5of6n
	 2OasLnblOiqzXXDjBs/YULPnncwruajezAz3xRq1E4jOxTySdQavkUyasIk+zG1ejQ
	 BZMXFvu+bctFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B8EF40A03;
	Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DFB528C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BB7840328
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNGiuijq1JOb for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 672384030A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ruy9uac3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 672384030A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B34AE471A2;
 Tue, 10 Nov 2026 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0991F008A2;
 Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333204;
 bh=ab568wwvPbStL1asXtzTrQ7hg5GKYsBt/+WIszdq9+A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Ruy9uac35FNa/e9uIlj/CahwSyVHIhN0Ge8tMfWIqfdFhU3vJHMU1iZafxswC2obp
 N0isaOWEzLOhw3RCcWyrbI+izQTsqlALDv/G+/rlZNJdGj3EP1fYMzV8XwYyVicf3s
 DE+r414viPj+mUlqRj/5LlE+SAJ5Ac8yStGxLSJO/VlgiJxlKQDUHMq7qN6jNObrTo
 u23b1GglHX+rTp7fdfsyMGD9P1pv7w0JU6Ga8wzjVK1ZliyY5OwuDbGywnpM+gIuoM
 Ai6p5y2qWK+LmV6W0FJ/NBtw+yYQIL/QgBj9ReYwpr2f55trxItPQhi9Ee2eooI8Xq
 fqhEH+KU0CYVg==
Subject: Re: [PATCH net-next 03/10] dpll: add domain object
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
Date: Tue, 10 Nov 2026 17:53:22 +0000
Message-ID: <179433320288.994134.11961533455589849486@kernel.org>
In-Reply-To: <20261106121005.1327603-4-ivecera@redhat.com>
References: <20261106121005.1327603-4-ivecera@redhat.com>
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment on `lock` in the new struct dpll_domain
  (drivers/dpll/dpll_core.h) says it "Serializes the driver callbacks of…

--

dpll: add domain object

This commit adds struct dpll_domain, which groups all dpll devices and
pins created with the same (module, clock_id) pair. Domains are
refcounted, stored in an xarray and freed along with their last object.
It prepares for serializing driver callbacks per driver instance instead
of under the global dpll_lock, and states no functional change.

> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index da8a369556ed1..6705e81bc11de 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h

[ ... ]

> +struct dpll_domain {
> +	u32 id;
> +	u64 clock_id;
> +	struct module *module;
> +	refcount_t refcount;
> +	/* Serializes the driver callbacks of all DPLL devices and pins
> +	 * that share one (module, clock_id) pair.
> +	 */
> +	struct mutex lock;

[Severity: Low]
This isn't a bug, but is this comment accurate at this point in the
series?

In this commit, domain->lock is only set up and torn down:
dpll_domain_get() calls mutex_init(), and its error path and
dpll_domain_put() call mutex_destroy(). Nothing acquires it, so driver
callbacks are still serialized only by the global dpll_lock.

The later patch "dpll: take domain locks around driver callbacks" adds
the mutex_lock() calls on dpll->domain->lock and pin->domain->lock that
make the comment true. So the mismatch exists only in this intermediate
commit.

Could the comment say the lock will serialize the callbacks, or could it
be added in the patch that starts taking the lock?

> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
