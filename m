Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA3606A33E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=tE9sno61;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFHF5jNd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D70F40A9F;
	Wed, 11 Nov 2026 10:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPLu089j1V2g; Wed, 11 Nov 2026 10:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F071B40A7F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394414;
	b=XYjN6wwko/YySBWtaptgPLJSzSsbdkecJL+efat5uH/I6/cNy/fD4mJgjoavIv4t3SyT
	 b1YL1q6Kk3IdH9ToDba08za+e+vSYGP6Ps61kvNXMtnlHtpG+EvTy9eJZdItyOA5wVfkH
	 q9mgJMv5jWR5iKUj3k5zJd+f5A3IAdR51WbYN8q0ogUNnKPN9Wbe5/Q3S9iB3Nc/ZicgA
	 PKRu6xrVLlWvkQeTjxHCAuLbO6sceevVl5SC0Xs5lGBAs9CLvDYY4/mnyfc7yfmomR0U3
	 TKcbPzfHMS6cR18i7aEmmx6+tDXlFZ4ybT+joOmmjXwYwvFDUYYmWidZwnfxh1+80zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8N7fypCJ/hoT+y3Nl5Cy8LcZBYe/io6SKN/QBhzDpOM=;
	b=LpruKDnnKHfhidKPd6inEYMQP1ZJZdty7s/Js3IrdZpL7SRrgHaHzVpmGFhozEmGg27a
	 okI0ObM/jnneLBVXDYC28n/9cAXztiSkaHWVvlTLKVYU3Xyunv6WX05Wr5LuqF3SJI7Hw
	 Hk1ogCtQJdFaXuq1w2LoptODkrNohtFusfSVo8mJkzXxkdfsn0Vf+Ell+afe0tlW9atro
	 6bDmxRuXBsqrE6EgF0OUxn9FkVNh4AGkvIi4u251YU49pVIahx1FRIu9p5BKS47yoczXn
	 ogkr3+laJjIZabuOVBj96RYo/6LQgpq/xqOEOe+zSCZYyg1RS5z7KeDnfXgelPWUdyg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFHF5jNd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794394414;
	bh=8N7fypCJ/hoT+y3Nl5Cy8LcZBYe/io6SKN/QBhzDpOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tE9sno61wQwDpZXKXxosnvnrO9nJSIBm+svKB9PVHMQoLmH3AUMXPdoqwsB6tCSgk
	 wmjIJBqDEPzcYnqysLqRnIpsJ4YuN6OXK3kEPT98fy1FMWQJmuofO+2kBbVZtqwqrh
	 Re+MyqTZsxaMb9oRmepFwhn21HpldfrZ5rmJjiopjrIidt1qKik9AHCQAd64auMFYm
	 w1rXYn5KjcV0odbNxW2KkDAyTlZGXN6pPNm6pXK2BfBhe1W+KYs5hyYtDjZm5clqbt
	 EWGl8jr5s3mVTdcFHOKDSlc/VUbX1rfyDk0WpLYGMpDgCcm0U4abk1h4D/ygrPuI9h
	 5vsYcxKKtZWiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F071B40A7F;
	Wed, 11 Nov 2026 10:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F201731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0A0C40A7F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObSQYk2zvgnF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 10:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E73240A6A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFHF5jNd
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E73240A6A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8N7fypCJ/hoT+y3Nl5Cy8LcZBYe/io6SKN/QBhzDpOM=;
 b=WFHF5jNd+2uzvLYtty812YMxMbGT6AeRw+fg+EqZ+XzZbOq+BFbq5qRUIab5mVlRRCkJyA
 gRB9FCiaBA5jHZOfcAyOtF8Q/uxUv3kWuRpsGFI7SfSxOIIuz/YXwAtqY26gJWMuN2y7b7
 o8y41ZxS7R3t8m7LFy7nqjui3OfOT3k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-DxKuXwMGPSCoAX2zKEuwcg-1; Wed,
 11 Nov 2026 05:53:25 -0500
X-MC-Unique: DxKuXwMGPSCoAX2zKEuwcg-1
X-Mimecast-MFC-AGG-ID: DxKuXwMGPSCoAX2zKEuwcg_1794394402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9591F1955F61; Wed, 11 Nov 2026 10:53:21 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45ED518004FC; Wed, 11 Nov 2026 10:53:14 +0000 (UTC)
Message-ID: <38365dce-f6a6-4fdb-8f76-8b697f64aeb3@redhat.com>
Date: Wed, 11 Nov 2026 11:53:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-7-ivecera@redhat.com>
 <179433320676.994134.7049432410059447687@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320676.994134.7049432410059447687@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ychpuwB_aKFclVPP1Tr_q5t2l_LsfUGS_wbZY_ohKmE_1794394402
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In drivers/dpll/dpll_core_kunit.c, some tests set a blocking
>    flag before dt_req_start() has registered dt_req_release().
> 
> --
> 
> dpll: add KUnit tests for core locking
> 
> This adds KUnit tests for DPLL core locking. They use a mock driver with
> several domains to check domain sharing, which locks callbacks hold,
> independence and serialization of domains, atomicity of multi-attribute
> pin sets, and notification ordering. The netlink pre/post doit and set
> handlers are exported for KUnit so the tests can call them directly.
> 
>> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
>> new file mode 100644
>> index 0000000000000..a58800eda5ff5
>> --- /dev/null
>> +++ b/drivers/dpll/dpll_core_kunit.c
>> @@ -0,0 +1,1471 @@
> 
> [ ... ]
> 
>> +static void dt_block(struct dt_dom *dom, bool *block)
>> +{
>> +	complete(&dom->entered);
>> +	wait_event(dom->ctx->wq, !READ_ONCE(*block));
>> +}
> 
> [ ... ]
> 
>> +static struct dt_req *dt_req_start(struct kunit *test, int (*fn)(void *arg),
>> +				   void *arg)
>> +{
>> +	struct task_struct *task;
>> +	struct dt_req *req;
>> +
>> +	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, req);
>> +
>> +	req->ctx = test->priv;
>> +	req->fn = fn;
>> +	req->arg = arg;
>> +	init_completion(&req->done);
>> +
>> +	task = kthread_run(dt_req_thread, req, "dpll-test");
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
>> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_req_release,
>> +							req), 0);
>> +
>> +	return req;
>> +}
> 
> [ ... ]
> 
>> +/* Blocks a request of @dom in a callback, which holds the domain lock */
>> +static struct dt_req *dt_block_in(struct kunit *test, struct dt_dom *dom,
>> +				  int (*fn)(void *arg), void *arg)
>> +{
>> +	struct dt_req *req;
>> +
>> +	WRITE_ONCE(dom->block, true);
>> +	req = dt_req_start(test, fn, arg);
> 
> [Severity: Medium]
> Can the teardown hang here if dt_req_start() fails one of its assertions?

Yes. It takes an allocation or kthread_run() failure in the test, but
then the cleanup blocks under dpll_lock for good.

[...]
> One option is to register a cleanup action that calls dt_unblock() from
> dt_init(), before any flag can be set. Another is to set the flags only
> after dt_req_release() has been registered. Would either of these work?

The objects of the foreign and on-pin tests are added by the tests after
dt_init(), and KUnit runs the actions in reverse order, so an action
registered in dt_init() would run after their release. v2 clears the
flags in an exit callback of the suite instead. KUnit runs it before any
cleanup action, so it also covers dt_test_stuck_foreign_device().

Thanks,
Ivan
---
pw-bot: cr

