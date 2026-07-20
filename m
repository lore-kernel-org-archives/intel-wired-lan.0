Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89970C44520
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 11:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3357B606D0;
	Mon, 20 Jul 2026 11:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyzB8e1pNC4a; Mon, 20 Jul 2026 11:37:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58ED960668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784547425;
	bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWaldAhCic7tQ/ZHrSrkBmVEePDACowsGMa5lvhaUqJyKSlh/59dD/3XOBB4VUEUG
	 llbb6oABka/jlBNfsxqX9EpJOiQi8Yk4AkWAp34ERGoquU2/PJGRBHVDz4RsDJ458U
	 4OsElMrxeQemZRXWRMuI2VJ3xXC8e+93pUU264jY9oU03ky/84WK9UNoASGQCl1o8f
	 dODPLUkt0cJGscSmn8/QCCOXxN+tXj43OUZg0/jFWZDHkFCpvxYjHFe5NbwdwA/rj8
	 aLnfiCYWVw13gMXEGNAhtA0eR7J+8pMQfPg8XO2dmiePeUMvqhkZShLzCYoPetVkUj
	 6rxNfO9CoZ5jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58ED960668;
	Mon, 20 Jul 2026 11:37:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AAAA282
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E48A880B15
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8Vz7jVJ9J7h for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 11:37:03 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA35880AC2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA35880AC2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA35880AC2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:37:02 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-5mI0dekzPq-RiRbv7_HLOA-1; Mon, 20 Jul 2026 07:36:59 -0400
X-MC-Unique: 5mI0dekzPq-RiRbv7_HLOA-1
X-Mimecast-MFC-AGG-ID: 5mI0dekzPq-RiRbv7_HLOA_1784547419
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955ce558d8so10588755e9.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 04:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784547418; x=1785152218;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
 b=jS4pvkYq7T6oZbtu9ch/oQKxRW8RhuQ7/7vajiOAhPkZ+ZlxNE80tBgk7PL8xaUQrf
 S3AvRXfkWLylt7ef068sT/e7zGab53ivo94D8fd6Io//AuNYETNnpyk0dcUlpI/syqBC
 ZHWWeyGRQLlPx3ap449IwOnVfS/jXPZtNSOCzMaLex0g3u/slcmJHQ8qvnBnxxCfnUwO
 GPtKIDEX5+rqjAqgyl/H/B5qb/ZzfoJOtIlEV1H9TcfswXwJFrVDe9VtWdOGv5uEM2Pr
 edC58/vOWVWx2lDtHabNIuGXbLnDYdWCuexkZdATpGB7H+e7dn582zskproVQb7BAtmb
 VcNw==
X-Gm-Message-State: AOJu0YyDsQmSY5QkOU/z5OvPeaNmYoHFtlUZGnvtbLOXtt2XdzgGIj4D
 +nfzkmsHTXGoB0TqbTeAppULMhcCNZjOdTPKG+jcqWQOZByly+6dFsmarI/yIUEiAKNLBtnV+B8
 VGrR8ZQ6xxxexgVpph/KArPCAZYqlM+AlpAlsMdC2KLHJO4JFAqpRxlGjzjclEUX3THyEYJ0=
X-Gm-Gg: AfdE7cnRUXwZGz8DubGnmXq5gZiGJJGAB52WoAaDJWn0Tp9zF3vRuWhL1OM9VsTo9Wd
 4QmahsOwGEFtX/NoAJ4n3NprDNSKghpgSMkOGGlVgLQmRykBd47Q0704M9mrNEXw3zCcZipSOWs
 lYtDbEvj0YeA3C3iPSd3q9mQAz2sM10nGue/ifm2iJlmQyGs9r+uQz0+aD88zRD4lbdl+7JZsOe
 uad5wpk4ap+E+SJHZ7DXZ4jsPBi4DojfUZbfx8v2coqjwaj00t+SoZ65Ky/u0DTb860Ee3QlFaH
 YgGG681IfYTnQBYdSFnwJ4+CEBMAjGYcOZx3oAsGPIl+9+nOscm5kt4ronQrPcDzgtZ4tnfpu0O
 vqVC6Degtk79J
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4954a3e6e29mr160745755e9.5.1784547418435; 
 Mon, 20 Jul 2026 04:36:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4954a3e6e29mr160745305e9.5.1784547418036; 
 Mon, 20 Jul 2026 04:36:58 -0700 (PDT)
Received: from [192.168.68.125] ([216.128.14.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955fee64dasm57750365e9.10.2026.07.20.04.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:36:57 -0700 (PDT)
Message-ID: <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>
Date: Mon, 20 Jul 2026 14:36:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch
References: <20260701093830.948756-1-mheib@redhat.com>
 <20260708143601.1491656-1-horms@kernel.org>
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20260708143601.1491656-1-horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OsKCncSvYAvNHxg5rGExH2jJY2nGb723rPzU6te0GfU_1784547419
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784547421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
 b=dMgx/RDf6W/GB5Vx43DNpF+mXTxzN0QNdOGbfI5nPezpu1iWzS20gholV6eKayw423BYUy
 EjSIA6GFfzHud2nvOHodj92K7OmEmIzsHA59zdA1R3RBqdMQ+15/4o9+MtXHyqIaNVRbC0
 020L/OUwc86+kfQYipawAX0J26poiJ4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMgx/RDf
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] i40e: move ATR sample
 rate from ring to PF level
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Simon
Thank you for the review.

On 7/8/26 5:36 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> i40e: move ATR sample rate from ring to PF level
> 
> This commit moves the ATR sample rate configuration from the per-ring level
> to the PF level. It initializes the sample rate globally during software init
> and updates the fast path to reference the PF structure.
> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index a04683004a567..4d4d4b07a0f3a 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> [ ... ]
>> @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>>   		ring->xsk_pool = i40e_xsk_pool(ring);
>>   
>>   	/* some ATR related tx ring init */
>> -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
>> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
>> -		ring->atr_count = 0;
>> -	} else {
>> -		ring->atr_sample_rate = 0;
>> -	}
>> +	ring->atr_count = 0;
> 
> [Severity: High]
> Does removing this per-ring initialization remove the protection against
> dynamic ethtool flag toggles?
> 
> Previously, if the ring was configured while Flow Director ATR was disabled,
> the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
> prevented descriptor injection even if the PF flag was later toggled on
> without a ring reset.
> 

The per-ring zeroing of atr_sample_rate was redundant. i40e_atr() 
already checks I40E_FLAG_FD_ATR_ENA before it ever looks at atr_sample_rate:

  /* make sure ATR is enabled */
   if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
       return;

   if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
       return;

   /* if sampling is disabled do nothing */
   if (!pf->atr_sample_rate)
       return;


When ATR is disabled via ethtool private flags, the function bails out 
at the I40E_FLAG_FD_ATR_ENA check regardless of what atr_sample_rate is 
set to. The flag check is the real protection the per-ring sample rate 
cache was never the thing providing protection against dynamic toggling.


> [ ... ]
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> index 894f2d06d39d0..b36e0fc9b31d2 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> [ ... ]
>> @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>>   		return;
>>   
>>   	/* if sampling is disabled do nothing */
>> -	if (!tx_ring->atr_sample_rate)
>> +	if (!pf->atr_sample_rate)
>>   		return;
> 
> [Severity: High]
> Can this global check lead to a hardware Malicious Driver Detection (MDD)
> event if ethtool flags are modified dynamically?
> 
> If an administrator performs the following sequence:
> 
> 1. Disables flow-director-atr via ethtool.
> 2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
> 3. Re-enables flow-director-atr.
> 
> The final step does not trigger a ring reset, so fd_ena remains 0 in the
> hardware queue context.
> 
> However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
> globally set to a non-zero value.
> 
> Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
> that is not configured for FDIR?
> 
> If so, does this cause the hardware to trigger an MDD event and hang the
> TX queue?
> 
The scenario you described was already broken before this patch, walking 
through the old code with the same sequence:

   1. Disable ATR — flag cleared, __I40E_FD_ATR_AUTO_DISABLED set
   2. Disable ntuple — ring reset happens, i40e_configure_tx_ring() runs 
with ATR off, so ring->atr_sample_rate = 0 and fd_ena = 0
   3. Re-enable ATR — flag set, no ring reset

In the old code, ring->atr_sample_rate is stuck at 0 from step 2, so 
i40e_atr() bails out at the sample rate check. That avoids the fd_ena 
problem, but ATR is also silently non-functional
   — the user re-enabled it but it doesn't actually work until something 
triggers a ring reset.

This patch changes how that failure looks, instead of silently doing 
nothing, pf->atr_sample_rate is non-zero so i40e_atr() would proceed 
but the root cause is the same:
toggling ATR via ethtool private flags doesn't trigger a ring reset, so 
fd_ena can be stale.

Properly fixing this would mean triggering a reset when ATR is 
re-enabled. The reset calls i40e_configure_tx_ring(), which re-evaluates 
fd_ena based on the current flag state so fd_ena would be set to 1 since 
I40E_FLAG_FD_ATR_ENA is now on.

What do you think about addressing this as a follow-up patch on top of 
this series? Since it's a pre-existing issue, it feels like it belongs 
as a separate fix rather than being mixed into this refactor.


