Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FA1C79FAA
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 18:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35617605D8;
	Mon,  7 Sep 2026 18:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smUivAfAWpbx; Mon,  7 Sep 2026 18:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 65B4A60662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804742;
	b=O1VHJH8zfkwIH+ORo7j+zYE9gMMEin6fffFUyYjzSBmShXTxbaClI4Xnh2BsrYnDAM2C
	 Ndgs3IiuPSu4dYVT6+MpHflCtTvNLHvqyTEKDFpXHe/xZbEoX32c/dgmnABZEvbF7xhYP
	 PQrosg/n8G4+jcWHwXXYcbeKhkGkAdDx24RzRTXo7plzgiMdXARNzzfNVC0HEjj7DLD2y
	 KQebFoesfKY4OQsk8ZiwF5f0HmqFFJsbTeLB4UdGq9a0F7U6h2GmOh27yKn709yJeQVaN
	 7FFXwKJJtrKSn83YJx4/urGFmsp8FNwWAqm/y8Y/QBp3bBKRc7S+KH8h61mUu89m01Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tUA4k8R2t1QpHAGgeyT0ZKIm7T5VVZVvcJldkkde15c=;
	b=bH/MeOYSqpt9n+43502ECL0vOShvba+U7jz5tpmbuBB6PQO6EUZ9fEbsjWGx1Dc78XzH
	 8o+mbd+AZJidr81gt+rC2BDeFl3o6zuTDJZ3q+vUFJjSbx+6PZymMXhzKg7djnLKzbIi8
	 BYwoXnc7TTAM8cCM9DEOCkXrttWdNCjRC0zs1ErEKig/JWnmBwlWBPEiqjwDy8RahkE/+
	 OFsKsQzHMQoxBCWOLooIQk2HiHWGhPdR/u8btRQm/a/ncq6UQwH2RMBdg5CqA4KpDukD+
	 BLr28O60XRiYSS94k2NLy42lzAZtRwvoBA/ooh+CjgtT+wF0H2TN4keJb6Ud59XNgIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788804742;
	bh=tUA4k8R2t1QpHAGgeyT0ZKIm7T5VVZVvcJldkkde15c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODwaEN4Jxv2bdFra8U+eIx0TAjW2euH7kEhQ3xXYKUNm6fIB0VQhjA6B/apgLFLPi
	 yMeygzhWmz8eDwmZrfLd+6tFCXWlj2pdZCSS3iWD7DC0seSlNY7925T0OAbSZqIYQZ
	 Jijdlj00PFO+2Y8ODntaywteu8Mc+SLKcNWK55FXMD/WhpnduGcpKUM80OhU2jrrNu
	 R5XQiXICrV6sCd5tsyODvOK1rh+mKDe87LnM3B82hQ6C5aGXrp94j2zHLkxjYELqRG
	 9o8nGysvOOhIr1NnZguB+wf6u4Z5K+HwTLOnJUBN4sACZsHzx4+h8a7xl12bY3Vv7N
	 TEcuABU3rGg5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65B4A60662;
	Mon,  7 Sep 2026 18:12:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2FEEAEB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 18:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D966E40070
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 18:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNHyHlEU6mgh for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 18:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3A9614005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788804739;
 b=K7ZzFuVWRmJE341NBtRfWZ1Z+bsbFwRs3IKG9R7hbRRkvC38bryFpa66Ob9wO8jjItLy
 RxAoLJXHETZ3xGmPIIOUKkaTcbQ6IHBIoCH4jFSKgTKfnKKYW6fpMGDxd6MKjH/bPoQOK
 FStV9H3Ta+48w8emob2OUudMHWtLgVY2Ar2f0Mg3AJ7HfHq2/KYE/EZpGxsET3+/KV0fg
 PODt68EBx6XtLlCRDeO8xMtVm53Ilog9AUeGGcEgk09uBoxebEnLfcUw0wfdygY1Q/+bc
 ktZ7Rztfr/r0J2ZD8yVy1FrJJrIRX9iKaXfKGAHndjnZ4HF/id9Ywvi6yxWCNFXH8zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804739;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=tUA4k8R2t1QpHAGgeyT0ZKIm7T5VVZVvcJldkkde15c=;
 b=PUxV0wsQGinlz7cCN2RKvbprBaI+yIvCNUlxY4nwWcG7c68GGxqlNW5i7NCa5VEy3P1+
 Atuzqj51Z/G0nuCZTFcteuaZvtW3hWqKj//Z2bMY/UkaEDKCPBls5wzUl9CnSOggrkkaw
 4ENI5lwp5A9mytbqYM/Q+doAxZ8VzZGBqcsdfHUctWwwOWpO592iEgz/217eE0tuWMYav
 AGpkVXHFEan1UEZn7vTmxx2wRJtkK0RCRlLYYKq84kFttFjHjTFkQP0btytygApSyKw6x
 VdTG0a15Sm8Q8jPlXiwjiRIj00Lt4JZFVz7090wWYOYnNPdyVbYVQOmq82l5xwpOk/A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=WTzWqTdy; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WTzWqTdy
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A9614005A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=tUA4k8R2t1QpHAGgeyT0ZKIm7T5VVZVvcJldkkde15c=; b=WTzWqTdywnsEwqjXCxEQTDsw2S
 S0GF02yWDOz/17M8o03Ohp0ZWpez/vaC4WRDHIdPsxPCPdCQt9y9sgjFNgtTaPektuda40Bf5/FfF
 6sdeMfTnS2nI6S1Nxp9uVKKD1PZgbhUkOKYqN3glIn/acrrSjFRXe8982InOs9xpKId6JlAOt7Sfs
 dpzwPxjregJkSAwu5TP3UbfgCzvkL/rBvbv7NSS13WwGu8L0PSGw+Y9qkLc2dA0vfKcN0GU0ryFSj
 pkAKlDUUxC+Z5nV5MoCF6w3E4iUf32YHRZOyWT0VEhvjaQdZjfuVCMt5hL7B7O3dL3sYmuh/+MX6k
 mj/33REA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x3cp0-00000007RIP-364Z; Mon, 07 Sep 2026 17:07:54 +0000
Message-ID: <c2f439ac-ca0e-4532-b649-c32c4e474436@infradead.org>
Date: Mon, 7 Sep 2026 10:07:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation/networking: fix repeated words in
 comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
 <20260907064528.6602-3-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064528.6602-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 9/6/26 11:45 PM, Hemanth Selam wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>  Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> index 53d9d5829d69..e01f0adda3f6 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> @@ -692,7 +692,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
>  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
>  number of queues for all tcs is 64 or number of cores, whichever is lower.)
>  
> -hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
> +hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
>  offload mode in mqprio that makes full use of the mqprio options, the
>  TCs, the queue configurations, and the QoS parameters.
>  
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> index eb926c3bd4cd..5840569917f5 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> @@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
>  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
>  number of queues for all tcs is 64 or number of cores, whichever is lower.)
>  
> -hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
> +hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
>  offload mode in mqprio that makes full use of the mqprio options, the
>  TCs, the queue configurations, and the QoS parameters.
>  

-- 
~Randy
