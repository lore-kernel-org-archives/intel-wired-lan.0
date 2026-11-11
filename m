Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B2606A884
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HCMOs4ok;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+VJlY/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+VJlY/;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+VJlY/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CABEF40827;
	Wed, 11 Nov 2026 11:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vogitO3WsMM; Wed, 11 Nov 2026 11:06:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E3FA40829
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794395194;
	b=aSWtOWWqcEoqXC2y4iKfX+MuWvveehHsHyJWOh3GFgLd6wHlSfaZLGCco0EA74ZgiL0Y
	 33Ks1CgR11GPVF7F4TOqNOVgU4iR0f6GFt/but7O2xs2S15zD69zi8zdwmYFRDvBxT4C2
	 /+Wl44HcpIksqU/aiRAfdFop9C61L3twFZn83o+KMC6eGTulREDFpVg8Kgn7c6J+CjNty
	 5EF036rHT8To94l/XXNmknai3xE3rJ74KMcNBNA8dxQxIv9S5PgMxj1kuo0HLFlQwm8zS
	 ipwFnJo74DNBzKEyfo/MjdSPlw4MrT5iMUGmdvnyycPq1M/24fwRGyFV3FU/jb5hdeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794395194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
	b=UYNOClOsVN9+jqP2h0QT3Y4pGob9uS9+bRdrit08FGwg9dEzz/B8f+bvS8i8zjxko7EJ
	 QJUGtTsMru3C1WleWFQmx8xAEm5tw0dbufn84Rkd0GaHUnQaVgZ8dbRFXSrohKXIPPbWY
	 GbuGkKCtJjrAds9JLDtfwoorGhtv6u0pmLRwWkg2Znc+Pi7+YBcIFyg0UhCExrV9/KN/d
	 rgC2BrlheCCAO8LlaqmcarUPbj39BR6Nuh9Nhd5vKhoJ2XI7ONUTSme9rdIHWljFNSwtx
	 csGTjPRCAxDjCz2nFNdkYpeSYEp1lLwxidMFMeGX6Qziv3q/n/c5cE3sflXNd1OiRFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="VA+VJlY/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="VA+VJlY/";
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="VA+VJlY/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794395194;
	bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCMOs4okWeYpP03dZBBS4Vrr6oKhBNQ3CyEnUuSMRkjcmlt/sQn4w/4jzo6mTghff
	 7JKM85R7EIxyvNu+QR5kz4mVlwXz3o8gFNnjYjecP+dhnBWWLbhQdxzLT+d4f/9mqQ
	 E3xmdnL6ROjK+xVn16Q2tWo2hbxTrzjg+OQSi+ndhX7w7GEZOLHjOJUk5jk3DMnbZ3
	 xuecZpJVsH9MjQhz0x92Uhh5tajTBIpQJbDCCjZVXSOdb9xN4YGnGxq3oRTIIFbFg+
	 oxWwO1dTFlN98MhneO8IlG1CW6k0ylENwmIRP5w8McnqueejNOApMUPbNtgIzIQYnc
	 fxVAhYxV/QOqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E3FA40829;
	Wed, 11 Nov 2026 11:06:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E901B731
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D453840829
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CObJ91ag1Xa7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 11:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFC2540827
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA+VJlY/; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OqoOBJF4; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=VA+VJlY/; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OqoOBJF4; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=VA+VJlY/
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFC2540827
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=VA+VJlY/IkV5d4ghcelGR4YwrVeBXM7SoJyE9auTejl+hn+f+sUC2Ngt88a6ZiQ22Lb79I
 I/MPx1nDZoFBkTxTHz2gEdHeeRONEsFf17AYJfFsMp21OHnb9h3Eu10p0ybAe8frMKv8ib
 vjEYMm5POxw2If7F/MVRIemGqkYy++4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=OqoOBJF4m2v5gUmkaG5IvUImW6eqisbHe0JsZbOIkHxPceiHs06ic5lI8GojOX9iHNjdiZ
 dGsTbB8WNTexdFE2NjRMsw05btR/81d0OX7Tb4cKI/eZr9T1rPzSVdmpuNzEg1pT/sdx95
 h8FgEoN2QgmabtwKbTvHFP3HkGl1dro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=OqoOBJF4m2v5gUmkaG5IvUImW6eqisbHe0JsZbOIkHxPceiHs06ic5lI8GojOX9iHNjdiZ
 dGsTbB8WNTexdFE2NjRMsw05btR/81d0OX7Tb4cKI/eZr9T1rPzSVdmpuNzEg1pT/sdx95
 h8FgEoN2QgmabtwKbTvHFP3HkGl1dro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=VA+VJlY/IkV5d4ghcelGR4YwrVeBXM7SoJyE9auTejl+hn+f+sUC2Ngt88a6ZiQ22Lb79I
 I/MPx1nDZoFBkTxTHz2gEdHeeRONEsFf17AYJfFsMp21OHnb9h3Eu10p0ybAe8frMKv8ib
 vjEYMm5POxw2If7F/MVRIemGqkYy++4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794395190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=OqoOBJF4m2v5gUmkaG5IvUImW6eqisbHe0JsZbOIkHxPceiHs06ic5lI8GojOX9iHNjdiZ
 dGsTbB8WNTexdFE2NjRMsw05btR/81d0OX7Tb4cKI/eZr9T1rPzSVdmpuNzEg1pT/sdx95
 h8FgEoN2QgmabtwKbTvHFP3HkGl1dro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794394889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j68fncYFG3wRKRfnvYuffOG/HpagUvbeYFES/ium9zw=;
 b=VA+VJlY/IkV5d4ghcelGR4YwrVeBXM7SoJyE9auTejl+hn+f+sUC2Ngt88a6ZiQ22Lb79I
 I/MPx1nDZoFBkTxTHz2gEdHeeRONEsFf17AYJfFsMp21OHnb9h3Eu10p0ybAe8frMKv8ib
 vjEYMm5POxw2If7F/MVRIemGqkYy++4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-rbdtinCuP1GMtHMkRB0Fgg-1; Wed,
 11 Nov 2026 06:01:27 -0500
X-MC-Unique: rbdtinCuP1GMtHMkRB0Fgg-1
X-Mimecast-MFC-AGG-ID: rbdtinCuP1GMtHMkRB0Fgg_1794394884
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE261955F0E; Wed, 11 Nov 2026 11:01:23 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B82171800495; Wed, 11 Nov 2026 11:01:17 +0000 (UTC)
Message-ID: <373e80ec-de22-4486-afdf-1a88f6207b9f@redhat.com>
Date: Wed, 11 Nov 2026 12:01:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] dpll: convert dpll_lock to rwsem
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
References: <20261106121005.1327603-6-ivecera@redhat.com>
 <179433320479.994134.13826920591104367019@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320479.994134.13826920591104367019@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: GepT0_gPkrMhFrBuqVtkgeI8gI-JMNv3k2D9vuZRng0_1794394884
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

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] This patch turns dpll_lock from a mutex into an rwsem.
> 
> --
> 
> dpll: convert dpll_lock to rwsem
> 
> This commit converts dpll_lock from a mutex to an rwsem. Core functions
> that change the topology take it for write. Netlink requests, dump parts
> and change notifications take it for read, so callbacks of different
> domains can run concurrently.
> 
>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> index dd09f52817099..8eb7468234315 100644
>> --- a/drivers/dpll/dpll_core.c
>> +++ b/drivers/dpll/dpll_core.c
>> @@ -19,8 +19,12 @@
>>   #include "dpll_core.h"
>>   #include "dpll_netlink.h"
>>   
>> -/* Mutex lock to protect DPLL subsystem devices and pins */
>> -DEFINE_MUTEX(dpll_lock);
>> +/* Protects the topology and lifetime of DPLL devices and pins. Taken for write
>> + * to change them and for read for the whole netlink request, part of a dump or
>> + * change notification that uses them. Driver callbacks are serialized by domain
>> + * locks, which are only taken under this lock.
>> + */
>> +DECLARE_RWSEM(dpll_lock);
> 
> [Severity: Low]
> Should the assertions in dpll_domain_get() and dpll_domain_put() be changed
> to lockdep_assert_held_write() along with this conversion?

[...]
> call_dpll_notifiers() can keep the plain lockdep_assert_held(), because it
> legitimately runs under the read lock.
Yes, v2 uses lockdep_assert_held_write() in both and keeps
lockdep_assert_held() in call_dpll_notifiers().

Thanks,
Ivan

