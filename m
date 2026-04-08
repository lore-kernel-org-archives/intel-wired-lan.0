Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712561073CA1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 11:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2914F822FE;
	Wed,  8 Apr 2026 11:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eE6SbBn82wrS; Wed,  8 Apr 2026 11:51:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11C9D821D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775649092;
	bh=w1J1z6UfUIsOB2RYoy8vtMchlZQFMSLN8GWX4rfSeVc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4CYWIW/neb2DWZMTUvmqv2MvINkMKee0kpe5c9sLj/BBvGgeCcRKE87spTkeQgbq3
	 Z29kTqe18l5Q3piABVE7M4N/0Dcn10N/hERxu7Awn7BWsnwYrOF3/45rHI4EGfz4uC
	 xXrrvbwwuold8vkHYaUOuQ/s7+bUQ4SmUFCP9PsIXfap58owGe25m2ZjP2qK2taf3O
	 3Tj+kFjIF3D2iveyyHVazKeqf5I1y2zCYOhWA7Zpx/otfnn/1mpEDTUvulCzrk3Nty
	 1AR3JSm93d05NuDLxroV/yZpuD8FhJQqpfzKLNCMYjggwSDvBWNcj4nOWDPNKjYTek
	 LFEzGY1f47YHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C9D821D1;
	Wed,  8 Apr 2026 11:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D9FA237
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F4224069F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0E4Sfcp0HEsu for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 11:51:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8E2DD4069C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E2DD4069C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E2DD4069C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 11:51:27 +0000 (UTC)
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95BCA4C2C37D4D;
 Wed, 08 Apr 2026 13:50:38 +0200 (CEST)
Message-ID: <3c7e8261-7528-431c-adb9-3b90124cef99@molgen.mpg.de>
Date: Wed, 8 Apr 2026 13:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
References: <cover.1775648513.git.pabeni@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <cover.1775648513.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/2] i40e: implement
 per-queue stats
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

Dear Paolo,


Thank you for your patches.

Am 08.04.26 um 13:43 schrieb Paolo Abeni:
> The i40e driver already collects some per queue statistics, but does
> not expose them to the user-space using the standard interface.
> 
> Implement the stat_ops callbacks and extends the already collected info

s/extends/extend/

> with basic GSO counters. Overall this allows passing the kernel NIC
> drivers TSO test cases.

It’d be great, if you added the commands to show the stats, and to run 
the test cases.

> Paolo Abeni (2):
>    i40e: implement basic per-queue stats
>    i40e: keep track of per queue gso counters.

No period needed at the end of the summary/title.

> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |   9 ++
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 144 ++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |   6 +-
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
>   6 files changed, 168 insertions(+), 3 deletions(-)


Kind regards,

Paul
