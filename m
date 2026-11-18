Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CC60A2609
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FVxYzzzG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hmDK7YUm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7BBC407F0;
	Wed, 18 Nov 2026 15:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kLz8rVMU-8o; Wed, 18 Nov 2026 15:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0530F40710
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795015786;
	b=LuoCyDOV8vK8wDAEiLxkyUv9WGYtcbeLJdDnoW3o3HmAPNABAF1zOO/8dT5/hj2ESeBT
	 a1sRLe0R2dy3Jn35yIxRQL4JeHcrnMAieX6hTE66Ot0kStVOCk8+d7m5M21dUTmzBrmhp
	 InsPUfBB+1ZkOuaeSdRAxcWSPGIQwPtwOJNrRq5hLIHFj56yMjDrypcPXOBkLG9rp75ri
	 0jUYiWrXKsSufAIdbdlGHdmBUmY0P4t+P89Msuds84Ui2Swl7meBl+TqMpBvZ5DuS57uV
	 sk94jshJyxAzdOae9CtCVF5cqHwHeR804n6KDvrwR69V/ETIy0FllNq7CiGqHAQQyNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795015786;
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
	bh=NHqDOtS0lS6doahBqLnzZLX5z8l41ywkQe6VMKR5rK0=;
	b=lgqdsFvcrm7c2WESZRwWXNMkOUf5ga2SymVKACNUiMGSz5p5LJcrox7VL4C8m+m+rUCu
	 tWBC1vWEECWHHJByxuEzfvXNRqyPPhrFKRkzPcV+NtWMOuZaB4PxgjTyW3O5pACG02G24
	 yfiLvoCWM5iK12WF3Mg3l2Z61it8q6RRi+pwEYRLLctWiOLK3TQ4OaZEWvN63OazrgEat
	 TReq94q5g7LZN69mTnr7DwOv+6LY8uNyQUYn13sG6ZOTeo6yaojTNFUQ/ByTd0CRnsaSB
	 lHExolk45dP+k5+18WIm9/9nfZ7wLEFIGMBWC1ayamTcfINT17EADQ77iKzfFm8aa1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795015786;
	bh=NHqDOtS0lS6doahBqLnzZLX5z8l41ywkQe6VMKR5rK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVxYzzzGgiwzXPVGSWru1FIzL9OHvS5PV0B8iGIedWhMZGa2k9F/zNdLf4ZTri0Mz
	 pDtpJGXX+sDSnwBRBObvpEmF/6v7HqC5zyhfNd+3KGkb/HalOU81eT9BSGHwQ1J9oU
	 TdSigM4odPT43XbgEWAZoaSKDuV22vLDdOysGvMUseMPZnM1kSfPzf0w2YMpBoHVDu
	 wlhM3Rl4Oj3xdcg4E9KRzN/3dIXjhPNvDItGESEjPVYxUe+ub+sNnZ6p1V0nGDq8xR
	 pd3ft1uZzB2aQ7h49H/dSHzuP/7CPDjXKUxvlGJQCZTeXIHS4ClsAR79cIqrcnwrTo
	 CwAX0r4s1yc7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0530F40710;
	Wed, 18 Nov 2026 15:29:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 725BE28C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57EF08128E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0YQ-qJrNpUL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 15:29:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD82281101
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hmDK7YUm
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD82281101
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795015780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHqDOtS0lS6doahBqLnzZLX5z8l41ywkQe6VMKR5rK0=;
 b=hmDK7YUmn/OxzopHVOFKEjS6ddEutLp+aK8faN0HELU7KNOl4DwRsTmlRE5e4M6WYYSt0Z
 tH5/c37NklGU76Zamv9dpylfnRgZ5/vGqgtqYJPGoPWLWA34XyRDyOfuc999U1oc+B94Ez
 OXc5MgIpNhuLmz2azrtZz9LWkywY6/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-5El8isIuN3W04t7EZyFtcQ-1; Wed,
 18 Nov 2026 10:29:35 -0500
X-MC-Unique: 5El8isIuN3W04t7EZyFtcQ-1
X-Mimecast-MFC-AGG-ID: 5El8isIuN3W04t7EZyFtcQ_1795015772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE0341800471; Wed, 18 Nov 2026 15:29:31 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E01218004FC; Wed, 18 Nov 2026 15:29:24 +0000 (UTC)
Message-ID: <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
Date: Wed, 18 Nov 2026 16:29:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
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
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261116181612.107a4b57@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Lpo7RWZopu34CEOkU4bvfosabn6R9kmRxkfvrBoiehY_1795015772
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

On 11/17/26 03:16, Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 17:40:11 +0100 Ivan Vecera wrote:
>> dpll_lock protects topology and object lifetime, but it also serializes
>> all driver callbacks in the system, so one slow device stalls every other
>> DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
>> commands with a 60 s default timeout, and zl3073x callbacks can wait
>> seconds on a driver lock held across ToD writes and phase steps.
> 
> Can you provide some real life data of how much this actually helps?
> Real device topology + scenario you hit?

The system is GNR-D with a dual complex E825 and a ZL30732 on the
board. The zl3073x has its own PHC, takes the recovered clocks of the
E825 ports and feeds the TX and time reference clocks of the E825. Each
ice PF connects to the zl3073x like this:

   +------------------------- zl3073x --------------------------+
   |   EEC DPLL, PPS DPLL                                       |
   |                                                            |
   |   input pin                       output pin               |
   |   (recovered clock of E825)       156M25_NAC0_CLKREF_SYNC  |
   +-------^---------------------------------|------------------+
           | parent pin                      | registered with
           | dpll_pin_on_pin_register()      | dpll_pin_register()
   +-------|---------------------------------v------------------+
   |   RCLK pin                         TXC DPLL                |
   +------------------------- ice PF ---------------------------+

The PF owning the source timer also registers the zl3073x output pin
156M25_NAC0_TIMEREF_SYNC with its TSPLL DPLL.

A step of the zl3073x PHC, which ptp4l and ts2phc do at start and after
a large offset, waits for the next 1 PPS edge, up to 1 s, with the
channel lock held. A phase step can hold it for up to 3 s while it
waits for the previous one. A dpll callback of that channel waits for
the lock under dpll_lock, and every other DPLL request and notification
in the system waits behind it. With ToD writes running, requests to an
ice DPLL took 1448 ms in median and 3.9 s at most. With the series they
took 0.2 ms and 0.3 ms, the same as idle.

The bigger reason are zl3073x callbacks we are working on, which have
to wait for the hardware themselves:

- a device reset with resync waits for the fast lock, up to 1 s with a
   1 PPS input
- a glitchless stop or start of an output completes on an output edge,
   so it takes up to one period, 1 s for a 1 PPS output

Holding the global dpll_lock for that long would stall every DPLL
device in the system. For the output state we tried an asynchronous
implementation, but then the callback returns success before it knows
the result. A failure can only be reported by a later notification, and
the next request gets -EBUSY until the change completes. With a lock
per chip the callback can simply wait, and one chip cannot do these
operations in parallel anyway.

> For the cross-domain pins - shouldn't we stretch the domain to cover
> all interconnected objects on the system instead of hoping people get
> lock ordering right? You documented some rules in the doc, admittedly,
> but not sure how enforceable and practical they are.

Stretching the domains would not improve anything here. The only
in-tree registrations across domains are the ones in the diagram above,
and every PF connects to the zl3073x, so the zl3073x and all ice PFs
would end up in one domain. The system above would then stall the same
way as with the global lock.

There is no lock ordering to get right. Only one domain lock is ever
held and all of them share one lockdep class, so any nesting is
reported. __dpll_{device,pin}_change_ntf() assert the domain lock of
the object, so a callback notifying an object of another domain is
reported as well. The rule that a callback must not call functions
taking dpll_lock holds on main already. What lockdep cannot check is
that a driver registering a pin of another driver protects the state
these callbacks share with its own ones. ice is the only such driver
and uses pf->dplls.lock for it.

Thanks,
Ivan

