Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C30606A334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3NJmi2Kf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+bcswEi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D40F40A11;
	Wed, 18 Nov 2026 13:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3JmfFB9ckwz; Wed, 18 Nov 2026 13:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 470A440A0B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795009925;
	b=N0Hbf96BtWJ2sZNjH55NzZu4xikUi+Y0+HU4NP5f/c4sMfT/k3FzM2w3na9AhOsB3+8x
	 qxn5pEDvqBivMCrrmIhGja27IfJS4BFmEP9SzWHHIuow+GYRTUj6qfAzpLNix+HJcVBUk
	 LQuUEV8pXOdelqpgOgdHng3VNwZnpuYrhoavR0P0vybC2CKnvNX/yRkWaDoSOzzm9kXuj
	 KIdZ/8iz4qIBE5+lTfem8JTuiMvRIUaY8EOKdJ8Ravbque/xldMA7gvk72Am5nSltzAaQ
	 92uMa26HN6W2wh85DQaAlblJ9X8eW7J4j41GvpSIb8JxIzNr1dH0peWTWnv5WewOvfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795009925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F8kua1cmraI2viyb+1+A/OTOAgSZVMOfMLbqcfW+fpI=;
	b=sldYmDeTh2OqcbcxiiYFizBQrfPAJIfMW3+Cig8qUT25xmeDfZdVdHLIt1rWt5NrJSru
	 +DtBcT+YrAchecCJYzl0lclWlv+Ifw3kpC/6a+njnTITgCivhewhLRsCg/NtXPG2ezfPl
	 YotxujKnTAbO96jOHVeMpe/v0tOQXuoCSfrPl8tjfZKjyxoMYZvJnKwHCYUTLHw0XYSmu
	 e6iFhPpJ7SfFxvNxzZLtcdbz2ysNsptLJZehiaiitorkzeqqJ/G5hIvQx86HqLLk82iZx
	 JqaQUl2x7PPKWp5KDHrX9QzjyXt2xT9DKJx1bagpBfnCZJANHUstrXv105rwx3R+G6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+bcswEi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795009925;
	bh=F8kua1cmraI2viyb+1+A/OTOAgSZVMOfMLbqcfW+fpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3NJmi2Kf32+tOhnSWu4Apm87z2pcpUvmjg7V4ZNUbyTebXwb+Vi+I2TL7LGySIxK7
	 6wTvbRFjzNoBK+KIEFXl2huHTwcZPrLiRH9FSqo5R1zMPjgBSlQ4QLQJCA57ecg20Z
	 F/uK12vzI7DXlgpL5Aitn6UncwyA15l4e93fCoeRPKI0JwLjcC3ZXSQp/iiCkX9id2
	 f4OeK5FAVh5bZKDavJC1wJddnCdRwSvADRfO8n/pLHnEvFVqu2rru+S5s/a2RVcPlc
	 VHPFuVXge2zJI6d9Z+8nSkAqiMTBPO7SCWDn7yqzHUlItlkKDpyJQTkddLxPQvCyUV
	 tGKl1sKFDSu7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470A440A0B;
	Wed, 18 Nov 2026 13:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5903977
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9696F40A09
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzMFJKJZrtH7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 13:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0C65409FD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+bcswEi
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0C65409FD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795009919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8kua1cmraI2viyb+1+A/OTOAgSZVMOfMLbqcfW+fpI=;
 b=h+bcswEikVEQowqxdH0mb1yG1Ym0oF0pPyebxm4N8VSOexReSoz5tUVxCXtPekUUHCxfd6
 jMheDoj0/RrVz1QXoiQXlsaaqlBHk3L2gHvlLy5Bt8dTgKs1Aeo8PlwYC8fFGuFdX+AR4f
 18BoR5s9MB0dBYeeY+CzDAXm+P4mdME=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-83nazpIVNnWejUZiQ8hIMA-1; Wed, 18 Nov 2026 08:51:58 -0500
X-MC-Unique: 83nazpIVNnWejUZiQ8hIMA-1
X-Mimecast-MFC-AGG-ID: 83nazpIVNnWejUZiQ8hIMA_1795009917
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-49205554e17so779635f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009917; x=1795614717;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8kua1cmraI2viyb+1+A/OTOAgSZVMOfMLbqcfW+fpI=;
 b=LtQ39yPEfiG+ATIGn8R/3Y3bWYCjHa7oyzlFOAbVNQuGXmit0Z8BvwNYTWf83SVAcV
 tdBqVgpkpxO12KqsQj5QrlIhl3XRTrXORPKKiDwLKUNRRD4zAIlImHKeAsEBk4ZXRU8B
 kuAk4F05oBg/EiYUt07U7D8iBBWBufIiKwL9YJcHWIrPHoDvi481X5mS5digrllOgQ/C
 MsD75RtGhGXn2b4RfArC1M+3qzYfkAiisZ5/qFa1wal7aLu3NCs43oWcq8mz+TlakKWx
 opkVPmdBEBKK1ZHAvY4tY31Krpl2jxr0rEoRN9+aNKWmJzHiS/P6s5n9myqQvl2nCBzz
 ZX5w==
X-Forwarded-Encrypted: i=1;
 AL+hErFlqDTo+kWPSo2ieowCUFZP8xZChby3PaAd4qI09cVlqzn2TYtHMaO5jhhvXirzjO8iqIkbosN91ZE7rEg0Mj8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/YNCJLujf9ANO551bIrsvdQLQrBisNqKyI5WS94wrIxcWhdzr0
 C+wIMRktZqPgFLjw5IDSAmVrl1GckhD0IUhgXv0ZQOltnxHUIA/neyMemLDsWJVHQKCPkDiVU06
 T+Y0htbX2E6HMCfAjXQmSL7RE1yw3dkYfFndkyxCRhJ//gmut4z3t3n0ZqFfI+WLMBHEomP8=
X-Gm-Gg: AZFdTZc8WpvOiWYmeoJ019JDZjHxaB452OasQx2h/CsPaWsKfPmXZH6HDrg3ZLBLz6q
 WmQ00TUatatvOOUxXn6w9gSWphcNVUUEGWv+N2cAquREOSbIOgXZ3o8AtxawylYaRLaGaIo+0JO
 vzMvQJpMRAPFceD547hHaI+9Bh5pAX068w3voUOcYtFWzzPuVCe1TQ9DHxH6tAJvyjkZhgJ5UAq
 v2luTrCm5IRFNH6j63MopyGziXFcqsUFBU01aHkieZsSus3vEVwtrH3v8B4lQyPtdI1khLILxDv
 iKv/py4fz2RPkRH/OrDpG5ACf4uOkpectE32Ey8NwyJYa19uxUnwbx/ClFTsfWb979hWGYIRN7N
 HXCzDG1K2B+CXtcjbJgUeg6H6hpcrXGNEdQSM3gasoAwZB4E=
X-Received: by 2002:a05:6000:658:b0:4a4:4229:c3a2 with SMTP id
 ffacd0b85a97d-4a63984bb27mr4798124f8f.11.1795009916917; 
 Wed, 18 Nov 2026 05:51:56 -0800 (PST)
X-Received: by 2002:a05:6000:658:b0:4a4:4229:c3a2 with SMTP id
 ffacd0b85a97d-4a63984bb27mr4798072f8f.11.1795009916375; 
 Wed, 18 Nov 2026 05:51:56 -0800 (PST)
Received: from [192.168.2.75] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65100c6bfsm4754288f8f.2.2026.11.18.05.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 05:51:55 -0800 (PST)
Message-ID: <f7f1ae2d-a623-4eb7-a178-c618316beaf5@redhat.com>
Date: Wed, 18 Nov 2026 14:51:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
 <av2syi6lE/Vp86QW@boxer>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <av2syi6lE/Vp86QW@boxer>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yYPepuzVig6npZFuIrzIVn033zVaIW1UdrUy_APvtcI_1795009917
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



On 11/18/26 2:48 PM, Maciej Fijalkowski wrote:
> On Wed, Nov 18, 2026 at 02:37:06PM +0100, Magnus Karlsson wrote:
>> On Wed, 18 Nov 2026 at 13:00, Petr Oros <poros@redhat.com> wrote:
>>>
>>> I think this pull is a good moment to ask how fixes for Intel drivers
>>> should flow, because it is not the first time a fix spent months on
>>> intel-wired-lan and then hit a wall on net.
>>>
>>> My patches 2/6 and 3/6 have been on intel-wired-lan since June, v4 on
>>> July 8 [1]. They were reviewed and tested by Intel validation there,
>>> and four months later Sashiko found real problems in them on this
>>> pull. I have a v5 and will send it once it is tested.
>>>
>>> Jake's E82x timestamp fixes went through three pulls before a part of
>>> them was applied [2], and Maciej described the same loop on the i40e
>>> pull in September [3].
>>>
>>> I know Intel patches go through iwl and are not applied to net
>>> directly [4]. But for fixes it means that the review which decides
>>> happens on netdev months after the iwl review and validation, and every
>>> respin goes through both again. And if iwl stops cross-posting to
>>> netdev, as Jakub suggested [5], Sashiko will see Intel fixes only in
>>> the pull.
>>>
>>> So does the iwl round still make sense for fixes? Would it be better to
>>> send fixes straight to net with iwl in Cc, and have Tony's ack and the
>>> Tested-by from Intel validation on netdev?
>>
>> Glad you brought this up. IMO, it makes no sense for fixes to go
>> through iwl and it makes contributing fixes (or new
>> features/optimizations) a lot more painful. Sometimes even to the
>> point that you just stop contributing something. I am not in the NIC
>> team at Intel, but sometimes I have to do network core work that also
>> touches our drivers. In this case, that patch set goes straight to
>> net-next (as iwl cannot and should not take core patches), but any
>> driver fix that I find on the way needs to go to iwl-net so that it
>> can go to net and be backported. So the fixes that my patch set are
>> dependent on and that should go in first are instead sent to a
>> slow-path (i.e. iwl-net) and after X weeks/months appear in net and
>> then net-next. But my patch set in net-next is dependent on these
>> fixes so I have to either wait or just cross my fingers that my new
>> feature is stable enough even without those fixes. Not optimal in my
>> opinion.
>>
>> So anything that could be done to speed up this process would be very
>> welcome. Sending fixes straight to net would be great. The validation
>> team could pick those patches up from the list and run the regression
>> tests against them, or would that take too long?
> 
> Regarding providing Tested-by tags, could we lift the policy where only
> Intel validation is allowed to bless the patch? Nowadays with AI regular
> dev can spin up a nice pile of tests by themselves.
> 
> So if you send a fix and you can find a peer that will test and review it
> for you, I don't think we have to wait for validation folks taking care of
> it if they are swamped.
> 
> I also don't think it would backfire on us and we would introduce some
> bloody regressions, given we have {s,cl}ashikos in the pipeline.

BIG +1

> 
>>
>> Anyway, good initiative. I am sure there is a solution to this that we
>> will all like.
>>
>> /Magnus
>>
>>> [1] https://lore.kernel.org/all/20260708125755.706263-1-poros@redhat.com/
>>> [2] https://lore.kernel.org/all/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com/
>>> [3] https://lore.kernel.org/all/are4rBUJO3mzrkO8@boxer/
>>> [4] https://lore.kernel.org/all/20260721174642.7749143e@kernel.org/
>>> [5] https://lore.kernel.org/all/20260922112216.41e6f8cf@kernel.org/
>>>
>>> Regards,
>>> Petr
>>>
>>>
> 

