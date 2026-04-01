Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58685D35179
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Apr 2026 12:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 199B760FB5;
	Wed,  1 Apr 2026 12:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZS00rFEQFC9r; Wed,  1 Apr 2026 12:25:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5049C60E3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775046357;
	bh=kjbmHOYNPdjWQqtIIqSCC0ouY/w5LYFYyqsodL/XAZk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RiM3XSJelJIPnYhxjZk9ggq79SLgiutHMBjihmgqjfPOohVjzH0jTrErsZjsTdbX3
	 KaTnrGq5uzDjtwWdyeKCfg5mSFs71B3mmcNtr6qeo8Y+SAviNu3OHaiHBpjelhQCm0
	 9L5U5aOPUkbsB8l4+EvoZsWhBxWDTaoOZd3ZRkRG6lCrZM7da5FPwvGJjs5L+ec60h
	 +w0c1f00R5oiG5VD996sqAKjviugun/Bs0MFOsbeEt++okJCT3GlYAlQ5lzvlLzwDr
	 QtYenUcX9JIc526buLhQw83fAkbpYaPHZayBQOFPN/d8/h/8ESmhilbe93lxHB59Ag
	 knzklV6x8pZ2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5049C60E3A;
	Wed,  1 Apr 2026 12:25:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3438925F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 231E080EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGCmupBy98Wf for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Apr 2026 12:25:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.149.199.84;
 helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 467AF80EBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 467AF80EBC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 467AF80EBC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:25:52 +0000 (UTC)
Received: from localhost (unknown [10.10.165.11])
 by mail.ispras.ru (Postfix) with ESMTPSA id C46E140737A8;
 Wed,  1 Apr 2026 12:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C46E140737A8
Date: Wed, 1 Apr 2026 15:25:49 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Agalakov Daniil <ade@amicon.ru>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, lvc-project@linuxtesting.org, 
 Roman Razov <rrv@amicon.ru>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniil Iskhakov <dish@amicon.ru>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20260401152405-43e821d5458d9b8b8ea8cd5b-pchelkin@ispras>
References: <20260325151615.1407182-1-ade@amicon.ru>
 <20260401120919.282668-1-ade@amicon.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401120919.282668-1-ade@amicon.ru>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ispras.ru; s=default; t=1775046349;
 bh=kjbmHOYNPdjWQqtIIqSCC0ouY/w5LYFYyqsodL/XAZk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GK0pB+npyko2kR2HRFnphk8B25MDH8xxhKmy61PV8LAO7xZyOvHpsbGuUwcumqlKK
 AgOGMWFDUcuXQH1oJCWU+z7KLa351pJWdFP35A+y4CvnVQh7eycfNWUqSaHSe2kuyY
 0699eQqa4dPw9WKnZSK2r2Z5xza7DEx7GMskEta4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=ispras.ru
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256
 header.s=default header.b=GK0pB+np
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 0/2] e1000/e1000e: limit
 endianness conversion to boundary words
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

On Wed, 01. Apr 15:08, Agalakov Daniil wrote:
> This series refactors the EEPROM write logic in e1000 and e1000e drivers
> to avoid processing uninitialized memory. Instead of looping over the
> entire buffer, we now only perform endianness conversion on the boundary
> words that were actually read from the hardware.
> 
> Patch 1: e1000: limit endianness conversion to boundary words
> Patch 2: e1000e: limit endianness conversion to boundary words
> ---

Daniil, for future submissions, please post new versions of the patches
in a separate email-thread, not In-Reply-To.

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review
https://docs.kernel.org/process/maintainer-netdev.html#changes-requested
