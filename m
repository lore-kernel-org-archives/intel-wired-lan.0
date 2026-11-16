Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=k106pvjs;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGX07yL1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0703380DC1;
	Mon, 16 Nov 2026 08:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8UfnYVc848p; Mon, 16 Nov 2026 08:23:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A0BA80DF3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794817431;
	b=qKunLEMm3Go1rfzShOq+T2kXrlS+4Vr54CopaI4fGuPpTdOCuU8FGebzu1kEk46GKuLn
	 rJDvCvwgIHrdCRI9hR21JEUqUPViiYO/8JJ2lgI09+8vNz9/6Djld+XV3H9/hrZ86izD5
	 pEYZ/frj9h36w3Z1FCY54RWZvR7/0PxO/xgvCf07qmfbwDhuZU/8U94flcgUIylAJt2H4
	 w0/YJvyfa/0foUvRbSG0XhGp+Uuwd0v8l9ZLiGmPgvfGA30ipBidXROoINWQAgq4qxirz
	 h67vw3r0iVVu7qOsF4X/AAQL2Th+PKxxXJg6YukDwNlo0aQ5rDC99FrmrEyDkqqI5WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794817431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zk7qMeGwsrGuf2gsO4HA2YvZx++EbTxoa+GvBuzPEW8=;
	b=mWP5/FGxD5r/PjuuRbeQpjo9FWe5fGAMKnVx1V2cWQXjz+gkhY8H2Og4WEUFBtXUnFol
	 GfNEEMa8WGliPQpSrRsu/+heAmsGdB8P3EIFDtitasmVva48dCrvi+9MYz6WCy9DvUVIg
	 cGlnKPlhRMh5xhFFmg9CIzVvTEANHzJdqhIm/tJrkfu56kvpmHTQqRJztBTgh7KwuOaAK
	 5guCJqHCBURq7/EsIsN3aTzhZq26h3V4degCMEkzebjSBapO86vnzHslosl9tA8A+pCnS
	 Zqbbw4RRgysKVAKbv8RsCz9wvI5qzY6V4HpJXUZ5+FakaFvOA36+D13C3zRWItMBZUg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGX07yL1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794817431;
	bh=zk7qMeGwsrGuf2gsO4HA2YvZx++EbTxoa+GvBuzPEW8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k106pvjsWmf4k4FAiSz+4asKGjACyJmuMmNOip2ye7wS+SRWwcUdRiyYNB/mHgbCZ
	 S7AObYd2W/MbWiwmpQAkaWBhZyZTBSgw7zXBSfCKOrWm1cPDI37rZuVs7cOZiLRfm4
	 yOSTndIIrrDOnVMWzGf7xbntv8ZrnM7spcRgDUAHCDQohJzXqlad14/0sipVmfOV8e
	 0T7nHbs5fUkMCIoZH4d3L2TwPhxWLgVX/BvfJHRXf4+QlFtihgWyd/K41qYUb+xak9
	 CSaqJnGWUSk6AYlcr47ZG8Rnd1BGFPtgKsuiz/W76saQmt25Zoh6mGnodPZpti1HYc
	 r1f+TuommuZBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A0BA80DF3;
	Mon, 16 Nov 2026 08:23:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6263F1A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5366B80DF3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSizbQl9D1_S for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 08:23:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4CE9880DC1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGX07yL1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CE9880DC1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794817427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk7qMeGwsrGuf2gsO4HA2YvZx++EbTxoa+GvBuzPEW8=;
 b=iGX07yL1YHbl3ugZZAy6x3Jxic5+b+IUjCe9BDmwu0+542fzj20m7UDEIAOXJ7s8V57BVV
 N+4i1w7JMeVMBvkcH2buceBfaxFM4+N6X1lxlSEknj5YEGhR3Tv1Q6vYID/h3EesGlwosL
 fgveHaaFJ0hkN8DYqVHImfSuMOUjqd8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-KBcw-E4wPoCsNlIGF5y5VQ-1; Mon,
 16 Nov 2026 03:23:32 -0500
X-MC-Unique: KBcw-E4wPoCsNlIGF5y5VQ-1
X-Mimecast-MFC-AGG-ID: KBcw-E4wPoCsNlIGF5y5VQ_1794817409
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 433F619560AD; Mon, 16 Nov 2026 08:23:29 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E718218004FC; Mon, 16 Nov 2026 08:23:22 +0000 (UTC)
Message-ID: <b6e9a07d-ed95-49c3-a797-0dc23dcedd43@redhat.com>
Date: Mon, 16 Nov 2026 09:23:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] dpll: document locking rules
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
 <20261111164021.273409-10-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-10-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: DHJ19WigY17BHrDhWT0ayoRgAXsHljV759j12IzqsIc_1794817409
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sashiko reviewed v2 only on its dashboard [1], with low severity
findings, so I am answering them here.

[1] 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111164021.273409-1-ivecera%40redhat.com

 > Is this rule broad enough? Several other exported functions in
 > drivers/dpll/dpll_core.c also take dpll_lock for write, and most of them
 > do not change the topology:
[...]
 > Would it make sense to say that these contexts must not call any exported
 > dpll function that takes dpll_lock (everything except the __ prefixed
 > notifiers), or to list these functions?

Yes. Every exported dpll function except the __ prefixed notifiers and
the netdev pin helpers takes dpll_lock, and rules 1 and 3 should cover
all of them. This is not new: on main, a callback calling
fwnode_dpll_pin_find() deadlocks on the dpll_lock mutex the same way. I
will widen both rules in a follow-up, or in v3 if one is needed.

 > Should this section also describe the context of in-kernel notifier
 > callbacks registered with register_dpll_notifier()? The rules only cover
 > ops callbacks and driver code.
[...]
 > Today ice_dpll_pin_notify() handles this correctly. It only allocates the
 > work and queues it:
[...]
 > The dpll calls are then made from ice_dpll_pin_notify_work(). Could this
 > requirement be stated in the new rules as well?

Yes. Notifier callbacks run under dpll_lock, and with this series also
under the domain lock of the notified object, which can belong to
another driver. They have to follow the rules of a callback, and a
driver must not hold a lock they take while calling a function that
takes dpll_lock. I will add both to the same follow-up.

Thanks,
Ivan

