Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE9606A323
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MwrenWo5;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LCEbYt/z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42FBA4083B;
	Wed, 25 Nov 2026 16:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nw3uugB69Thc; Wed, 25 Nov 2026 16:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74E894080A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795624083;
	b=M6Rlq2DlBDngUmzYTr2bBTWDN/MJi404rFTnhwRZEok4sj6H3WZ1BfaS+I4IFY4+e5gV
	 saaZbpY7ajY9LrOKMAN6Q8jCOWq6xbieR/YfyBdAUHhvIrHIQkXtzaEqQsBmPE+gXVbb/
	 y0xIZdu/r3O+E+9ehEGIWL7aXf7tFBVbQ0TiZLPP4r/LrZSEZUojqyqovt/+YBFmUDMT2
	 FKTHvzQy1W9tnsd06ziIRZoNC6IWb2BhjhHsgSxTbDS5lyjjjg+66QNd+AKrBb5BJ6nhe
	 7uYs5JtM5F5RXJgwgJsxRJ3G3Hmc+FsFVu5/GOzbsOaT8RWzMwo5mM8uJ80L3Eu5ovw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795624083;
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
	bh=0ccuMba5+2cV+cajIEgRXiyY/D31cnRahwOAYJCpOuM=;
	b=SlJOnVKYVhhTPI1Do3plBdF/GBLL1v8XygCjYsCCxoYzszRrz37MIGLbzqQL7bddnNPg
	 vrceRNFQxZshn5NeMttXTdRNASmPiisWR43NqQyf6raIG3zS0IEZU+Qc3lCkiIWafmEMu
	 L/yxfj2UzTXyavG2AT8v2K3KLJj+dN5vNKMDpdQ3Aab3rzr75f9u2Lca0ByvRknl7Oe+N
	 ywLRS3CNrC8KWSlVjT1Gpg3Gm7HGGrab5ChNchDe5yzy8vWL7b5pW8IfqfRJA9ewK5WCs
	 sKAc/VglAARXqZkh2Tl+XpHyTRIQw79AK93bKDdBMVHpb9geQDjVb97tcEXePOPyGaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795624083;
	bh=0ccuMba5+2cV+cajIEgRXiyY/D31cnRahwOAYJCpOuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwrenWo5XY2IK/y2YIs3FcXbQOz3xg0Z9zAzSiwAiOkFzaLcHAbrY+K1IqFhIghN4
	 FRs801ZLvTAYBv5143JErbYvZwZYxWLaYXqJkA9b48OvaGy762QviuRoyZnuwbq+k8
	 xzdUAG8J1IJJilnTp4qbUkzily+rWeM9zE05zgsv4+DYRdT4fc+jXc6mWnIJ1/0acK
	 CtpdxccXD5WzDNfmscAYRQZhQZyx7ZcBOTDg3XwI7f2Xj4rGySREcWGxgG2TcpVO0r
	 5ds9EXk9dOW95h1JgNHqJbNU+eNkw21Nt8Y4DXyMwfinVrNZ+FS7jM3NHgKqJ19eVb
	 rf31Wrug0jJPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74E894080A;
	Wed, 25 Nov 2026 16:28:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A227E32D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87D6760891
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvQdL7G0D1Pw for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 16:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEFBF60755
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LCEbYt/z
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEFBF60755
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795624077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ccuMba5+2cV+cajIEgRXiyY/D31cnRahwOAYJCpOuM=;
 b=LCEbYt/z6n0ExJK2dER5ZyeKmOAH74d7TPoK42dTiJdIl/gthS1TJQfjXGmGZ5uSSFDs6g
 PyHOlVjansBS/n4bvBFuia6rEqMtoWwk06VtviOU5MTKEz7ghbDB5SluEe/kqwc/XZdSzb
 UJwjxjIoiVBtT2pHEjEI0RvPEBxUR/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-BHb8WixNOA-VPEU3mcQ1XQ-1; Wed,
 25 Nov 2026 16:27:53 +0000
X-MC-Unique: BHb8WixNOA-VPEU3mcQ1XQ-1
X-Mimecast-MFC-AGG-ID: BHb8WixNOA-VPEU3mcQ1XQ_1795624070
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D401955E89; Wed, 25 Nov 2026 16:27:50 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC5291801A62; Wed, 25 Nov 2026 16:27:43 +0000 (UTC)
Message-ID: <7cf84726-961a-4339-adb9-36ce342c911e@redhat.com>
Date: Wed, 25 Nov 2026 17:27:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "Oros, Petr" <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
 <MW4PR11MB6984FD51283AEF4F2B8E27E39B432@MW4PR11MB6984.namprd11.prod.outlook.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <MW4PR11MB6984FD51283AEF4F2B8E27E39B432@MW4PR11MB6984.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: JIgs6nnEsBqX7SkxNdnFlXtnSud7UUkU29X9F-kZDp0_1795624070
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

On 11/25/26 16:36, Kubalewski, Arkadiusz wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>> Sent: Thursday, November 19, 2026 1:29 PM
>>
>> On 11/19/26 02:44, Jakub Kicinski wrote:
>>> On Wed, 18 Nov 2026 16:29:23 +0100 Ivan Vecera wrote:
>>>> A step of the zl3073x PHC, which ptp4l and ts2phc do at start and
>>>> after a large offset, waits for the next 1 PPS edge, up to 1 s, with
>>>> the channel lock held. A phase step can hold it for up to 3 s while
>>>> it waits for the previous one. A dpll callback of that channel waits
>>>> for the lock under dpll_lock, and every other DPLL request and
>>>> notification in the system waits behind it. With ToD writes running,
>>>> requests to an ice DPLL took 1448 ms in median and 3.9 s at most.
>>>> With the series they took 0.2 ms and 0.3 ms, the same as idle.
>>>>
>>>> The bigger reason are zl3073x callbacks we are working on, which have
>>>> to wait for the hardware themselves:
>>>>
>>>> - a device reset with resync waits for the fast lock, up to 1 s with a
>>>>      1 PPS input
>>>> - a glitchless stop or start of an output completes on an output edge,
>>>>      so it takes up to one period, 1 s for a 1 PPS output
>>>>
>>>> Holding the global dpll_lock for that long would stall every DPLL
>>>> device in the system. For the output state we tried an asynchronous
>>>> implementation, but then the callback returns success before it knows
>>>> the result.
>>>
>>> Right, for these level of waiting async seems like the right
>>> direction, at least naively/without knowing the HW.  Why does the
>>> device wait until PPS to apply the step change? Is the programmed time
>>> supposed to correspond to the pulse?
>>
>> Yes. The device has no immediate ToD write, it can only write the ToD on
>> the next internal 1 Hz edge, the next input sync edge or the next internal
>> 0.5 Hz edge. The written value is the time at that edge, so the seconds
>> stay aligned with the 1 PPS outputs.
>>
>> Looking at it again, the zl3073x holds the channel lock while it waits for
>> the edge, although the dpll callbacks do not touch the ToD, TIE or phase
>> step registers, and they already run while the device applies such an
>> operation, because the PTP ops return right after issuing it.
>> I will look at narrowing the lock in the driver.
>>
>> For the resync, async is not only about reporting the result. Fast lock is
>> a setting of the DPLL, not of a reference, and forcing it makes the DPLL
>> ignore its frequency and phase error monitors. While an asynchronous
>> resync is pending, everything else done to the DPLL runs in forced fast
>> lock. A reference switch, whether from a priority or state change, a
>> manual reference or the device itself in automatic mode, would follow the
>> fast lock phase rate instead of the configured phase slope limit, and the
>> resync would then report success on another reference. A switch to NCO
>> would keep the force bit set until the work clears it. So every request
>> changing the DPLL configuration would have to fail with -EBUSY, cancel the
>> resync, or wait for it. With a lock per chip they simply wait, for at most
>> 1 s.
>>
>>>> A failure can only be reported by a later notification, and the next
>>>> request gets -EBUSY until the change completes. With a lock per chip
>>>> the callback can simply wait, and one chip cannot do these operations
>>>> in parallel anyway.
>>>
>>> Do the failures only happen because of "unforeseen circumstances" /
>>> EIO, or there may be more common errors reported? If it's just the
>>> former a devlink health reporter could be an option.
>>
>> For the output start and stop, only EIO. The device does not report a
>> stopped output and the driver can only wait for one period, so a health
>> reporter would work there.
>>
>>
>> For the resync, no. The wait ends with -ETIMEDOUT when the DPLL does not
>> enter fast lock, for example because the selected reference lost its
>> qualification in the meantime. That is a result of the input signal the
>> user needs in the reply, not a device fault.
> 
> Nevertheless we need mechanic to do it async? Or add a timeout for callback
> on dpll side? This global lock was never intended to wait a second (or below
> pointed 60 seconds) for the HW to respond.
> 
A timeout would not help. The core cannot abort a callback that waits
for the hardware, it could only stop waiting for the lock, so the
stall would turn into errors of the other requests. An async
mechanism fits the output state, but not the resync, for the reasons
above.

I would rather do what posix clocks and PTP do. A posix clock has an
rwsem that only protects its lifetime: every operation takes it for
read and posix_clock_unregister() takes it for write. The PTP core
calls settime64, adjtime and the other ops without a lock of its own,
only ->enable() and the pin configuration run under the per clock
pincfg_mux. Each PTP driver serializes its ops itself, and a slow
clock never blocks another one.

For DPLL this would mean:

- dpll_lock becomes an rwsem that only protects the topology and the
   lifetime of devices and pins. Registration takes it for write,
   netlink requests and notifications take it for read.
- The core does not serialize driver callbacks. Each driver protects
   its own state with its own lock, as PTP drivers already do.
- The other rules for drivers stay as they are today: a callback must
   not call a function that takes dpll_lock, and a driver must not
   notify while holding a lock that its callbacks take.

A pin registered by another driver is then no special case, because
each driver protects only its own state, whoever registered the pin.
The core only has to keep the notifications of one object in order,
with a lock per object held while the message is built and sent. The
cost is that a message about an object that changes while it is built
can mix old and new values, and the notification sent after the
change carries the new state.

ice already serializes its callbacks with pf->dplls.lock. zl3073x
relies on dpll_lock for the state shared by its channels and would
need a lock per chip, and mlx5 and ptp_ocp would need to be checked.

This does not depend on the RFC I mentioned in the other reply.

Would that work for you?

Thanks,
Ivan

