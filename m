Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8611E77188
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Jan 2025 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 542CC6067A;
	Sat,  4 Jan 2025 16:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tk5ZujeH88QP; Sat,  4 Jan 2025 16:15:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B03856069F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736007337;
	bh=RIhjJzkZeF31s0f3HvXjk2izopkF30SV7HRM9AtSDIo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9rkWeEHa+zfGVgScwZmqWeBlseCtrKQ61BtzgMyHrKo7nyqBznDLqjz46mlks1Fa
	 soxOa6U83q17OJ8pzzt8jBl1Nyc9kXcK6wNXdaFHqxEB4+5EDRCwdh4/+fjZJiOq4+
	 wsq7Zg+TmocFWY8vDnHVWubvKLZAFkXoUX/V7We9ARtpXpFuP3Ovdh8+YuBrLLf2kG
	 2XX1pddqm1dqjgJ5q8ZwnoM+ETaHp+Oyrwoz74Bs2iXZkOlMC7Rl/7VY2Wz69OLMZG
	 PJH2rPYZDKTPu6Inj5lt8qiIgZ8QpDH0UVkngKnf2EheyJOHnK3w82pKpNqcRh4K2z
	 HIcyzkSMNyvQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B03856069F;
	Sat,  4 Jan 2025 16:15:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAC38E0F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Jan 2025 16:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8614E405B0
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Jan 2025 16:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xReBTwTloBgJ for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Jan 2025 16:15:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C0687402A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0687402A1
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0687402A1
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Jan 2025 16:15:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C99B55C56FE;
 Sat,  4 Jan 2025 16:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D9C4CED1;
 Sat,  4 Jan 2025 16:15:33 +0000 (UTC)
Date: Sat, 4 Jan 2025 08:15:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20250104081532.3af26fa1@kernel.org>
In-Reply-To: <20250102174002.200538-1-linux@treblig.org>
References: <20250102174002.200538-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1736007333;
 bh=CzC3HkeHDNX/3MpmOMssKaK78kMCsdyfZ4EaUShTQKk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=COsDlN1ytbEp2sPX8XRvKVebAnnt+LyAebyzntUvIIp18MASGX5HUKi5FKR5P4IKo
 AQG1+ZX7ttCSS4Iodc1iT1A0YNIbTNDzjL02P5r93/7QscSF9JE6uxabM76LdkPhPb
 e4o4Da7IHt4GEPlmJVhnS7rClZDUTFFXvPgpk2STloCoN9HIpp3KfD4olxoELQQVWk
 p1xn0E4oF/O39OCLNHY6WbcN2Qer93vj4VDlmIBhPlqDxZ+ezx38JYFYI6Qs6CjzRj
 FBjyKC1xkVaZnQf1i7S15HKcbf9HjjX80t2X/8oZoVt4CRllcqRa6+o5q3G2zTQs+z
 /agb1UtZ3CffA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=COsDlN1y
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbevf: Remove unused
 ixgbevf_hv_mbx_ops
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

On Thu,  2 Jan 2025 17:40:02 +0000 linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> 
> but has remained unused.
> 
> The functions it references are still referenced elsewhere.
> 
> Remove it.

This one doesn't apply, reportedly.
-- 
pw-bot: cr
