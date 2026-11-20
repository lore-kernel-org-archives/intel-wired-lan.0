Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C0606A6C4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=m0GLnFXB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NdXSkAAi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E0FF40E70;
	Fri, 20 Nov 2026 20:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvo1egbk2C7c; Fri, 20 Nov 2026 20:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0C5940E71
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795204900;
	b=pLCL2cv13tJRC+MOQ6dIVhQqam6yPmDk/hWmLG5U6kpOQCDrRrbLJ6RTmquUgOB5wxM4
	 aC9OLkZt/+TaOlz1eaYKIiByIL4oc5XWN4x7ij8pDd/DNoSYc2Zvxll3DgyiQyZxob80B
	 KB66x4VRJgBoOKLYF1iFymWWqxEdQ/xqMgNgGEUARJzsPwMQiKODkgqQrMnk3UhrHXBFL
	 aATA+xs6k16Q7D4mcZHr6J01oVguSF0UoeOO/4edxHacnsPR5m+fmkmJQUc/HgJoDt3eA
	 xUW54wLiHj9ojqhr4ZISeTmOW/aVtmZi07ZsRhQf4zpeXPGlwu9fSCuZwK9ytmnNu0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795204900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5QgfHDQQ4MSdGh+4Ts8IUMOxAYgDCdzXWqFzljmCVG4=;
	b=c1JFVgMO03Ut7eJtaJ0T3YLh1kLfd1hcI/4+slwdNEx14MTgG1yTeTYzwRYC4gtRLT2r
	 RfKdWpQd4vaQYGr49Vep+u6oeJJ0mrghCR7/692wAC2lFqxl+w3sFOuz1B5O5x0vogVLG
	 Nh74G6z/m9j2bADpbnEvQ4a2Ua0prsn2KHh96DnYW1CSb0VzZ84sUu2VmkWxgjib4zRx2
	 4VUL5pvc/dS3Rz+izNzSR6r1GIB2XIfuThc18AK5SW5WWh0fqTSDCpTJTl0g2D9MN6fBq
	 LFwptfWYTcJwo4RP90mvSsKv5ngwOZwnwVudliEwC4jL7pGxRq47DsVYrkr1vO0mIWw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NdXSkAAi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795204900;
	bh=5QgfHDQQ4MSdGh+4Ts8IUMOxAYgDCdzXWqFzljmCVG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0GLnFXBqBeJnOJwgthlR4lDpzacasDod+m9IVKljCV1f9hkQCmnK5XtfvDoNmvs6
	 eotkZRNyspKjyO4iP1+g5IExo1/O1FcoKeqrmW3td0WyO0f2G53MfhFfwVHw7TmlU4
	 f3+z+1S8HOErNNNpfSLUPHvHeGrM150NvXUU64xGFPJtUCprzpBVbaGhYunX5w6p/+
	 FaLAq426dz/ws7oop2X7hUj1PJP7OeHcKh3u/oIVnetUB8ojFFV8rOmpx140T2pOdC
	 FWKTaR9m2SJVcqQkjYAMgjcGAu43tHYc3wywfyYt9bD6RgWlE8tYQ4rzmMgijLKDtn
	 mnW1JmUQC9jRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0C5940E71;
	Fri, 20 Nov 2026 20:01:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08D57310
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E302A40E71
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DDH8Avb7c3-y for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 20:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8DD940E70
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::6d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::6d; helo=mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=NdXSkAAi
Received: from mta0.migadu.com (out-109.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::6d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8DD940E70
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:01:35 +0000 (UTC)
X-Envelope-To: intel-wired-lan@lists.osuosl.org
DKIM-Signature: a=rsa-sha256; bh=Uy/t5Hdz2eRHlZ3WuQOUva9nAZPCprYKY2wlV0ZSa2c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795204893; v=1; x=1795809693;
 b=NdXSkAAigZq/K+hjwFFSKgtpGag+fJQKUvtqfrJCSD1Anw7vzXsSqtWkcwH6hQG9YLr3UQWl
 5YUGB6DhuxNBayRbtYp/CdUpsd7VwI/k1ZUgp/KzSI8GcJovY8pz1wzbZkM7piucx1qwT3yfdHG
 7LuJjMzmuHQny33aQd4muMcs=
X-Envelope-To: intel-wired-lan@lists.osuosl.org
Received: by smtp.migadu.com with ESMTPS id b84f8d674bfff41c;
 Fri, 20 Nov 2026 20:00:29 +0000
X-Mizu-Trace-ID: b84f8d674bfff41c
X-Migadu-Flow: FLOW_OUT
Message-ID: <ff8b63b7-b943-444a-bd37-b6fb493b5d9f@linux.dev>
Date: Fri, 20 Nov 2026 20:00:27 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
 <20261119133851.3f25074c@kernel.org>
 <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 07:39, Ivan Vecera wrote:
> On 11/19/26 22:38, Jakub Kicinski wrote:
>> Well, I'm not convinced. The relations between objects in DPLL are
>> already quite hard to follow, and objects from one driver routinely
>> "plug" into objects from another. The explanation of the locking
>> rules in patch 9 does not look clean or clear. The driver facing
>> API needs to be much more "dummy-proof".
> 
> Fair enough. The complicated part of the rules comes exactly from
> that: a pin registered by another driver, like the zl3073x pins that
> ice registers with its TXC DPLL or uses as parents of its RCLK pins.
> A message about such a pin runs callbacks of both drivers. I have
> prototypes of the first four ways below to lock this, each with KUnit
> tests, and would like your opinion before going further.
> 
> In all of them a domain is the set of objects created with the same
> module and clock_id, dpll_lock becomes an rwsem for the topology and
> lifetime, and a mutex per domain serializes the callbacks.
> 
> A) Pin's domain (this series)
> 
>     Callbacks of a pin run under the domain of the pin, whichever
>     driver registered them.
> 
>     Pros:
>     * one domain lock at a time, so no lock order
>     * a request or a message about a pin is atomic
>     Cons:
>     * the callbacks of a foreign pin are serialized with the driver
>       that created the pin, not with the other callbacks of the driver
>       that registered it, so that driver has to protect the shared
>       state itself, and lockdep cannot check it
>     * restrictions for measured_freq_get, reference sync pairs and the
>       private data of a parent pin, which patch 9 has to explain
> 
> B) Registrant's domain, deferred notifications
> 
>     Each callback runs under the domain of the driver that registered
>     it. A message about a pin takes the domain locks one after another,
>     and notifications from callbacks are queued and sent once the
>     domain lock is dropped.
> 
>     Pros:
>     * callbacks registered by one driver instance are always
>       serialized with each other
>     * one domain lock at a time, so no lock order
>     Cons:
>     * a request or a message about a pin registered across domains is
>       not atomic
>     * the most complex core: a notification queue per domain, a lock
>       per object to keep its messages in order, and pin setters split
>       into validation and apply parts
> 
> C) Registrant's domain nested under the pin's domain
> 
>     Pros:
>     * callbacks registered by one driver instance are serialized with
>       each other and with the driver that created the pin
>     * a request or a message about a pin is atomic
>     Cons:
>     * the lock order comes from the topology, so a pin of A registered
>       with a DPLL of B together with a pin of B registered with a DPLL
>       of A deadlocks, and lockdep sees it only with a lockdep class per
>       domain
>     * a stuck foreign registrant stops the domain of the pin
> 
> D) Merged domains (your suggestion)
> 
>     Registering a pin with a DPLL or a parent pin of another domain
>     merges both domains. They are not split again.
> 
>     Pros:
>     * the rules for drivers stay as they are with the global lock
>       today, and lockdep checks them; the only new one is that state
>       shared between chips not connected by a pin needs a driver lock
>     * a request or a message is atomic
>     Cons:
>     * only hardware not connected by pins runs in parallel; on the
>       GNR-D system the zl3073x and all ice PFs end up in one domain
>     * a callback that waits for the hardware, like the planned resync
>       for up to 1 s, or for firmware still stalls all DPLL devices in
>       the merged domain
> 
> E) Global dpll_lock, slow callbacks asynchronous
> 
>     Pros:
>     * no change in the core
>     Cons:
>     * the resync problems from my previous mail, and a callback that
>       waits for firmware still stalls all DPLL devices in the system
> 
> I wrote before that stretching the domains would not improve
> anything on that system. That holds for the ToD stall I measured,
> but the zl3073x does not need to hold its channel lock across the
> edge waits. Without that, the remaining waits are the planned resync
> and output state callbacks, and with D they stall only the devices
> wired to that chip, which depend on it anyway.
> 
> So I lean towards D, as it gives drivers nothing new to get right.
> Would that address your concern, or do you see a better way?
> 
> It would be good to hear from the other DPLL maintainers as well.
> Jiri, Vadim, Arkadiusz, what do you think?

I totally agree with Jakub. Current implementation of DPLL subsystem is
over complicated, and all these complications came just to completely
model what was designed for Intel NICs, basically ice driver. But now we
are again back to the discussion how to complicate things further just
to fit what was implemented in the new generation of the same hardware.

Maybe it's time to step back and think if we really need all this, or
find simpler way to express/model things?
