Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C997606A325
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fvGZ8e4s;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vdf/x4vk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BFBA4071D;
	Thu, 19 Nov 2026 12:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLhLjkr2f7-E; Thu, 19 Nov 2026 12:29:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DE364069D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795091373;
	b=lAcjwWlCUEB0XRTLmMtLeljvylj/j3PXLScTYcBALv3Qfc8BPYzjzfR7+Pu/Cfcq1ibK
	 YQdwGF7QA7wpDQZ4SYmibOa6+vIvQMEzcgV277MLmFlFoC5CeCEGwVpfPQrTj90RAumMz
	 OuCzp8+PQD/Lj7rfHMl3N8js9JQOCv63IuHnKw3j1EDZgAeOhvSjkQmrElyJshnC8iNPN
	 x99wcliWO0q3yIggB7RklJoU/5sYrk60iUEqnwLPYTLVPL8A8jwMlj3ISWM5+lzl1OpFz
	 YK+vhLfsHSsf443Gttml9uGWhiXXbwwClW50nTwsoRpttIQy5AkLkQEGHrpp4CjW8Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795091373;
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
	bh=26aI3dIJvKPWaIP7OH1UV6UOwwhdI4DXg4en2db6lzQ=;
	b=qbZoCXiJKw+xLCUivLGVOxEVgzglbD5vSQd3UTcuhr50HArr/ku5lrJ+mu+vtfCsAIaP
	 Efvg1mYYIpGe6OIYwr2t4eHUlXEFaUH2tD/vcslHaCIF2UpTqTXTy6pAbBbFu+fVwzyCT
	 v29peF28e714lpuSiwDMxsuCvX41kWF2c+SYLy47EGOAiWXnEAV5EAeitdnnSSUdElLvO
	 dsOtOHe2Y3gy2QHYCMQwkpIC98kuuG2da2eIFygomq11+wdmWKPwSZXXF8HikZT4JSxxf
	 TGnfn9t54B5dqliQ5qK24Gy20Zoj5X8AKOHoti6HTt73K0yqWl+bcK6DO2sElbI+LCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795091373;
	bh=26aI3dIJvKPWaIP7OH1UV6UOwwhdI4DXg4en2db6lzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvGZ8e4sa1o5NE2uuQG2af4w2lugszN5Jax7tqxVctNxuE2cTvvrZXIDZK4OIociK
	 gtcbHZMsUrp2CFcNd44Ci+KxhZQkG7K4zx8mheZJ1wWleOPrB2ZtCAJueSdNyQG8yw
	 Ta6RHFkdA2F12aDdd5xbamMJ7gZHvE5F2iFMrPqV4/sgKxZ3rsCxJZM8uMkj+/tmNv
	 EHYMqBuvPkiYZla736V7Ug+UBQMQ6KxK6z1xGnsPBUZCeFjUiZTojXyP21wXXcVEGK
	 EmIKC+FtG03ePLZQoythSTEyB2auK6169Nts9xtat8sALLVEVaxY0rr9YWOaIc3PiX
	 Vrh1sYJrKCBgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DE364069D;
	Thu, 19 Nov 2026 12:29:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D69952FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7B8C810CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifMOfqgNTIvW for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 12:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CFDB8104C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vdf/x4vk
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CFDB8104C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795091368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26aI3dIJvKPWaIP7OH1UV6UOwwhdI4DXg4en2db6lzQ=;
 b=Vdf/x4vkw1KHSgrK6VYBj5QclK0GSUGQmjNFhQeUFlh5PaF9b1uEAuC2li8b78W5L5j8Hs
 HEuAH8hSINZRTdvzqX9EA2ZR42jLIKrCJMyWh6Mr+T9vX07NbnR6gD12hnREaYuOO4fkz8
 ybf7QXJXJwEiSXfC6HNlFRK9JzO+1II=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-F6N0bqgfOKGGCYzO7xJ5Cg-1; Thu,
 19 Nov 2026 07:29:23 -0500
X-MC-Unique: F6N0bqgfOKGGCYzO7xJ5Cg-1
X-Mimecast-MFC-AGG-ID: F6N0bqgfOKGGCYzO7xJ5Cg_1795091360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C195218004DF; Thu, 19 Nov 2026 12:29:19 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEA221956041; Thu, 19 Nov 2026 12:29:12 +0000 (UTC)
Message-ID: <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
Date: Thu, 19 Nov 2026 13:29:11 +0100
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
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261118174424.32e9f130@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: VRBouWB4gN6IyvwUZf9rJURRYWcgJOtXTY23lZhk_Wo_1795091360
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

On 11/19/26 02:44, Jakub Kicinski wrote:
> On Wed, 18 Nov 2026 16:29:23 +0100 Ivan Vecera wrote:
>> A step of the zl3073x PHC, which ptp4l and ts2phc do at start and after
>> a large offset, waits for the next 1 PPS edge, up to 1 s, with the
>> channel lock held. A phase step can hold it for up to 3 s while it
>> waits for the previous one. A dpll callback of that channel waits for
>> the lock under dpll_lock, and every other DPLL request and notification
>> in the system waits behind it. With ToD writes running, requests to an
>> ice DPLL took 1448 ms in median and 3.9 s at most. With the series they
>> took 0.2 ms and 0.3 ms, the same as idle.
>>
>> The bigger reason are zl3073x callbacks we are working on, which have
>> to wait for the hardware themselves:
>>
>> - a device reset with resync waits for the fast lock, up to 1 s with a
>>     1 PPS input
>> - a glitchless stop or start of an output completes on an output edge,
>>     so it takes up to one period, 1 s for a 1 PPS output
>>
>> Holding the global dpll_lock for that long would stall every DPLL
>> device in the system. For the output state we tried an asynchronous
>> implementation, but then the callback returns success before it knows
>> the result.
> 
> Right, for these level of waiting async seems like the right direction,
> at least naively/without knowing the HW.  Why does the device wait until
> PPS to apply the step change? Is the programmed time supposed to
> correspond to the pulse?

Yes. The device has no immediate ToD write, it can only write the ToD
on the next internal 1 Hz edge, the next input sync edge or the next
internal 0.5 Hz edge. The written value is the time at that edge, so
the seconds stay aligned with the 1 PPS outputs.

Looking at it again, the zl3073x holds the channel lock while it waits
for the edge, although the dpll callbacks do not touch the ToD, TIE or
phase step registers, and they already run while the device applies
such an operation, because the PTP ops return right after issuing it.
I will look at narrowing the lock in the driver.

For the resync, async is not only about reporting the result. Fast lock
is a setting of the DPLL, not of a reference, and forcing it makes the
DPLL ignore its frequency and phase error monitors. While an
asynchronous resync is pending, everything else done to the DPLL runs
in forced fast lock. A reference switch, whether from a priority or
state change, a manual reference or the device itself in automatic
mode, would follow the fast lock phase rate instead of the configured
phase slope limit, and the resync would then report success on another
reference. A switch to NCO would keep the force bit set until the work
clears it. So every request changing the DPLL configuration would have
to fail with -EBUSY, cancel the resync, or wait for it. With a lock per
chip they simply wait, for at most 1 s.

>> A failure can only be reported by a later notification, and
>> the next request gets -EBUSY until the change completes. With a lock
>> per chip the callback can simply wait, and one chip cannot do these
>> operations in parallel anyway.
> 
> Do the failures only happen because of "unforeseen circumstances" / EIO,
> or there may be more common errors reported? If it's just the former
> a devlink health reporter could be an option.

For the output start and stop, only EIO. The device does not report a
stopped output and the driver can only wait for one period, so a health
reporter would work there.


For the resync, no. The wait ends with -ETIMEDOUT when the DPLL does
not enter fast lock, for example because the selected reference lost
its qualification in the meantime. That is a result of the input
signal the user needs in the reply, not a device fault.

Beyond the zl3073x, with the global lock any callback that waits for
its device, for example an mlx5 firmware command with its 60 s timeout,
stalls the DPLL devices of every other driver in the system.

Thanks,
Ivan

