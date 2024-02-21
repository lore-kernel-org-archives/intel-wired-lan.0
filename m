Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9839FC48BC3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Feb 2024 11:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E9B382096;
	Wed, 21 Feb 2024 11:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VT2Wtfxgza4L; Wed, 21 Feb 2024 11:02:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8751181E4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708513373;
	bh=/8O0UDZsvhcfkLbQuRrwF2h1J0JHzbE0k776/OlRuHg=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1l8Dhuaw7xs1cJmnjy6/x9PObuZv6+bUfueMTZVzctvX0SkzxwaINqnkRvf2an6QS
	 rLi+ogkQ6ZVglt4wkTjAHcTMKsD/W11tULjRrJ8PZ/FlNI+BykfyuqVEuEOyuRf64A
	 tj96A1hope58Vicx2bN3cMzM8wXpd+0FyXwPGLZr8rlCYvSigTrc1XV6mfFODHhtYb
	 +VR/EI7uKeKQ1bloXJnFqOQGmzLu7ifECXgmhHXG6Sd2eB3DCbflBDtOWg2tIqI61M
	 ViR33DBTMoOHMLxOriZPRQ98JzCiZC1279SavnDusbEkCNQA+5yQdefNWVi44gMopg
	 ppq+cKUk1CDAg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8751181E4B;
	Wed, 21 Feb 2024 11:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3DF081BF82F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Feb 2024 11:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28EB041620
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Feb 2024 11:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbfpWQxWsvcO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Feb 2024 11:02:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E22A541609
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E22A541609
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E22A541609
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Feb 2024 11:02:49 +0000 (UTC)
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5CC8D61E5FE01;
 Wed, 21 Feb 2024 12:02:08 +0100 (CET)
Message-ID: <ed0d4411-e120-4366-8640-145e6f66684d@molgen.mpg.de>
Date: Wed, 21 Feb 2024 12:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
 <20240210220109.3179408-2-jesse.brandeburg@intel.com>
 <20240219091542.GS40273@kernel.org>
 <823fdfe2-7c8c-4440-bc6a-3896c542f0e4@intel.com>
 <20240221103525.GC352018@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240221103525.GC352018@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: simplify pci ops
 declaration
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
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Alan Brady <alan.brady@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Jesse, dear Simon,


Am 21.02.24 um 11:35 schrieb Simon Horman:
> On Tue, Feb 20, 2024 at 08:48:28AM -0800, Jesse Brandeburg wrote:
>> On 2/19/2024 1:15 AM, Simon Horman wrote:
>>> On Sat, Feb 10, 2024 at 02:01:08PM -0800, Jesse Brandeburg wrote:
>>>> The igb driver was pre-declaring tons of functions just so that it could
>>>> have an early declaration of the pci_driver struct.
>>>>
>>>> Delete a bunch of the declarations and move the struct to the bottom of the
>>>> file, after all the functions are declared.
>>>>
>>>> Reviewed-by: Alan Brady <alan.brady@intel.com>
>>>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>>>> -	.probe    = igb_probe,
>>>> -	.remove   = igb_remove,
>>>> -#ifdef CONFIG_PM
>>>> -	.driver.pm = &igb_pm_ops,
>>>> -#endif
>>>> -	.shutdown = igb_shutdown,
>>
>>
>>>> +	.probe    = igb_probe,
>>>> +	.remove   = igb_remove,
>>>> +	.driver.pm = &igb_pm_ops,

>>> the line above causes a build failure if CONFIG_PM is not set.

>> Yeah I missed that, but do we care since patch 2/2 then fixes it?
> 
> Right. TBH I wrote the above before noticing 2/2.
> And I guess it is not a big deal either way.

In my opinion, to ease bisecting, each commit should build, so if a 
build failure can be avoided, it’d be great if you could fix this before 
committing.


Kind regards,

Paul
