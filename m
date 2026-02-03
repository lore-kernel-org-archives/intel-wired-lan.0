Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5337AE8784A
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 17:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC946060C;
	Tue,  3 Feb 2026 17:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBn6uQFhZWHc; Tue,  3 Feb 2026 17:08:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19D7E605A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770138512;
	bh=1RcqX9khIwUR/91ez7NLW9xW23Ib+VX9iSsMAWPU9Og=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kTp7H5TZKzckLL+VnNEkOjeupgGdP+CaWJ3LkRuTAVAVopxRpLisSAHHPos5akVdI
	 YNNw0FhDWpdm82fxGa/erjp9Dh1Pt9OlBlwCg/Sfz2xPIcEPS/254Bvi38YhYeQpwu
	 SoRbtUXiGvqsE317nBthEe+U2G+NFlSCcURh0G+kER67wGs4uGG3uKWniW9zR/cMSf
	 j57hhhPKQuXx1WEGrrlXMfQ6XrTyEaEFO37trmLVcD4hjHty/4fkrd/ghZN6d1Q6HK
	 +u9hTXrh6vh6pM8IMKfp90jSaoxtwxIuX+VAXs4ByKeYsitSJ7gRzOsKXaW775Gfb6
	 /GuSOJHI4KWew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19D7E605A9;
	Tue,  3 Feb 2026 17:08:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC5A7F4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 17:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB26B402EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 17:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoYEQeD27RQc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 17:08:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 89F1E40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89F1E40025
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89F1E40025
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 17:08:28 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-VFWEBYhiOHOgNIjn6uCsUQ-1; Tue,
 03 Feb 2026 12:08:23 -0500
X-MC-Unique: VFWEBYhiOHOgNIjn6uCsUQ-1
X-Mimecast-MFC-AGG-ID: VFWEBYhiOHOgNIjn6uCsUQ_1770138499
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE2491956068; Tue,  3 Feb 2026 17:08:18 +0000 (UTC)
Received: from [10.45.224.28] (unknown [10.45.224.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0994F1956048; Tue,  3 Feb 2026 17:08:11 +0000 (UTC)
Message-ID: <fe7f81a4-281b-473b-8d0b-d04ff042d471@redhat.com>
Date: Tue, 3 Feb 2026 18:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
References: <20260202171638.17427-8-ivecera@redhat.com>
 <20260203161102.1894146-1-horms@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260203161102.1894146-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1770138507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RcqX9khIwUR/91ez7NLW9xW23Ib+VX9iSsMAWPU9Og=;
 b=Rfchg3Dp/4tERB0kZPp6QB+4HAmEnoRCBvPqh24ceAIpRuQ8bKa0vo/F/gKvzBuDnoJpve
 0VwwP03A2FjiBo3Lsrh6SQjt98OKszwCrT+FEKO2mo2dL7AES1Dy16N3hf0ieT9/oyN/ie
 Xy5BZxkOtCj6LnH8Bf3SczWJfZvd3DA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Rfchg3Dp
Subject: Re: [Intel-wired-lan] [net-next, v4,
 7/9] dpll: Add reference count tracking support
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: edumazet@google.com, anthony.l.nguyen@intel.com, leon@kernel.org,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, richardcochran@gmail.com,
 Prathosh.Satish@microchip.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, mbloch@nvidia.com, linux-kernel@vger.kernel.org,
 tariqt@nvidia.com, aleksander.lobakin@intel.com, jonathan.lemon@gmail.com,
 saeedm@nvidia.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 2/3/26 5:11 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dpll: Add reference count tracking support
> 
> This commit adds REF_TRACKER infrastructure support to the DPLL subsystem,
> allowing developers to track and debug reference counting leaks for
> dpll_device and dpll_pin objects via debugfs.
> 
>> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>> --- a/include/linux/dpll.h
>> +++ b/include/linux/dpll.h
> 
> [ ... ]
> 
>> @@ -223,16 +231,17 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
>>   }
>>
>>   static inline struct dpll_pin *
>> -fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>> +fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
>>   {
>>   	return NULL;
>>   }
> 
> There appears to be a stray semicolon at the end of the function signature
> on the line with the tracker parameter. This would cause a compile error
> when CONFIG_DPLL is disabled since the function body follows what looks
> like a forward declaration.
> 
> Should the semicolon be removed so the stub function compiles correctly?

Definitely. Will fix as I mentioned previously.

Thanks,
Ivan

