Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C34BF4BB68
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 17:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1639E60DC9;
	Tue, 24 Feb 2026 17:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEkMsHWnzVBC; Tue, 24 Feb 2026 17:43:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D5DD60AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771955019;
	bh=nBvRF3BmBejuGZVpPKazemSsUY6chbThwHxhuBC81AQ=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=9YL5f22odj28uGXH52VP7+9ToD9JxSQIw9pAI3NM/M2yZFnPy7yeler5WDYGxtMdU
	 ncvnABTZQAwlzVMtrCh36QZdiegYYZ5ZGdUYnvyQJfusdgcwoFYzEosXDZZjoHJ00W
	 +88gDHeKgxtufKXX8PbxIIiwvhCqUIa3eZk3QjweCzO+2V9XjcYclIXdeTpHCwGlRA
	 KWEvdLQaxeEvZ9yjYLabX5wu1IgXZ9J5ABcd3FRUCnmqCToRpx3VH/ltsoeaiBAjFw
	 +bkq7U5colj6sujoLAmvxiS+UHcpXRbBYL79wv1JcVZDmAVUEJwbEoGPxtIGIJ9b1M
	 BwlUEXySlyYEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D5DD60AB0;
	Tue, 24 Feb 2026 17:43:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F693249
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 17:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 510A540953
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 17:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVJV1v3EvfSu for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 17:43:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=199.89.1.16;
 helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5DC514091B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DC514091B
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DC514091B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 17:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4fL4p03WP9zlfgPZ;
 Tue, 24 Feb 2026 17:43:36 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G7lB1LngIYLA; Tue, 24 Feb 2026 17:43:33 +0000 (UTC)
Received: from [172.20.150.38] (unknown [4.28.11.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fL4nr1JmgzlfgRx;
 Tue, 24 Feb 2026 17:43:27 +0000 (UTC)
Message-ID: <cd678a22-79f1-4267-ac3a-f340d92e994c@acm.org>
Date: Tue, 24 Feb 2026 09:43:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Bart Van Assche <bart.vanassche@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, intel-wired-lan@lists.osuosl.org
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
 <20260223220102.2158611-20-bart.vanassche@linux.dev>
 <51a3c969-6fca-415f-a27c-d1ad8c9d3c71@intel.com>
Content-Language: en-US
In-Reply-To: <51a3c969-6fca-415f-a27c-d1ad8c9d3c71@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1771955013; x=1774547014; bh=nBvRF3BmBejuGZVpPKazemSs
 UY6chbThwHxhuBC81AQ=; b=0Y4zRIXXBVwSQ8SwE6np5M4d5j5fFr/49M0tZBnw
 U6114YH3R2bHsj/LomKcoys5Wp72UCzg8EZfP7/FzJAlncUpyrVltWyq6HhTXw0s
 slLZiObDT/zxdrfKMuUrFMAT3qn5WtScI/oyJWN0OC9v+mLcu8ULByrTjAERkmQ+
 RxoivxVrlyGHL/Cqwg2T57s+5/dGI9yL6LHRpaon3aQPqeXP/BRWy7f1rVdEBKxc
 tyZ6prbIuRMFszF6A8QvniwaPN621lY7Ob/Z5/EDzl5IxFYwICwUCjW7Exag3/SU
 Io4+4Q3dul45asOpPeKAf0ZJ/eLp7oU7cVfErmVghTE4vw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=acm.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256
 header.s=mr01 header.b=0Y4zRIXX
Subject: Re: [Intel-wired-lan] [PATCH 19/62] ice: Fix a locking bug in an
 error path
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
From: Bart Van Assche via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2/24/26 12:40 AM, Przemek Kitszel wrote:
> On 2/23/26 23:00, Bart Van Assche wrote:
>> From: Bart Van Assche <bvanassche@acm.org>
>>
>> Move the mutex_lock() call up to prevent that DCB settings change after
>> the ice_query_port_ets() call.
>>
>> This patch fixes a bug in an error path. Without this patch pf->tc_mutex
>> may be unlocked in an error path without having been locked. This bug has
>> been detected by the clang thread-safety analyzer.
> 
> Thank you. This is a good catch, and current error path is obviously
> wrong, in the way you have described.
> 
> From the commit msg alone, it is not clear why moving the lock up,
> instead moving the unlock to match the lock order, is right.

Please take a look at the prior discussion of this change, available 
here: 
https://lore.kernel.org/all/61e3cc7a-af79-48e4-acb6-8ac7c8d2552c@intel.com/

> But from the code, I see that you are right - we call
> ice_query_port_ets() again under the lock some 20 lines below (L566)
> 
> Let us know If you want to enhance your commit message (including the
> subject), as it looks like a big quasi-automated series.

I have been asked to split this patch series and to send it directly to
the maintainers of the modified subsystems. Suggestions for how to
improve the patch description are welcome.

Thanks,

Bart.

