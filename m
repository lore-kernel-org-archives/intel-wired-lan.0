Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B8C3DA59
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jul 2024 14:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A46A80B9C;
	Mon, 22 Jul 2024 14:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLJqHCtfqkJV; Mon, 22 Jul 2024 14:35:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D831C80BA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721658954;
	bh=MnlbR2GcelTrxC43wmubED5vaPUSEQY5/YCrk5DAbp8=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KfsMGqzkOpFsbO1B2QBIgEvtPt8StVuhV+TUougZztbSXp36BTiuXHZbeBkJmbssG
	 lwldzwxZSmnAyclLPg6AqEFYjkWij4ygVsZI9B2i5eq49aicDXspDP8pG9hkFpEqBF
	 Viwcx7IguUI9n3UMJQ6i28h4NPg12elZ9IodxOmjbKXQTv/SYsb9tQ/34PfHJtOyW/
	 VM4rw2xXSb8d4ujKRTrSNPoowVBeQNXN7+4HcBHkGdMj9hCGUVYzrNPpRTB3X8slhX
	 euWiHeQ/VRvjq3LbULIidbfRQguhFTc7qL6qgz3hD/0JLhm5Ivwhf9BMe4viVZJKIk
	 8TgDyTKX3t2XA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id D831C80BA4;
	Mon, 22 Jul 2024 14:35:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id E77841BF286
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3B9440156
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cf8eiCWK8rOf for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jul 2024 14:35:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 65D744011A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65D744011A
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65D744011A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 14:35:49 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5CAD961E5FE05;
 Mon, 22 Jul 2024 16:35:16 +0200 (CEST)
Message-ID: <232df828-baa3-4c87-b5f3-c0dae9d98356@molgen.mpg.de>
Date: Mon, 22 Jul 2024 16:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
 <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Dawid,


Thank you for your quick reply.


Am 22.07.24 um 14:55 schrieb Dawid Osuchowski:
> On 22.07.2024 14:37, Paul Menzel wrote:

>> Introduce … into
>>
>> sounds a little strange to me. Maybe:
>>
>>  > Attach to device in reset flow
>>
>> or just
>>
>>  > Add netif_device_attach/detach
>>
>>  > Serialize …
> 
> Maybe "Add netif_device_attach/detach" would be the best for this, as 
> the attaching and detaching doesn't happen only during reset.

I’d consider it too generic and would mention the place. But if it’s not 
possible, then it’s not. Maybe:

> Attach/detach device before starting/stopping queues

>> Am 22.07.24 um 14:28 schrieb Dawid Osuchowski:
>>> Ethtool callbacks can be executed while reset is in progress and try to
>>> access deleted resources, e.g. getting coalesce settings can result in a
>>> NULL pointer dereference seen below.
>>
>> What command did you execute?
> 
> Once the driver is fully initialized:
> # echo 1 > /sys/class/net/ens1f0np0/device/reset
> and then once that is in progress, from another terminal:
> # ethtool -c ens1f0np0
> 
> Would you like me to include those in the commit message as well?

I’d find it helpful, but I am no maintainer.


Kind regards,

Paul
