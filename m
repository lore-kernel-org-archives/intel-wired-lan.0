Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8E606A325
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=38njm6+j;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f3bSls9+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C16FE607B9;
	Mon,  9 Nov 2026 14:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWNwXfEtF4r9; Mon,  9 Nov 2026 14:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11061607B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794234440;
	b=IDjNdhXkpBIc3NK/SkhL0y+R+YrhFvo9ptkx1dL751p6pVPTSBNuqD8R6F9aQbYMeSjh
	 D0Z0nRXbCsuNohSl1hsTnvKjA/PXy4xa5xJ78Qwev7tWoPV7P6vsL0UoDqDMNtFJ5aaVO
	 yCfy2cyX5sQe1fFvQRdbh6NhSqkvaVhIs74TlUHoK9MroLIdNeiigIMGlKfZpnc8wCcLC
	 +9emxTco8iIIhWoedUcauscfVoeMP3TrZstHwn57shh1Y4e82n3JxFjd+IKS7oK2YYvM3
	 IEbgMaPo+OEBrwkZNtVBo90Sb9pdkeAaDq9Y/Ve9XUehNn9UWjojsE5ebxMtsgnz+mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794234440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2a9O4U63fsuMYqHsEdZ9Qq4gLKRczWAJUt2zqX6vIfI=;
	b=R2rpAvXMEOpjjwpYfroaSmlVIWm89y2X+cV8pQygnwypz7BciQvZEzKbh2HFiiPqYNfm
	 vkyBfoekm91wHqvAZpALaeGdOvtDEfPQ7x7xUHpAv5aSOxlteMmL+zGdoFFNYc+kqTwVw
	 oYnndjfxGneZbX9IbSUnulK/e5CQEJJAIeGhqxGb3CNJSRakDRAt8Ri0uLpEjep6M1OQG
	 XtSr8AGCM0Jwfwpepois+ljsFjjfeaZ9mxm53Fx0idTFKmz0abVFdzo/DlOVRrebQGP1E
	 yjl7OBMK8+t5nQtut+f0zz2IUl6I2yhnsDXjUsIGTyTI5gCGVwLCnKNsu7sB4UGjosg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794234440;
	bh=2a9O4U63fsuMYqHsEdZ9Qq4gLKRczWAJUt2zqX6vIfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=38njm6+jqU7KfjYTyskqMIx0cLpl6A8yJEEup7IzlBQY9SIKJUXc8lOEWXh0+y39J
	 wd1LNvWhI2gx0OQd6qOMwmphSy9+EVIhEBOnp4HIuu6j2ABG9q0s4PPaoT3OtlKexf
	 ngikkr+3gVfCDPNBbjaydMssPAmnPAnzvDxitVQu23kj/Ibu5nErrJNduS2hdkF0Ly
	 dsUaNMFfdIX5hyKN8AVaeQ59J6pnvtBPxDfzMhVZx846qnu8LU7IAVZ+Z6u3fr2III
	 mmtfWYaTI4vg14wJPaeugLeim+1Lmg/njlPBE+X09crlqQKCzrmyTrMRTHOrPSlPgG
	 g6s+nq7KDCmow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11061607B1;
	Mon,  9 Nov 2026 14:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E087D932
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5B6340769
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:27:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PycFy57HfX4p for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 14:27:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A18940775
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=f3bSls9+
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A18940775
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794234434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2a9O4U63fsuMYqHsEdZ9Qq4gLKRczWAJUt2zqX6vIfI=;
 b=f3bSls9+lz4/ADViaEuEwU56c2jprevmJ0KsAKHTk5SyF5i4xxxeF2MwN//tVO2Jve8bRy
 5aZFR5eLsta10VzGrbsv9jvjRQbYVQ8HvOdgtQm2l+gdgRsOGBUaBvzi6KGdqBBxiwAOlo
 CIEl5q2NOCZ+LkmAizmGjxT3hOHtMy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-aK-KvS8IO9uiaEIZ0pV--g-1; Mon,
 09 Nov 2026 09:27:10 -0500
X-MC-Unique: aK-KvS8IO9uiaEIZ0pV--g-1
X-Mimecast-MFC-AGG-ID: aK-KvS8IO9uiaEIZ0pV--g_1794234430
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0C53195609D; Mon,  9 Nov 2026 14:27:09 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C58F26C; Mon,  9 Nov 2026 14:27:08 +0000 (UTC)
Message-ID: <48237720-6de1-4927-89ce-6d7dcac99abf@redhat.com>
Date: Mon, 9 Nov 2026 15:27:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] dpll: take domain locks around driver
 callbacks
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-5-ivecera@redhat.com>
 <sashiko-outbox-202876@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <sashiko-outbox-202876@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZaFvLFdeq698oqSSj267equx1bGVufrYuzSMLIVxuqY_1794234430
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/7/26 13:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] dpll: broken NLM_F_ECHO in dpll_pin_event_send() [1]
> --
> 
> commit 1d6bef1472d6edb1fb63ca2b725c77cbbc70a8da
> Author: Ivan Vecera <ivecera@redhat.com>
> 
> dpll: take domain locks around driver callbacks
> 
> This commit acquires the object's domain lock around driver callbacks in
> netlink requests, dumps, and notifications.
> 
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index e5380d95f238b..1b4e3a0166a74 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
> 
> [ ... ]
> 
>> @@ -941,27 +955,39 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
>>   
>>   int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
>>   {
>> +	int ret;
>> +
>> +	mutex_lock(&pin->domain->lock);
>>   	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
>> -	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
>> +	ret = dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
>> +	mutex_unlock(&pin->domain->lock);
>> +
>> +	return ret;
>>   }
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but does dpll_pin_event_send()
> break NLM_F_ECHO on pin SET requests [1]?
> 
> drivers/dpll/dpll_netlink.c:dpll_pin_event_send() {
> 	...
> 	hdr = genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
> 	...
> 	genlmsg_end(msg, hdr);
> 	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
> 	...
> }
> 
> When a user-space SET request triggers a pin change notification,
> dpll_pin_event_send() is called without the request's genl_info context.
> Passing a portid of 0 to genlmsg_put() and calling genlmsg_multicast()
> instead of genl_notify() drops the originating socket information, so user
> space never receives the requested NLM_F_ECHO notification.
> 
> [1] https://sashiko.dev/#/bug/linux-14884b2c-eeea-47fd-87fe-40bc535d32cc

No. The DPLL family has never supported NLM_F_ECHO, so nothing is
broken here. Echo is an optional per-family feature:
Documentation/userspace-api/netlink/intro.rst says "this feature is not
universally implemented". Most genetlink families (devlink, ethtool,
netdev, nl80211) also send their notifications with genlmsg_multicast()
and no echo. A SET request with NLM_F_ECHO is still ACKed normally.

Adding echo support would be a new feature for net-next, not a fix, and
it is unrelated to this series.

Thanks,
Ivan

