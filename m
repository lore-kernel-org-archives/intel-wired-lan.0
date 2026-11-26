Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19323606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ewRwTsvq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GrEcHm5A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E864140816;
	Thu, 26 Nov 2026 12:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ea-Rf90CCCnz; Thu, 26 Nov 2026 12:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1BB4940897
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696278;
	b=Rm6TnEx2anpNG0EkLrnfWrf76b6n3O4VZB3ZBkAv2sFRIwb20YwmD5mZTRloPjeOtg8V
	 lS99JyP8vFTFYxtKROSPOrxBdO+TvCKRe7RewMdu8hQ8K/BK+FO7trZ2H0tX1PNepJj57
	 KoC22CjQsDp+qCs87MquS2wBf7doKfZV4f0+4RGAZnJbn4XXzLh1jqXLzMJi2IeK9si+g
	 5oElGQ+GB6KWms95D4rLwgkerBXfJIBVuxF1mpRqRwZu+FU4sVKL4znM2/1FKGbCTl/j3
	 nv2DPvjVWjlTLDJcrXWiH+Heu3VDAbMa53eg7dglTZGqvR3pNActaby7RtquEfbDMeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696278;
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
	bh=52jyvJaZ8hBgfbTK0xHbCFQ/dKRjm1IOosfZ4MG6L2g=;
	b=lNppwxa83jh/Ftl9RJ7DbFfYxAwCtE7Rj1yJYxYriy2j7CDOEEcrfvTKnzKxUVr6psys
	 fejf+/IPyW57V8xjyDcg6kS9lGWU8o3Z8eZntaxoDFD0foLYZ/UBfNTTeZr5MSRARkW4L
	 rJ+KZmUaOaEb90uMp0T9wZaLy07rT5RG0DO7u2HR1UTiRMxomKm/H9exaAbQ+IMwqij/h
	 3AHlcKpxw7DlHuz9f3jZugUTbmzdoXJozYdVmPtdOoCfqBJ1B1D3K1CwvJh7oMEl9syHv
	 ah6PKmIpOcnDwGZz2O+NPBsdNIk94bd8ptVoU528zqWvPs32K6x3d1YDl2LO+iDWIzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795696278;
	bh=52jyvJaZ8hBgfbTK0xHbCFQ/dKRjm1IOosfZ4MG6L2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewRwTsvqZ5U7fmRLhTPbP8ZqVkEjnHvmcsnX2GLSyCo/1mnRMtAqcSGc5dvwPNUiv
	 czZlP3ROtVL1X7hbclwbmS/SQg8OyRkptAWQ9o+36kqVAMkhWLmG+yQpUeQloph4RF
	 FIQ2yemttpS6VwIdYLdsMF+4/wHj0xov6zGCYWiI1WDsW8Tw1YBgb7LN59EDQTAR/g
	 sytiK555Lvbdz1MxtFAP6dapQqnjfdkSL1OxRpRdgEMQAZZwtkaA3BqvYU5dcUEleS
	 xtjMm8FCr+KzDLdBnGPPL73gJPiQliG/uKEbfSI/GaqeZWvN5Hb0Uf8GshWwIPu+cE
	 B2BwOuPj47zQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BB4940897;
	Thu, 26 Nov 2026 12:31:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D05AE2DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B69C0404DC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOvxejOXV5LA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 12:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C6856404C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GrEcHm5A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6856404C5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795696274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52jyvJaZ8hBgfbTK0xHbCFQ/dKRjm1IOosfZ4MG6L2g=;
 b=GrEcHm5AfaTg0+uHOwjL4dBwmFjOlqVrQODkxgdgTVr25H+cbLkrviibEAW8RR8g7q5ixl
 L8UOiCaAjPITV3QhdB72LIiAB6ZBSJgpVsVUmh3BT1t1lr7p7KUDRkc8zFGZy9kIw96nO0
 kkI+3lRB6CO0o8q1qc9UpwkLDvG+XDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-Fw_Z4OWMPFyLuRjexsHCGA-1; Thu,
 26 Nov 2026 12:31:09 +0000
X-MC-Unique: Fw_Z4OWMPFyLuRjexsHCGA-1
X-Mimecast-MFC-AGG-ID: Fw_Z4OWMPFyLuRjexsHCGA_1795696266
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D031800343; Thu, 26 Nov 2026 12:31:05 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 921EE195608C; Thu, 26 Nov 2026 12:30:58 +0000 (UTC)
Message-ID: <851d61dc-7416-4b3f-85e7-8a30bc19fab8@redhat.com>
Date: Thu, 26 Nov 2026 13:30:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261126091510.7ac67b35@pumpkin>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261126091510.7ac67b35@pumpkin>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: PPWqKcXR-wb8RbxdKcLa8pQTm4YMYz13-Yrmh2TAw5o_1795696266
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 10:15, David Laight wrote:
> On Wed, 11 Nov 2026 17:40:11 +0100
> Ivan Vecera <ivecera@redhat.com> wrote:
> 
>> dpll_lock protects topology and object lifetime, but it also serializes
>> all driver callbacks in the system, so one slow device stalls every other
>> DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
>> commands with a 60 s default timeout, and zl3073x callbacks can wait
>> seconds on a driver lock held across ToD writes and phase steps.
>>
>> Make dpll_lock an rwsem for topology and lifetime and add a mutex per
>> domain for callbacks. A domain is all objects created with one (module,
>> clock_id), in practice one chip or card, so channels of one chip stay
>> serialized as drivers expect, and they still block each other. Device
>> callbacks run under the domain of the device, pin callbacks under the
>> domain of the pin, whichever driver registered them. Only one domain lock
>> is ever held, so domains have no lock order. A lock per device would not
>> work, because pins are N:M with devices and callbacks notify sibling
>> channels.
>>
>> The driver API does not change, but a callback can now notify only
>> objects of its own domain. Patch 1 changes the one in-tree callback that
>> does not follow this.
>>
>> Registrations across domains exist in the tree only on E825, where ice
>> registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
>> These callbacks are no longer serialized with TXC and TSPLL, they rely on
>> pf->dplls.lock, and requests about these pins wait while the external
>> DPLL is busy. Intel folks, please check that this is fine.
> 
> Isn't the big problem with callbacks handling deregistration?
> With a global lock there isn't a problem.
> But as soon as you do anything else you have to have very explicit
> rules to safely deregister a callback without either a UAF or an ABBA
> locking issue.
> 
> I don't see this being mentioned.
> 
> David
The cover only says that dpll_lock keeps protecting the object
lifetime, the details are in patches 4 and 9.

All unregister functions take dpll_lock for write. Netlink requests,
dumps and notifications hold it for read for their whole duration,
including the callbacks. So dpll_device_unregister(),
dpll_pin_unregister() and dpll_pin_on_pin_unregister() wait until the
running callbacks finish, and no new one can start, because objects
are looked up under the read lock. Once they return, the ops and the
private data of that registration are not used anymore. This is the
same as posix_clock_unregister() taking the rwsem of the clock for
write. A KUnit test in patch 5 checks that a function taking dpll_lock
for write waits for a running callback.

For ABBA the rules are the same as with the mutex today: a driver must
not call a function that takes dpll_lock, including the unregister
functions, while holding a lock that its callbacks take, and a
callback must not call one at all. Patch 9 documents both, and lockdep
reports a violation.

Thanks,
Ivan

