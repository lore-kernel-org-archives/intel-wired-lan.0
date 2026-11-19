Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00874606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gbd9n46c;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4+24Kgw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8186810AD;
	Thu, 19 Nov 2026 01:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYFoZRzyz0qT; Thu, 19 Nov 2026 01:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4D4580F70
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795052668;
	b=L5emDL4ym6TPQYptWxQ4cJq8O5/5pkINcNfWj3i/deT0w1DOABkLSP1O/+xYS+aFKUj+
	 69AC6RWK4EEAYA7kzquMFqMhFuIuf8UBotgzrOPBu90JEqzKMs06cq4XI8tovvNdduf2+
	 XZyiATpxVDHSJCcxB7BTSO6StAl7NAAyiP33MzV/mkDexjo+TfTaX9+yyZvjAKsG7yBRY
	 yDMY8mHZprYvczyEcnMKKy3MaKn+m8enFptHySQfGcdXBN1ulNKU0ipJK8pZIA3t5zsZS
	 YSTabYDvqh0mJgjYbMZtB/C4bplbR7+rBo+gpgBOyGxSJqL4GPUQsHErfZ741K4pGoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795052668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9waXTkMYmXwP4/W6e6Zut8DdWOx9w1dU7kQpzPoyvwU=;
	b=lUHwCbIvfK7eTn4RvVNfD4WqA0gNxavMx4NwUl/liKgFodbXKf3lAIvbNzoxmdIf7PYe
	 imuEjwnWY4sMmCTytHXc7suqcnnxm8mmag3SDZ8ld+xC1Kh0yTF+SK5d0Slyn57zZ0sMK
	 YulombeUKCmYIiThdLe4yHw8i5PBP1jFtiKSFLYbtSFWeGxoqW8EUA4W0lbCxdMrI3te+
	 mZF8aOguogw22N0z/8TJdT6DglLGgmGT9IsuyKLM1Gy+aKcq2SmdCj6X05xKNuM+wepja
	 MRL9Ub+bpDyz+xQF+wyH/LmaIhJjfDCEs94UPfpwGKtOeW6ttLweUIFX3vXS/EdofSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795052668;
	bh=9waXTkMYmXwP4/W6e6Zut8DdWOx9w1dU7kQpzPoyvwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbd9n46cEFKG3dIwtKDkiLxRUHyuU9FKFehboOJIAhhVs0ggREO6tRR3ZFCmhF+p1
	 r67KvojFP9Q366yQqWb0bhaX40pwK5BtaB1RQkDlQvfQLvM6Bwo1cd1k+uZ53sNBkm
	 W+yokLZaVBASydJbrNnBvMKMPakE3/znc1JkuDWxU0Nq4u2Vf1KGsxuJ9m7w5FCNiW
	 LJTBzhRzmkr5LzCYgrjmQ/kWBFJ07pHoVh94OJmxPm7I8cDXpSGFPkZdseGhBpJsXs
	 G+Z60BCpC4WDPgcCj7Dv6IHSSCXEXuxL5K8dSz05QOcxJk86G8/TDw+cCPyUKy8c2X
	 V5SCpMJ+UAbsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4D4580F70;
	Thu, 19 Nov 2026 01:44:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E88D9E22
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE43C6063A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-mODWa8Q-mF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 01:44:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FA94605F7
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g4+24Kgw
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FA94605F7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03E3D42D81;
 Thu, 19 Nov 2026 01:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C51F000C4;
 Thu, 19 Nov 2026 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795052665;
 bh=9waXTkMYmXwP4/W6e6Zut8DdWOx9w1dU7kQpzPoyvwU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=g4+24Kgwh/t7ZndPUj9S0xlpXcGv1IYYD22Krr8k+/31irosmzvTiBx1eEohjk3O3
 MFJDjLIiWO+DEEfv7a8XHdJsDWvk9ihr2hLU67OZcQVvcMBrvGF2kyLtnb9AMWivPX
 dIp6oKsNR8c4w4TdEzUYVpraMDEFj5xzlTEPJikb0W+nzvtlDK66uhxl7VmnrM3Oj8
 vqh6CcEr6FGt4lYrT74jDza5iMl90iWjconT0umM/VmscSjTVcYhNWX/o4lVQsM5jk
 WCZndvOtsHxjZ/NJnUrQHQbF4WLq6o7LBa28as8OWMDZp1+DfXXhOlUkU9AS8RO1Tf
 WfKnQb0ObJK4Q==
Date: Wed, 18 Nov 2026 17:44:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Grzegorz
 Nitka <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Message-ID: <20261118174424.32e9f130@kernel.org>
In-Reply-To: <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 16:29:23 +0100 Ivan Vecera wrote:
> A step of the zl3073x PHC, which ptp4l and ts2phc do at start and after
> a large offset, waits for the next 1 PPS edge, up to 1 s, with the
> channel lock held. A phase step can hold it for up to 3 s while it
> waits for the previous one. A dpll callback of that channel waits for
> the lock under dpll_lock, and every other DPLL request and notification
> in the system waits behind it. With ToD writes running, requests to an
> ice DPLL took 1448 ms in median and 3.9 s at most. With the series they
> took 0.2 ms and 0.3 ms, the same as idle.
> 
> The bigger reason are zl3073x callbacks we are working on, which have
> to wait for the hardware themselves:
> 
> - a device reset with resync waits for the fast lock, up to 1 s with a
>    1 PPS input
> - a glitchless stop or start of an output completes on an output edge,
>    so it takes up to one period, 1 s for a 1 PPS output
> 
> Holding the global dpll_lock for that long would stall every DPLL
> device in the system. For the output state we tried an asynchronous
> implementation, but then the callback returns success before it knows
> the result. 

Right, for these level of waiting async seems like the right direction,
at least naively/without knowing the HW.  Why does the device wait until
PPS to apply the step change? Is the programmed time supposed to
correspond to the pulse?

> A failure can only be reported by a later notification, and
> the next request gets -EBUSY until the change completes. With a lock
> per chip the callback can simply wait, and one chip cannot do these
> operations in parallel anyway.

Do the failures only happen because of "unforeseen circumstances" / EIO,
or there may be more common errors reported? If it's just the former
a devlink health reporter could be an option.
