Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0022606A33E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 15 Nov 2026 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AGTGut35;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=GiSawGQk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CFD240674;
	Sun, 15 Nov 2026 19:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iX0yj0QD9KNt; Sun, 15 Nov 2026 19:37:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DAAF40663
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794771474;
	b=Un/JkK9Y6LELjGNWuPAbyXn4umH8seqEaUerqgLqu8euYo2jTm1RW9aFKsXYAbfKQ9ND
	 UqNhepX4c8mPitv3Dhz2Y1g+l/vrjJX4xlnPfOz7qd6sO1s0xBcqdRx2mQ221vFmUXMad
	 lO2mnhtL5fgXaKcFQ+d8B/iFzYOOev0YzobMXhnezT7OTnYtnAiSGiKPSPN3yBlh+aFPg
	 qX+X/YlXc2Ch5oE6Qk7fWZ+2uPjUfQD8i35iPnjRTg8XG6KC1/y5awFJ55AgpwftWOJew
	 Fx8Im8E8vZDJKRKAC55HUahCiEDKFpF+YRcTXKYhdWUvAxrQO3PHLl9VopEoMYRv0WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794771474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=isEsQrrx0hL73b1p5Jr6MlaLz4dtBNblQFsunuEj6v8=;
	b=XChM4/aJ9pLjAMrKcR2k+nKGWcm4pz1wFdDWTI6oFa78L/oFLLAFQu4HQE0GXLQyMHbc
	 R5I+C9z7kbweGQODZOLPunEzsQO4wReJPVXm8elJWHpethiy8X4BV4P2btPcR9pW0BcZO
	 JRnflwBxzTie/BJC1dCbA6vLf0uV2fG9to0Nt0hP/vusTfliOg+PqinFw/1bRCbGtkZD8
	 WJPOGYj5+QYB4BcISK+WTk4zfQX2QcZY+4oNKEXU+N4EMd7OH0t1KF9uNgP7zM4bx8UVi
	 eH7i4m/C1vLVffISlFD8NSYdjkQjAt2vgpt7BwVGovo1rOk/aMid+DgXd1zbd4Wd9OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794771474;
	bh=isEsQrrx0hL73b1p5Jr6MlaLz4dtBNblQFsunuEj6v8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGTGut35HRl6tXyGXfG6GUdPUjCWwY4VYD9sPTe5A7SjeEOX4EuMYYKGcj42mVt8m
	 o900xEmRrqLo6gjuaaVtZ+XH8GFP9LYWF17AqGsWpaj3K2/5WbqyWG3PGswWxgI9XG
	 pdonnyF7hUND+e3zUsv8vs/a94Iuey3OGuQtkPkfc+MTjSIkEUUNxcjAWriKDhlEAa
	 kRO7ADptNyUG4UcmSjwKohRdZSEKOg8uwYLJcAj6q6BRgP7KBnooVlB5XW4iyWLMcD
	 6TCfZmdqAKdm2oCXpZ0i+i/+Ux0bF+ehxLepej5VC2fqV96edCCxTQ8GnJmEnfQCU3
	 nRe8CyAnNSz3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DAAF40663;
	Sun, 15 Nov 2026 19:37:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6405D7
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3D9B60672
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62HxoqiEwKaz for <intel-wired-lan@lists.osuosl.org>;
 Sun, 15 Nov 2026 19:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E17260650
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=195.10.208.46
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.10.208.46;
 helo=mout-b-106.mailbox.org; envelope-from=antonio@mandelbit.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=GiSawGQk
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E17260650
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 19:37:49 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jSLqt1NjvzNl6l;
 Sun, 15 Nov 2026 20:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794771466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isEsQrrx0hL73b1p5Jr6MlaLz4dtBNblQFsunuEj6v8=;
 b=GiSawGQkORQPgxry110kOJKRxqQGGrmkoV1eGmHSj+S+ZUPrbQ01sfFAi3I1PaaN4YZR5J
 8zPNOf5PL2cluuIlUggromDPjMExlNdbJBkoCGDOTwfkw3p3TGxW/PiB9viFuXHr1RLCs5
 XKjtSxPeaYty0wdrgcBOTUviEXOrvnwdtXeNikySC/WDs3uEbID83zskgVyeMCtx+R/nBB
 A/DHIgJ4DkI6nrU1RIDkBy1tPvIHFSJOtMG5d4whFjbfpYb0Yw5kYlwx7R76B6XUDSUXE4
 VBTJfmCbZjrnQ5n08kWKWZRA8Q2Q/DXd1OxHFTigp1mwI4qXJrwqw6ENG2j3jA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <fc4b8168-d8b9-426b-95c5-4a24e93f46b9@mandelbit.com>
Date: Sun, 15 Nov 2026 20:37:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113105835.3821433-1-antonio@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jSLqt1NjvzNl6l
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 11:58, Antonio Quartulli wrote:
> Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
> RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
> but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
> require it. An asynchronous runtime resume (e.g. after the link comes
> back) then triggers "RTNL: assertion failed".
> 
> The queue counts only change on paths that re-open the device under
> RTNL (ethtool -L, SR-IOV reconfiguration): set them in igb_open() only,
> as igc does since commit 6f31d6b643a3 ("igc: Refactor runtime power
> management flow").
> 
> Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Sashiko reported an interesting finding that is worth fixing.
Will spin v2.

pw-bot: cr

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

