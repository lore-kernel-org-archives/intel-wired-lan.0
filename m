Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2D606A332
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zQiIW/8Q;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpyVEqON
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A63D681004;
	Thu, 26 Nov 2026 09:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kuQFIptKeTvB; Thu, 26 Nov 2026 09:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C030981006
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795684516;
	b=URRPZW/WQBIYkZQSfWFMzdlDCh3a8Bo5hFPUqfd4iCnxMGoLb6HidTg1FrXCXZKck9nl
	 BCv87IiIvMCXay8JqtDZEeJDe1qvQ547oA/BDnrWRsbACyJ9Fz/yieazbJl5zRQ3tUJ88
	 aRFruGR7gqdfL1BSLsIk4ETd0M0QsESGEf9YIZJ7IpA5c7tbZnf0dB56pltE6gd/lmTn5
	 zDu0+Jz8hbEeLHeAJNRMWo2nno3UxAFEddgbUXjZiubSJGe4LcCI0QitXZPzHl5uMwOI3
	 E6mMOzwTGqkS8eFxuQvuAWB1cqH8POWjDk9I6kqgzLoLVRNE1JA/yPeAQBg6uRALbqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nOvBGWrpieXjeYeaYeQ4iz+dQ3K5Ruh6yQGDubq0gG0=;
	b=Y+2dhV+D2Q9SGw9ZjLxnnDA29Hb9kXqV+Cn2caUMy18+u+SNRidtM42XVTBQ+ngLUERj
	 C6we1xA88MBAT2iWCK0/EqeYRX+/0mzp0XkT7ZzxAmcivvcxQLk0saCFj8VBKpbG5a8D2
	 32JwAmQjoQ0Ri508Fv1qwuYzEPqwXytc1jnLthWLVWK0utfTTn+eyqYuxHgOmN6f7nAso
	 ilOvOdqaetPqt7vtUvFZ3YvCAKSypoedUKmRchLwdBnAfYfLMb/WLhalFRjtE81Gjtcvs
	 JY0PO4Hhnen5gAFYxMmOuE+cTE4zOc6j01jvtPe+ZPQlY1wJCVjgBzCau5Gs0AmFTTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795684516;
	bh=nOvBGWrpieXjeYeaYeQ4iz+dQ3K5Ruh6yQGDubq0gG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQiIW/8QQhp/6Ui32LibkxlIl/Jb8JekdxI6z3SALN1Xjk1osvbxt2aY1Jpeq0chB
	 X4XfuvpM7FaRyu//x0QZUSVNowCobiJEkufFMZCMA7+MgoTyRUof18If9GUIcCdo1O
	 ZUUGb94DBOFhLlyI9YRejrI+thNchuP9cPYsiwcSSaJe/32TqqQ3ItWz1Mm8x5Apsq
	 Jtb7NrLBSzfhuLLoVszEHgD9OfqeF7+Wso9U12B9c75C4v0aTqHdcTsEghrL1pwKQ2
	 lEQo5kaofjT95vN0ihKmgSwrA+1xGmGnXuQRUSHLvaWvkmxZ0xIfXSnW5hiApBI1BB
	 01+XPPb/CJrWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C030981006;
	Thu, 26 Nov 2026 09:15:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE0B1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2A9A40211
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UzlYGOh39Qib for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 09:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 88DDE400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=david.laight.linux@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FpyVEqON
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88DDE400B5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:15:14 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a358881793so3526472f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795684512; x=1796289312; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOvBGWrpieXjeYeaYeQ4iz+dQ3K5Ruh6yQGDubq0gG0=;
 b=FpyVEqONz4kIwn42+UQvnxFbY9r9o+gTunKZ7Hm/EDzMBCGmXVoZIrvtE8PMVf2vy/
 VDXs2UPX5YKvzvambRZbZ5VdheFS1w42MH8tSXsivCLnnHJus5eQ9kkw+q0rfR9MIVLn
 NHfJ0QwRY//7SUkiD5m9wGaQ60+fmlIQgL1u4FJYB9EErigMbfKJ6oSfV+DZmBRpB81z
 70AcBzI3D1KSUI/WnsEx3KshzqR/M+P/Veru2OJb7rJgPMN49D5BzGSPLCsgm5ZrcSGW
 1CuTD4faRONV4CZlmkhrM7JPtX0aop0ZpMPy5q9NSUToWp3x4mlCDEKcCe3bitE0rXxY
 FSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795684512; x=1796289312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOvBGWrpieXjeYeaYeQ4iz+dQ3K5Ruh6yQGDubq0gG0=;
 b=OM1hlr4wZgN5njIbei5LCuNhr1lNSQXaUfMTN6I9ArQcBlrahpuISFEUwrME5CjTiO
 tEo2w3uHhGEmmQoamPz7UR2J8ACLBjTjkxl79xAsgnxwQhj2aE7Za5aZkicRJpCO6xi6
 59YG80uQPT0ReRp0koldFwLJTouIT+FSzuXGv/VH/9w9WKhQDBwKipzETzaSAkjUnJl1
 vSau33koeCtLaOjYfE++oIY4NUkOjy2qFz7nuFoCwijjFox1Jpw9dzWLVPEP2q39t/Qr
 zN1BhTodeesKHiOwlRLoxrY+YTXXfsSwl+PgERA3lf/Fr0XL7P0eZSHWwBeTrTsMFT/7
 h4cg==
X-Forwarded-Encrypted: i=1;
 AL+hErFbM9H/bCt/3SmkO+/QHPdEqmKWCtgKJ2JtfLJHDtGW1gbwIIztIYhrUSIys9nR0f/5FIYjV/qsyfAr4b2txQQ=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/2SlJCWLRRBcuq+x2AZRVk2QxnagIHqqVIkItLe5ks3VcbkvTE
 Ots9Qy+D2HgyCAtENs9hWBS0fBLJ5KB5Ka3HMaABVN0DTP5ekayOJ8vo
X-Gm-Gg: AZFdTZe5prbdPdM9TVeiLrJWU5bP7zn1gSO9TBMhBzc9ONB88Mp5ulgx6A5n3xXfMAG
 zWGM8swlDtY+8SiVGtr0lQu8u06qyOBKe8+QXoUYdHaeAbCq+bflRvZ6JBrBQ8tN2HZO/DMZhuj
 jZA3prwYmFP72VMpGMGkN2see+Wn/EVKvN9y1j9EMeu3TienIcjAcS/hh1WWUXaCtkUPIgoHKpw
 Tb1k2odNphdjqVrkF7IzVbMJsZRZN+p5Rg1zWQEKKY5BH628WTWE8LkxsPqVbBuWF1X9COHRlTa
 GKJo3ASawON0eII74bSN4cZeZXZdgbK4UaTd6gRrM5TUEubE7em3wLSxV/J9YOsmLTihzHTejBj
 2tfEwceiM3tMfYdE3sOOXdq/aWLwnXOj6yMEwxNMU0PyLvZtlXQ/ifa2xUgO6i0lfqCPNUHEouI
 ko9EjSvDhaCKW/Cqg4ndv4i7RhE/u1QkluXjNP7juVHoHsqo3GYsdp72AekYhEQUSZs5OgtszbY
 cCdSHGOr/fJkdUFEyDbcHBBdjk/w75ppuB4UoO+OQ/PmVruwVDEJr6iTTsVVsMp2lbgQacipVCF
 ALi2qHl6gPhunxAMgG3gYICUS0q218oI4Iy7OF3On8jKEwecqCrCWJb9QJVt+TKNc2w=
X-Received: by 2002:adf:e009:0:10b0:492:b1c5:6db4 with SMTP id
 ffacd0b85a97d-4abb4c7ab68mr28124075f8f.26.1795684512114; 
 Thu, 26 Nov 2026 01:15:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm37029320f8f.34.2026.11.26.01.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:15:11 -0800 (PST)
Date: Thu, 26 Nov 2026 09:15:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Petr
 Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Message-ID: <20261126091510.7ac67b35@pumpkin>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 17:40:11 +0100
Ivan Vecera <ivecera@redhat.com> wrote:

> dpll_lock protects topology and object lifetime, but it also serializes
> all driver callbacks in the system, so one slow device stalls every other
> DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
> commands with a 60 s default timeout, and zl3073x callbacks can wait
> seconds on a driver lock held across ToD writes and phase steps.
> 
> Make dpll_lock an rwsem for topology and lifetime and add a mutex per
> domain for callbacks. A domain is all objects created with one (module,
> clock_id), in practice one chip or card, so channels of one chip stay
> serialized as drivers expect, and they still block each other. Device
> callbacks run under the domain of the device, pin callbacks under the
> domain of the pin, whichever driver registered them. Only one domain lock
> is ever held, so domains have no lock order. A lock per device would not
> work, because pins are N:M with devices and callbacks notify sibling
> channels.
> 
> The driver API does not change, but a callback can now notify only
> objects of its own domain. Patch 1 changes the one in-tree callback that
> does not follow this.
> 
> Registrations across domains exist in the tree only on E825, where ice
> registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
> These callbacks are no longer serialized with TXC and TSPLL, they rely on
> pf->dplls.lock, and requests about these pins wait while the external
> DPLL is busy. Intel folks, please check that this is fine.

Isn't the big problem with callbacks handling deregistration?
With a global lock there isn't a problem.
But as soon as you do anything else you have to have very explicit
rules to safely deregister a callback without either a UAF or an ABBA
locking issue.

I don't see this being mentioned.

David
 
> 
> Each complex of a dual complex E825 has its own DSN and so its own
> domain, but both use the CGU of complex 0. The lock for the registers
> they share is in a fix sent to net [1], which this series needs. Without
> it a test lost updates of them.
> 
> Patch 4 is the only patch that lets callbacks run concurrently. Patch 5
> adds KUnit tests. I also tested each commit with a mock driver and YNL in
> QEMU, with lockdep and KASAN, and the tip with lockdep on two systems:
> 
> - A board with ZL30732A: every notification the driver sends from a
>   callback, concurrent traffic with PTP, driver reload and rebind.
> - GNR-D with dual complex E825 and zl3073x: callbacks of the pins shared
>   by both drivers, TX clock switches, RCLK pins of both complexes, a port
>   going down and up, and both drivers unloaded and loaded in either order
>   under load.
> 
> mlx5 is build tested only.
> 
> On GNR-D, with ToD writes running on the zl3073x and requests waiting for
> them, requests to an ice DPLL took 1448 ms in median and 3.9 s at most
> before this series, 0.2 ms and 0.3 ms with it, the same as when idle.
> Requests about the pins shared by both drivers still wait for the zl3073x.
> 
> Changes in v2:
> - Dropped "ice: dpll: serialize changes of the SyncE CGU registers", sent
>   to net with a fix of the SyncE divider [1]
> - Addressed the Sashiko review, see the patches for details
> - Added Reviewed-by tags from Petr
> 
> v1: https://lore.kernel.org/netdev/20261106121005.1327603-1-ivecera@redhat.com/
> 
> [1] https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/
> 
> Ivan Vecera (9):
>   ice: dpll: notify TSPLL lock status from the periodic work only
>   dpll: add domain object
>   dpll: take domain locks around driver callbacks
>   dpll: convert dpll_lock to rwsem
>   dpll: add KUnit tests for core locking
>   dpll: reject measured_freq_get for foreign and on-pin registrations
>   dpll: zl3073x: update locking comments
>   ice: dpll: update locking comments
>   dpll: document locking rules
> 
>  Documentation/driver-api/dpll.rst         |   48 +
>  drivers/dpll/.kunitconfig                 |    5 +
>  drivers/dpll/Kconfig                      |   13 +
>  drivers/dpll/Makefile                     |    1 +
>  drivers/dpll/dpll_core.c                  |  204 ++-
>  drivers/dpll/dpll_core.h                  |   34 +-
>  drivers/dpll/dpll_core_kunit.c            | 1580 +++++++++++++++++++++
>  drivers/dpll/dpll_netlink.c               |  117 +-
>  drivers/dpll/zl3073x/dpll.c               |    9 +-
>  drivers/net/ethernet/intel/ice/ice_dpll.c |   24 +-
>  drivers/net/ethernet/intel/ice/ice_dpll.h |    5 +
>  11 files changed, 1919 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/dpll/.kunitconfig
>  create mode 100644 drivers/dpll/dpll_core_kunit.c
> 
> 
> base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219

