Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B70606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=83Ciz3jM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUyOPVR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D989460735;
	Wed, 18 Nov 2026 07:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGrrjp7vVo6A; Wed, 18 Nov 2026 07:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CE156081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794988117;
	b=bF7j4BC4So9lM78uzHmbmdvNbx+uxSJdCxE/WHTIq6NDa5CyfQv9QKkpNYYXktLU8All
	 G8+sY8/uJXdP4Y8i46vPPw39h/cQ1BhRK6kgC5P9XoOrWo75EytSeQmdhfiTQM4cZT+6X
	 7DQDY6YYWDSuc6EUk6acXTdT9W0q3RpsaKEW8oDmG8zYvoWqWRN5PGMM285Qqb2/5Vy88
	 y9MJ2J6D/wD2GiJ4+c3gE5quL7pGlW6dbAR966qpJNL+QJWDagepkiQ2Dc6el3aJQUTMn
	 zzNqf4HvJC9LqnLEjbDYdpwcsPYckCMX/uR+evXla5fmjpudYJN99zlBtW4Qc5Y9D2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794988117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	b=GTUX2dWWL1HNh7g1bmI7G2ay5kiemWdSkG+7kbFUiu4+E2i4F7CEBtGyrCV0EsY7L1Mh
	 hnNEs6s6KJ8mFLYIMm4cv4vXxwZ8TOTe1Vhf3be3KHw82X6YTqjNqUgrqwjwAa338yetq
	 ZJTsrb+WU4G3/Nnw/IOUExm5l28IpWnCEOaU0Lmo3GGjOY4FEh7U3qEACc5GW8MXw6R9M
	 ZJyxmFab9dOCuWZqhi0F2m+ODQ/CLJfD9yF5VkKiODPvmvDvupBKuGV929W/sAu7VgR9g
	 Np4vc7pLrKXpq7T6BUNHni4cA9Kak+aGt9iAAcXwx6clkXRMqAft1qXLZmCJ7Sf+rdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUyOPVR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794988117;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=83Ciz3jMC/3JC6nBJ6pzRCIVLBx96cKMnylQnopYRqTomXSwfDEUJR310pDJwae/D
	 Qe6ajCGJuYOvWmqDllgEVlSPum7Q9KLd5soPqAwaWpJArrxb5x3BFX9ilWpKjhjARI
	 EdWkcyBB7lcLP72UkA+fUKHlENYLGhqok+wrRnpAkd1p5oM6Cup/Feeztc2cKueo22
	 BnffSwjvYHRdhGyZ7qxl+IJu+cQ7ReOXC4BshiTZJj/zC3ReU2EEIQOGQVYOk5AEaD
	 V3Z9O6hee43MkYRX57NDFOMwz11dGY9cPH8LcyBEVtnavDxYpx8T5jDAk7cBdHzz6y
	 TZkkhJ3MTPfWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CE156081A;
	Wed, 18 Nov 2026 07:48:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EE5B49B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 054706081A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBe0GY4kJvN5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 07:48:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DB3860735
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YUUyOPVR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DB3860735
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:48:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91B25601FA;
 Wed, 18 Nov 2026 07:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA2F1F000C4;
 Wed, 18 Nov 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794988112;
 bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YUUyOPVRat2Zhm8Z8rvJjjQAzYllaE0HfjcF4x9mPrturX7w5IQOAieMahfF9MCCF
 tABRouP03sjIcVMCEtF1W7g3PdikQ+hkf1xypHAWmerjDt6byIDu5Sxr69BiVRXOII
 Zf2V4aczJenSQLXWuDzF15TRKWsF96nTuXu++50sV0r4mOMCrE/OvyHB4/7R5e2pVv
 sNPsgJLrUwm4ERfXujqiiG/WfCOAsO4bD7nAjUT7xRrd/wkUjK4QqNayL0mQLyyJfy
 uuDO1Tx3ZEWNCpuM7RnfSyU8TjXbUSb2NOdZ9I20dAyKU4gkfj/fKeaBfPIX8xhPPS
 z9xHuLXKfngkA==
From: netdev-bot+sinfo@kernel.org
To: Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ice: Avoid tracing bridge ports after initialization
 failure
Date: Wed, 18 Nov 2026 07:48:31 +0000
Message-ID: <179498811103.3291.4517029211414094145@kernel.org>
In-Reply-To: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
References: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
