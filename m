Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5087606A32E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=y6/yVzQe;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpfsbBO9;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C52CC40AC2;
	Wed, 11 Nov 2026 10:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jaaqlr0AtoaD; Wed, 11 Nov 2026 10:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 377FD40ACD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394732;
	b=lIm8CVvmZpptUDy97rWRXdx59B4Zb2jTud3B7McrDJoJ49CnCbxV5KRf+vhR1Dg/CrqP
	 wGohULBQH1nJ8Ze7vv1D+iXJNB3pSCn/ojW4i+EqlIRvGlw94JEvQXf0jRI5p7B/YuwwZ
	 oEMPehmUERkErMeS19YkLRrXDKdj8YwgtypwIEtHznfT+GjqL4m6nwvtARqFLIAlnULGc
	 Q6YZo4ZkqUC28L/mw7r958UiFRXm2aQkxPrygodRc44D2BQ2LLZiSC1sIBGeJIZfrcuE0
	 LbynW0Hi4QH3fAE92YlFAIKf2OunpVND5CuMmSOfi2S8Z2M9JjD/526xJmy6rcEEmog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
	b=jbQ+S65UJfHpqRPERYwxQ5UDZw1k8CcLA9MF1mQKC6NemIj8iVwKwvZA5dx0qQFiFKaK
	 rOSOwxdVAfSDLOUcnmnrde4hH+kpXIIuMiNcjLf0nJTlBXGA+arZaYv9ftV9ja1BwbqtC
	 EcVRswum39DROT7lSl9+PFz5NQLlfU8D2wvUB665xAfXve23GqLxYYTECu5uHVKyPLfan
	 /kFtw+AIdk4MY0llQ+tBjONDF2b9UDwoXYYtdlC0BeZX2wpElSjX0vAdDcBjHQjpU9hCX
	 +Fx9HjgpJXb8feZBwTvomHlArFEo88P4N9vFEBN86+NLdKMXKGrsJWQbRRZATHhJMCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794394732;
	bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6/yVzQe7JPzjlv9ZaGsU5alRFzcb46F2wDM1qet3xIj/wRZVOSqrdKx4z9qUL7/O
	 OPKh4YadwhNTa38eCXEMqj2GB1V7JxGNXpiryty0wfIW3nLRUxVBbNqUPu0KEmQq8h
	 nL5SZGZJrDqCIDJ1XKLx5wC4UEK1auf4Flyi8QNmeO0bp85wK3SLpoTKG3F2wiouNb
	 mqhzdpGNEZRHkc5qZLKafg2UgViQQQPgh9FcXB43Smjas4B1nHrtkps9Rmzj/kqQ/q
	 kpxB3n17oNzMk9KBiG5GIpNQmPIa7rR5YeXJVwosZXYNeMY1vaUvzpaGNIekoNvIs3
	 JU/al9UWIv2dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 377FD40ACD;
	Wed, 11 Nov 2026 10:58:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FFFD28C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05A93403C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9iCxVVzirOz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 10:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 536B3403A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FpfsbBO9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 536B3403A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
 b=d8dnlWCtsmXWFzSobKkj5jXct0X2mK7Hq2KnkRDOZl+UmlfbVcQmCIU+kKUSC2oKaAdsqB
 1Di84e6g7dRhYmCrrieYvCx0bsWf6ZzHi0Mr/Oq7mOl0tmU50tQMDM3go11eSx78qBgqTb
 QAw7014+ARoXI1hMHULqpL4TvQZXXB8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
 b=FpfsbBO9ZIt21iHIeLJRuaonAVW3pPQOOUZqIAbqpG89YpEMCb3GgwrWTcFLpSnrt8bwrr
 1xzuHcN3WSMvxvIuVf87glceIwmuDnKUSlJ0TctiCY27aJMXgxrFvJ6iwGi8DnEvkQLB3Y
 YHEk7oWQgyXJzvx1YaGGB9tg+JaCI0Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
 b=d8dnlWCtsmXWFzSobKkj5jXct0X2mK7Hq2KnkRDOZl+UmlfbVcQmCIU+kKUSC2oKaAdsqB
 1Di84e6g7dRhYmCrrieYvCx0bsWf6ZzHi0Mr/Oq7mOl0tmU50tQMDM3go11eSx78qBgqTb
 QAw7014+ARoXI1hMHULqpL4TvQZXXB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-_cNDg14-MKmcaMnxWv85kg-1; Wed,
 11 Nov 2026 05:58:45 -0500
X-MC-Unique: _cNDg14-MKmcaMnxWv85kg-1
X-Mimecast-MFC-AGG-ID: _cNDg14-MKmcaMnxWv85kg_1794394722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 398A51955F6D; Wed, 11 Nov 2026 10:58:42 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD9F718004FC; Wed, 11 Nov 2026 10:58:35 +0000 (UTC)
Message-ID: <38e49109-be77-4f81-a663-276c0e6301c0@redhat.com>
Date: Wed, 11 Nov 2026 11:58:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] dpll: add domain object
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
References: <20261106121005.1327603-4-ivecera@redhat.com>
 <179433320288.994134.11961533455589849486@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320288.994134.11961533455589849486@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: nHrUfsSe5_sjARkwWntR9rO8-jzHpPl2J_kg5Mpag50_1794394722
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The comment on `lock` in the new struct dpll_domain
>    (drivers/dpll/dpll_core.h) says it "Serializes the driver callbacks of…
> 
> --
> 
> dpll: add domain object
> 
> This commit adds struct dpll_domain, which groups all dpll devices and
> pins created with the same (module, clock_id) pair. Domains are
> refcounted, stored in an xarray and freed along with their last object.
> It prepares for serializing driver callbacks per driver instance instead
> of under the global dpll_lock, and states no functional change.
> 
>> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>> index da8a369556ed1..6705e81bc11de 100644
>> --- a/drivers/dpll/dpll_core.h
>> +++ b/drivers/dpll/dpll_core.h
> 
> [ ... ]
> 
>> +struct dpll_domain {
>> +	u32 id;
>> +	u64 clock_id;
>> +	struct module *module;
>> +	refcount_t refcount;
>> +	/* Serializes the driver callbacks of all DPLL devices and pins
>> +	 * that share one (module, clock_id) pair.
>> +	 */
>> +	struct mutex lock;
> 
> [Severity: Low]
> This isn't a bug, but is this comment accurate at this point in the
> series?

[...]
> Could the comment say the lock will serialize the callbacks, or could it
> be added in the patch that starts taking the lock?
Right, nothing takes it before patch 4. In v2 the lock will be added by the
patch that starts taking it.

Thanks,
Ivan

