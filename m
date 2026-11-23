Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6892606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ffrxLuFa;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=FWIRLrFU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F61D80CD9;
	Mon, 23 Nov 2026 04:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRibp96umCea; Mon, 23 Nov 2026 04:09:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B724980CDC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406983;
	b=OPa2PfZjdShKAIeSBYUx7dyFZ1Y/vE6SeDHGMgesIqgINE/e7ExmeazJQXK3Laa8wIqD
	 sJ4OL9kcreQZZK8S4QzPH+ym0ZZSscVOB/hJPtnJKm9/BVs2Ikk7BGpVqXf+PHnRkyZNk
	 XEVJzVSY7X+VcocL8idmUucn/upWmWLR8aMLo5UnYx5sl7iZ1IOjFKaKjWbKPTrkUxTId
	 zxA7JfA1P1bq9ABJdcR2EO7rG9G/sFr+c2QbWQmt2xymi6xYdeiMWcM6fA45c5S40WddK
	 99Cd0Zic96VvjWeemqeZrzxOAsR+KTQTSSteQ7SqXOsiNg7PubfocKAqNzTgAdOa3Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YLKmTz9mXxZ44RenvTwUZJjRcB/29lTMpfzoB+6Aoqs=;
	b=YK/y33tvNhQuFt4Qx7QyE9y8+60unUUP9nlLq2as5FXTzKVd60NYQPP2hG8vffVuFBZz
	 MEsRbKOcPd6c/nC2kj+H4kqOTvWmRJtQV1YppbXItAD06qecWSzsJ5SuXPtfj7hqBeGRz
	 X9wFxTFeEm7LPEoUQuWDIGpZzS3Ed1izrX96z+i0TBwvvuKfCol3VxgMGxSSQ46Bo/vUw
	 RqJ8wTG9KRPKjbOntmyCnJLt89UlPv2Q3MUgWLtBxmSTWDU/J5IAXWh76/umZ/ussrjx5
	 /KSs2G9t4ZxjtiZD1rJ4AyZ5aGwqFMq48puESLFhDilCY9kfN8OjGh5McIS7m7pkfOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=FWIRLrFU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795406983;
	bh=YLKmTz9mXxZ44RenvTwUZJjRcB/29lTMpfzoB+6Aoqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffrxLuFay7aT9QFUSAHpIBV4G0Tjk5OVUmpH+drFfryXsdG8dp5fOavMw5uQM90Gg
	 ESABK6dIh3Fh8BYE1xTfSaha4DegCwn49Q6s7j1SqLx7ixnlTnM96V6cUkSNTmaTnA
	 ArjWEPq5srl2mR4Fn3BgqTpQ/1iRHJ9fcEIg+BdM1CGXXFp569WQZgwvRQuclraPJ9
	 6wAx27yWKaSs9lHgxqWgXGArK9mxeV2IIpaD/XYh/x6nH1U3HRkNVA8QaVFQQqw8VV
	 dIZOs6rYllcCc8C55b25ckSkmr9MmJgJQHDZtythkOzM52Dd0SP/8qto3iBvlK3mWW
	 U3wGvyR1cGpiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B724980CDC;
	Mon, 23 Nov 2026 04:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE1AA22B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 04:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B391C80CDC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 04:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10U15nfjcgOX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 04:09:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E5E580CD9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=FWIRLrFU
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E5E580CD9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 04:09:39 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC8843F1C0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 04:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795406976;
 bh=YLKmTz9mXxZ44RenvTwUZJjRcB/29lTMpfzoB+6Aoqs=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=FWIRLrFU3W6V26zT9JCOpa890FckjHuHrqktJd33bVkNKYfXLRNpBqqTBGNS0gSnh
 ZH5ctvkaRwikIhv018gQWyGjMAS3ZDdiUSUKdtgOO3tf10RyKwAoRZokveyqlCFcZd
 dWp+UWlHTQ/bRhSQq2fN+wt+P3DIBx70WA+BU1Q1vSt/Dpm25Y9cpctCrW4tp8kaTX
 V01QedYjvtX7zy04UdWkt8EwdChUef/4Dgsa1lJPedjRsHWJiNZ9AmibYmT9zxJ9k8
 t1lbwBf5khySFXKRT1Ib87oZQs2hOmaM6d8YL/O6VclwoONmV5XSg0gqD/9cRZz90R
 cMGZefUkOUDr0F1Vza5kfMobDfSRhMYoP8rDH6wmmOtzjsuHy5KzLOItqL/YabsXW2
 UhOt3/Ymgrf7pHYWf8zhgaBUCKRxQkxdRk2BVDIFY0qZf/NEbLI5eEjbkW+BOhUjo3
 5rb6yK0mnOrrEYfA6H1T4LF3M/a72sZR9PGCEHoI9XfD7CL4WZPxmjF1fnlm192C51
 SeYp1cAV52jeEaLlzccqeSpGbAmxEaNoXeJvTUofNraSkj5ToTxAnq3J6kPvtBPazE
 NCpEzCksXU/7+Wkpl/6ZuqgGTetQoLtfNl3ukhGBUPf3v7e+yn2EBTVYfjNu33Z4OX
 uMIQgMIvxGddGok+ni0cq0Nc=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed05b3eaecso25799185ad.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 20:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795406975; x=1796011775;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YLKmTz9mXxZ44RenvTwUZJjRcB/29lTMpfzoB+6Aoqs=;
 b=W5K7ku3vOPKPGom0c758uP99A/vAbD3+QYS3sRevlSlzRDjbBhkf9dLvYPBCrFklI3
 zDicx3jnOrkeVKlXwk4pkBT3hckSJhg906tVuIHLy0+XDAnAkTxyg40s/Ta7XMm2xNSE
 E2cJErt9JcpboAJHoMi8vsBiQLVms6aJyPdlOV/vPXTvhxOWUmJ5Yucah7PS7Rw28U43
 6niSyiQg0hea11XciDnZwxEDXtEO217Ecpdyhf3S1+oT4RDUGy0Fy0Z/2ubPvTs1+6f7
 1Qy+bf4mYBBfxEmRoWE6iiSqTtWnOKX2QV88f/cespc4KTZPRvE5XaRSSMriDIVEqxNN
 KYlg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWt4OlzWoMGbb34pr6PA6207uCl5QcnYMYrsLyZhkrkfDhExJ8rdtJ0Q3boXdmIa2usnO7T2w6i4nxEAR6rq8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z//ten77mxHKwoK6VeyGwEcDXDyj42EDSrUjvOFTFcq3OcJh2uW
 vKYRo0iiVsAW4vtbyF5/vzX/f8cVLW1Nacj3K0aZ0UU/+71kQu5kIjZmxwEJnVeNCVp4DcHuxf6
 wB0TMcln3+HbBmSWwt4rmiqkVaKRRDaImkUR2UKhSuS0J4O/8LTg0JEblca4FPE2bC8Vb02gVmb
 AJC9VJbzKqc2Y=
X-Gm-Gg: AZFdTZffYWx7O0Ftilkm8CYHd9yveVjJz4TuySb+g2VJC96jPRbSnXONqfCLkO2TH7X
 s83roHbcDcMEwRYLC5lhcPCo78tiEawLeBk1iGRRDTyzUdol+LniyMNutBZY7oX8hVszXuQ5fe5
 oPwCaPCBWwRRhmiI5l/t0kWxtT189XTbsaRR/KSJjtlHnjiPTtYD4MEQphGHx3btgJxDFkx0LjN
 aMjfBQ8hhBzICV/3mgjTQKw+hFRYhZ9ccDcXhuPhUdZimlONX8N7by4k9H09/s+g9CYbCayQAUF
 ARE55sPkP2No+Yr+KdISa1+45Pygtqaji9l6A3dCDh0Dgupk4BbS1Otv9vdHIQMgGtvmBOgiHmo
 m5Z8P12c/9BxJCgEQe+NLEqtIJ9r9MSdra7BvE4EMtlgs5YW3Cw1jjAn+3VCufNkh7FVIw3N918
 MPbbRH95avDoJ3qUhbPaav2WzpTTJY
X-Received: by 2002:a17:903:2283:b0:2f0:7707:228e with SMTP id
 d9443c01a7336-2f077072aeamr39456355ad.32.1795406974997; 
 Sun, 22 Nov 2026 20:09:34 -0800 (PST)
X-Received: by 2002:a17:903:2283:b0:2f0:7707:228e with SMTP id
 d9443c01a7336-2f077072aeamr39456135ad.32.1795406974561; 
 Sun, 22 Nov 2026 20:09:34 -0800 (PST)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f118c88sm45431965ad.56.2026.11.22.20.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 20:09:34 -0800 (PST)
Date: Mon, 23 Nov 2026 12:09:27 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Ye Shu <hello@shuye.dev>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: add Dell Pro 5 Micro P5M1260 to disable K1 list
Message-ID: <awO7PG_bzIjHuq4O@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 Ye Shu <hello@shuye.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261119001818.513503-1-acelan.kao@canonical.com>
 <c4801ff7-7ff6-457e-b0a5-c2e633d35c59@shuye.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4801ff7-7ff6-457e-b0a5-c2e633d35c59@shuye.dev>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 05:54:50PM -0800, Ye Shu wrote:
> Hi Chia-Lin and others,
>
> On 11/18/26 4:18 PM, Chia-Lin Kao (AceLan) wrote:
> > K1 was re-enabled on MTL and later platforms by
> > commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
> > Since then, the Dell Pro 5 Micro P5M1260 (Panther Lake, I219
> > [8086:57b3]) no longer enters S0ix during s2idle.
>
> I have independently reproduced a similar S0ix issue on a different
> machine, an HP ZBook 8 G2i 14 (also Panther Lake, with Intel I219 NIC
> [8086:57b3] using the e1000e driver).
Cool, I think you can try submit the patch for your machine.

I also verified on another bunch of machines and found another 25
affected machines.
The impact of enabling K1 is huge, I'm not sure how Intel will handle
this. But for now, there is no harm for sending out the patch.

>
> Machine tested:
> - Model: HP ZBook 8 G2i 14
> - DMI system vendor: HP
> - DMI product name: HP ZBook 8 G2i 14 inch Mobile Workstation PC
> - DMI base board product name: 8ED9
> - NIC: Intel I219-LM [8086:57b3], subsystem Hewlett-Packard Company
>   Device [103c:8ed9], driver e1000e
> - Distribution: Fedora 45
> - Kernel: 7.3.4-300.fc45.x86_64
> - BIOS: Y70 Ver. 01.01.07
>
> With K1 enabled by default (disable-k1: off), S0ix entry is
> intermittent. Some suspend go into S0ix while others do not, even with
> CPU reaching Package C10.
>
> > Every suspend ends with:
> >
> >    intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
>
> Failed suspend produces the same message:
>    intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!!
>
> > The PMC low power mode status dump shows the GbE IP is never power
> > gated (GBE_PGD0_PG_STS, GBE_D3_STS and GBE_VNN_REQ_STS all 0), while
> > the CPU itself reaches C10.
>
> The PMC dump shows the following:
>    CPU_C10_REQ_STS     1
>    GBE_PGD0_PG_STS     0
>    GBE_D3_STS          1
>    GBE_VNN_REQ_STS     0
>
> > Disabling K1 at runtime restores S0ix on the same unit, kernel and
> > BIOS:
> >
> >    # ethtool --set-priv-flags enp0s31f6 disable-k1 on
>
> Disabling K1 using the same command appears to resolve the problem. I
> performed the following A/B/A test within a single boot, using 120
> second rtcwake -m mem cycles and measuring slp_s0_residency_usec before
> and after each cycle:
>
> disable-k1 on:   6/6 successful (~116-119 s in S0ix)
> disable-k1 off:  1/4 successful (118, 0, 0, 0 s in S0ix)
> disable-k1 on:   4/4 successful (~115-119 s in S0ix)
>
> Since this issue also reproduces on a different machine with the same
> PCI device ID for NIC, would you prefer adding another HP-specific DMI
> entry to disable_k1_list, or do you think that disabling K1 for all NICs
> with PCI ID [8086:57b3] would be more appropriate?
>
> I'm happy to submit a separate disable_k1_list patch or test any
> proposed changes.
>
> Thank you!
> Ye
