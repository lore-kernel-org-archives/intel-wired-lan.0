Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B41D73E84
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 19:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D93C40CB3;
	Thu, 29 Jan 2026 19:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-igH527bHgp; Thu, 29 Jan 2026 19:03:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4491F40C92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769713418;
	bh=A6kTyM3GeRdLGQZI7pzMmWc5l+zbSMFzRj+5AluvRlk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Y/NRIZChYJFXkv0fYdXcF4Za5BysyUGU3nkABqX1ULVT5HdcDFwEwv+OEGVmZrUR3
	 bd6i7GgmfrWm6jZaMRLVHivSk5lP/260iO24vctN2vTU2jS/+pgTPI/Y0M4WlhebCO
	 jtFz6kpZyXG39dO8fhwQz/dmH5aIcD8ojlBVhg5qF/0rmx3akLBFcaeHScmxdgqGaM
	 YSRamQ6Nzzm62ymzT6CBS31+/lCZhM1MkdErC4/H3h/K/ryojqL93O4y2dflGCNhUq
	 IA0k0AaYM8qtt1MOInAuIxx1j3c39awAUg9aD4/qmDIqcN6TzGGVxBXlIEs196eI8s
	 wmzg80xxHwCog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4491F40C92;
	Thu, 29 Jan 2026 19:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AC611BD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 19:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 003B2606CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 19:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cj_6iwFmi2fK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 19:03:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.186;
 helo=out-186.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CEEF2606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEEF2606C2
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEEF2606C2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 19:03:35 +0000 (UTC)
Message-ID: <a2d4c3a6-9ea8-4d43-aacc-c27bab4eda95@linux.dev>
Date: Thu, 29 Jan 2026 19:03:23 +0000
MIME-Version: 1.0
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
References: <20260129095723.7269-1-poros@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260129095723.7269-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1769713409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6kTyM3GeRdLGQZI7pzMmWc5l+zbSMFzRj+5AluvRlk=;
 b=BH4gOlPeEIUSOMSfF0ZSaktXankCYoXjWR7kR3Gq6q9oZjue6jSZMrhFWclFii4eZOq3m0
 oi3CzQtLh8F/cyGX8WAYu0RQHwCvsQbjq+Hzg5+qu5JCtrWgv1DBe1qRWvE8AbFA/fTDaf
 0BnQjqlZbHiZoj6EFANNY2sJLEGWfUA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=BH4gOlPe
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix PTP use-after-free
 during reset
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
Cc: ivecera@redhat.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 29/01/2026 09:57, Petr Oros wrote:
> Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
> worker to cache PHC time, but failed to stop it during reset or disable.
> 
> This creates a race condition where `iavf_reset_task()` or
> `iavf_disable_vf()` free adapter resources (AQ) while the worker is still
> running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
> accesses freed memory/locks, leading to a crash.
> 
> Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
> This ensures `ptp_clock_unregister()` synchronously cancels the worker and
> cleans up the chardev before the backing resources are destroyed.
> 
> Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
