Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D2606A31F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=p8yYPsZQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydSimZu3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A84D240680;
	Sat, 28 Nov 2026 13:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHmy7gP5gwoH; Sat, 28 Nov 2026 13:32:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C05FF40677
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795872753;
	b=mNSPp5OuG16R8PrS3Ud5Ai/XVmnqGDzRXtf16cWQFz9OW4WNtVxggPFNftXSjKU2I8kg
	 enAYbQpbSglA+Scb+XW++VSjFVhY5pF06V4xsiIhGHw6yhPMI/CUDt/wIpr59Fgchxut+
	 s86RziJ65txx2wiUkL5NsK9UpKuvDmnsQQZENTJ2rvriELZbtMaiwKcUSvKXkadmG6dJ1
	 kb2r2CL6iF0ps9AcyeYQLZucHI7yDF3d+01vYCN1CFw6ud5SimEWO985Ndam+PXaUbRtd
	 Or/GdD83C7zkah0PQhpazfAB7NsIk0Z0DAzJ2OjTVVxbQicuH0Z3J4Hh92wj2w6acHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795872753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
	b=inCn/Y8ZEySgWCrEGXaGKsL+fO8pp4RCNg4osTczs8yJkMpOA8VAhMn9wUQUYau9N+Mq
	 BNucoIqR0IiUQbU6P6oivb264bRPgt1pDHGVfW376Hr6MGgY+8LIjAT0UYbyGdhDSreM2
	 JIRkNKvaXVaFNNvoZ6ZtGm0Pb8L4kH0B8FolGA7DAvp6J3KC2tyW+2NQbLRTaXlFP/dSJ
	 ZcTfzsHD636tkTupa/gycqk/en+4TJgGD92Ym+OpjG9MvMCesV9apNxJOw+PNCNyyw4Mf
	 CENQXwwb+VHKqrnCoe0nMoI6z73Z/NUyW7G0rwMnCoZbfTp2KEc6wxvfShnA28mGzBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795872753;
	bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8yYPsZQFl9xHiZh8yaHoQ8vl1lLGGZx8sTlDp0cruhORJHVE5ZfIV9gXYFpw4hod
	 4Dtqh+y6+JWY0dMPidOL8rTTYjd48YcSd9szRh20RYq1uxNj/2qS1hQwF42xpiVOka
	 iWlbPOIoVmk3PuH4xV+/9XjveW3PKDiG7JRynsvK9ZxLXiq3K1jHi9dAxlmY1JH84F
	 2m7QxilSkzzFSKMWiTcz7xb/be54NWxqnggd5p8KoS8ZGgNQ0PzSHUIpgArkOZV+Cx
	 euzPWm1OmFiBpb7UHs52LtzE+276S2YfYumjTIyshY/QOJxYQaLWF2Lh8pU0mHqp4M
	 qBpu9+rj8/Y1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C05FF40677;
	Sat, 28 Nov 2026 13:32:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8960E472
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 685306063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sk9FIJI53y3n for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2237A60635
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ydSimZu3
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2237A60635
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:32:30 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso110002485e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795872748; x=1796477548; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
 b=ydSimZu3POXCLn/Y9o8DiEhOfMdSn/EetXrOPgdePHFLome/MBihi7BI1FAfmONGxt
 uAaTKW1BcsZC0/KGSRFhBFxxl1PAQxJyrTA8Zn44b69WhZqXifFlGk1DJgWWzG9IPlCP
 ge4oGszXkA3JZ3FcbvPNG6rFAkYAlMG7C/o4wNVH1hytp8DEcxskxjUO8+GgzGahm9ih
 pW/Cezi9r3vxGECQzCHuqdf9VO8I51lXByNCigI8dI49Vc4SpGcSU1xR0Ucx4KxXF+or
 pjdFmQE7xL5Ad8gutRxsNpYcaeZl5uKZmir6ztv6ifEbNDHasLSRaTINcOOlqngYIub+
 C/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795872748; x=1796477548;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4V2a+V6fQG2NiQXAdRuUPTgWpRpo/WBcKKqghb1iDS8=;
 b=TFL/Y2enk5jUIoxFwoxy2IacDoIOEoIHkF8uOOTyBT0qI8U41NFfc2EFX5rVAsNtyh
 deDLt0PGUr1Uir1Bh/nFcJubdLUOM9lh2undciRoxjbFcbOPCLvFn3oj7/LJAcSJEe1z
 VsNDgpplxWXE3uRqVSGpIusf5Vxb4lrGFqIgPBJHCl5JdyT1Vw/MoXyoybK4YbJJZYan
 OMoXMkqRuTYtnWW8HV1yNQ6MCLml7DVS2Hvr6XXc5QxajQUDDUlyaGnOpM+Cc4Nl7igp
 1kr+nB90UNT9SGdaA5sM7j91GWE7KrRbyhsAtpOaddbGCykQerd4ufegtzwAnW8SWTKh
 UGzg==
X-Gm-Message-State: APuU4Z/XlOGeH9HG+gvkef/fJ2zterSFrrKWw/4THuVBWos07Qqde1J0
 dlcMR//5jMUE9Wd5jtUn21SwShVMGQRtB292EZTF4P1fVkV27IevfEP0
X-Gm-Gg: AZFdTZdIBgJoW48aq8UkExuChP8+QnlrzGocqF6QCghyneGijaU4JwcOTDLi6sgG342
 z+CwRQHtcvm3oSGOp2boDU8hKSbNRGFPERM4dGTBKwmbA4kTyIKBPjKsxZ1ALg8pMtpwNxjgEVl
 Ra2amwKDoGvZU/LE6YBJ2FGKqDxgM69Fy7Ppv2wD36DGU9KcNzlasvhr/EUthT/KSBIQcUsClNb
 kR3Yvs/XIoBMigEN5UCzObuhWNfjOrfhA6XYT+BwrH0itHFz0vH+77ve6zH8QkdGiLYQupmlwby
 V1B0qrVsHtBPcYcx+5LHW0OeN1sgoqXxeHCtKMWR9Qg1pVqvRJBcjYnNq7xQPiOrFPFU4wcUwXT
 m4Xybc5YOlv5drHO59hb8V95zTNOl2RPNNu2V3tiZ5vlQ7lUmyPZT4J+E+fJYMflDWQSM99537t
 Puiwmyer/0xpFMhFnRJhaeMqHNUMsBa3IyzjG2lrnMfNGwl9gPzYEYGofmM5nUtmFkdruzWGNVx
 MB3yUOfODPTw0eq3VbNuEuV0GYxOhJJ/qzBWOe6sm8TwWsCamL/ikavmYVvnYAmGWc4UyNqr9aN
 QTQSKXbTRLnoY7w3VBi76Q0ZZ1QK72JUitTIMfkarjwg5GrcpCRd/Fphjk7IpI3W44BJvdT4ImD
 WaQ0J0nkX5LXAPiNT4EMwLskzcCJVUIxATqPN
X-Received: by 2002:a05:600c:1d2a:b0:4b7:6942:39bf with SMTP id
 5b1f17b1804b1-4bb88814031mr666559775e9.28.1795872748317; 
 Sat, 28 Nov 2026 05:32:28 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm790112755e9.5.2026.11.28.05.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:32:26 -0800 (PST)
Date: Sat, 28 Nov 2026 15:32:23 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Joe Damato <joe@dama.to>, 
 Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v5 0/6] igb: fix runtime PM resume issues
Message-ID: <5k4igk5etdbmaweimm5ams44kwe3vzcqjmnck6a2w2iyhsfsvd@ianca2g23kva>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 Nov 00:57, Antonio Quartulli wrote:
>igb can be runtime suspended when the link goes down (with
>power/control set to auto). Resuming it calls functions that need RTNL
>without holding it (patches 2 and 4), XDP and XSK changes race with a
>resume (patch 5), and devices that can't signal a wake-up are suspended
>anyway, so their port stays down when the link comes back (patch 6).
>
>Patch 1 fixes the XSK pool disable path when the device has fewer rings
>than the stack has queues: a NULL dereference with VFs (a single Tx
>queue on 82576), or after a fallback from MSI-X to MSI on resume. Patch
>3 keeps such queues while they still have an XSK pool, so that the pool
>can still be disabled.
>
>Tested with the 82576 emulated by QEMU, including, with test-only hooks,
>a runtime resume and a simulated system sleep (the suspend/resume
>callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
>with the device forced to come back with MSI and a single queue.
>Patches 1 and 3 were tested with a zero-copy AF_XDP socket: closing it
>after enabling a VF oopses (queue 1, stock igb and v3) or warns and
>leaks (queue 2, v4), and warns after a resume forced to use MSI (v4);
>patch 5 by closing a socket and attaching an XDP program while runtime
>suspended. Not tested: real hardware and PME wake-up, a real system
>sleep, the MSI-X allocation failure itself, the window before the work
>item runs, SR-IOV with runtime PM, and a device that can wake up. Not
>run under KASAN.
>
>Sashiko also found two pre-existing issues in the XSK queue disable/
>enable paths (the Tx NAPI isn't stopped when Rx and Tx don't share a
>vector; a failed buffer reallocation leaves the queue half torn down);
>they will be fixed separately.
>
>igc has the same issues (see the notes); Joe Damato offered to test on
>igc, so its fix will be sent separately.
>
>Changes in v5:
>- new patch 3: keep the stack's Rx queues that still have an XSK pool
>  (Janis)
>- patch 4: cancel the work item before a suspend (Sashiko)
>- new patch 5: resume the device before changing XDP or XSK settings
>  (Sashiko)
>- patch 6: check pci_dev_run_wake() when scheduling the suspend
>  (Sashiko)
>
>Changes in v4:
>- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
>  tear down the Rx ring and skip only the Tx part (Sashiko); subject
>  changed from "don't disable rings ..." to "don't touch rings ..."
>
>Changes in v3:
>- new patch 1
>- patch 2: set the real queue counts on system sleep resume and from a
>  work item on runtime resume, and drop packets for queues the device
>  doesn't have until then (Janis, Sashiko)
>- patch 3 (now 4): link the NAPIs from the same work item
>
>Changes in v2:
>- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
>  only skipping them on resume (Sashiko)
>- mention the tested hardware in the commit messages
>
>v4: https://lore.kernel.org/netdev/20261120210134.133238-1-antonio@mandelbit.com/
>v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
>v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
>v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/
>
>Antonio Quartulli (6):
>  igb: don't touch rings that don't exist when disabling an XSK pool
>  igb: fix RTNL assertion when resuming from runtime suspend
>  igb: keep the stack's Rx queues that still have an XSK pool
>  igb: link queues to NAPIs under RTNL after runtime resume
>  igb: resume the device before changing XDP or XSK settings
>  igb: only allow runtime PM if the device can wake up
>
> drivers/net/ethernet/intel/igb/igb.h      |   1 +
> drivers/net/ethernet/intel/igb/igb_main.c | 144 +++++++++++++++++-----
> drivers/net/ethernet/intel/igb/igb_xsk.c  |  37 ++++--
> 3 files changed, 143 insertions(+), 39 deletions(-)
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
