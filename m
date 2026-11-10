Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA72606C66D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mubS6owM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gc/VV8LB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 803D1810DC;
	Tue, 10 Nov 2026 09:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnkIDdNRP7e3; Tue, 10 Nov 2026 09:45:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5F5280DD7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794303933;
	b=lAV6G2BLK4YnxtdkWWdmruk08edpAqqrp7GoTcZmT6Aj6R83GKqvesAJVbEYwLE331Yg
	 D/iX90cdGygPzcr+ecybRvNttq7YgLNLQELUdZ4VWcSff4uLq0ZMWZPeRpoC0blb0P0mq
	 5kVeYl5ykzong3kCm+AEmetHM/iYFP6UzcXtsWdsbY8Bf2YIVEj2+fRDnY6yPq80/+L/5
	 JDDVVRwoncM94FSyZiexgKu8rXeH7pFEt1k5uib3Wkv05ARl27EnllaEOirkddX+sLtIr
	 JeuPq1rOV2IweNZVkX60NI+4PXnp63eMjF5VjuZEHcprp4uvfwLriNAb76BRs776OuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794303933;
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
	bh=Yt1RUkpWxEjGNFb0fWteE6fFY2lB9nSa+4LX3gy4fTM=;
	b=rIRlWWpBTPMXVCra8eP4b9IMTQmIRD/hozDktVxTfeLabrEt0MSI0hZBm8wO4X+gWY/z
	 YxqGnUbO44S322znzfFvAQe/tQstOQ3c2DWPwGFRthJUWyiiw7NN29LMimadMleQBgTp8
	 GIRduzVWSOfG/ufnOlOODj5NGv/pk+gke2c45Bh9bwlh/nf8Jkmcuui3qq15Ig2ONMepY
	 xeRV6KwwHMcRuVrj/+M3GmUQbD9AUjPXA5C97RAep0VlWNdCKvDYvVY5Bbu4XpbGRRjPk
	 qvgWMenL6fDiTVB4/eAmChxhiY7OOGYyI/2veLDvPeqRIXSJjYuRnrkfAjPo/9TQLtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Gc/VV8LB";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794303932;
	bh=Yt1RUkpWxEjGNFb0fWteE6fFY2lB9nSa+4LX3gy4fTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mubS6owMeqXKnJ/4JOLiCEo0sIcMMVuWO7aBQe9dIV5G3awgmIKTlqlr9m3Ad+DMG
	 tJCS+V/70LwwS8uUPe8g++/RRHhsJnYbzGyfqkm4yEG/S5uVYLvFx3UXb8CD7GlX1D
	 RuHAeiZuyHyTJgco9CEJs5POxmSng1M4nVqJeEtqvcq6aF+dN74Yr5brYUhkjd7M3y
	 tgUDJRsO7KSMjWhy04zHqQZXUbEmaKADLWhIrMzB4mdX+fiGswQAkOaqMiL1phJAsW
	 H9BOKsCHtXhF7quxD4yyL+9++zcEFja6c3tB4shy+NW/mPIOjhQVAofQ1TIa5dPQEU
	 gzsFXv//dh5Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5F5280DD7;
	Tue, 10 Nov 2026 09:45:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B20304B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A343480DD7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rvETsiEDsrf0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 09:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E790E80DCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gc/VV8LB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id E790E80DCE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt1RUkpWxEjGNFb0fWteE6fFY2lB9nSa+4LX3gy4fTM=;
 b=Gc/VV8LBozz9BwOghKMXXm4MrIvtutqSXQdP9KT9uAg4tkFBDgXgs+HCvsz5u1/+SsSdxS
 M0QdVAr4GvGgUytdTPrVpO7MVTF3yoSTczvgRDfiGl0dpQ2TIIsCDzdN3FvMvISC3rlws8
 //sP2VEzrZlH9tpx0/rDYFb3VkNMFwc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-8ytUxQaUOf-lyaIqo9r1PQ-1; Tue,
 10 Nov 2026 04:45:27 -0500
X-MC-Unique: 8ytUxQaUOf-lyaIqo9r1PQ-1
X-Mimecast-MFC-AGG-ID: 8ytUxQaUOf-lyaIqo9r1PQ_1794303926
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73CFA1800347; Tue, 10 Nov 2026 09:45:26 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7189E1956086; Tue, 10 Nov 2026 09:45:25 +0000 (UTC)
Message-ID: <da73c81a-7fd9-47c5-bd09-3652c83d44cf@redhat.com>
Date: Tue, 10 Nov 2026 10:45:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/10] dpll: add KUnit tests for core locking
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-7-ivecera@redhat.com>
 <sashiko-outbox-202878@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <sashiko-outbox-202878@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: fcedEvc0P-e3Pev84iKNtw2TOk9_twpZoBebAfQQDTU_1794303926
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 13:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] dpll: dt_fwnode_pin_add() duplicates
>    kunit_fwnode_create_software_node()
> --
> 
> commit cb6cfd6901bcce17d3e841bfa531bd7cce8efeac
> Author: Ivan Vecera <ivecera@redhat.com>
> 
> dpll: add KUnit tests for core locking
> 
> This commit adds KUnit tests using a mock driver to verify domain locking,
> callback serialization, cross-domain pin registrations, and notification
> ordering in the DPLL core.
> 
>> diff --git a/drivers/dpll/dpll_core_kunit.c b/drivers/dpll/dpll_core_kunit.c
>> new file mode 100644
>> index 0000000000000..a58800eda5ff5
>> --- /dev/null
>> +++ b/drivers/dpll/dpll_core_kunit.c
> [ ... ]
>> +static void dt_fwnode_release(void *data)
>> +{
>> +	fwnode_remove_software_node(data);
>> +}
>> +
>> +/* Creates a pin with a fwnode so that it can be registered with another dpll */
>> +static void dt_fwnode_pin_add(struct kunit *test, struct dt_pin *pin,
>> +			      u64 clock_id, u32 idx)
>> +{
>> +	struct fwnode_handle *fwnode;
>> +
>> +	fwnode = fwnode_create_software_node(NULL, NULL);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
>> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dt_fwnode_release,
>> +							fwnode), 0);
>> +	dt_pin_add(test, pin, clock_id, idx, &dt_prop);
>> +	dpll_pin_fwnode_set(pin->pin, fwnode);
>> +}
> 
> [Severity: Low]
> This isn't a bug, but could dt_fwnode_pin_add() use
> kunit_fwnode_create_software_node(test, NULL, NULL) from
> include/kunit/fwnode.h instead of open-coding fwnode_create_software_node()
> and the dt_fwnode_release() cleanup action?

Will use it in v2.

Thanks,
Ivan

