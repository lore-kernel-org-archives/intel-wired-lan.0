Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540FDF531E3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 09:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41DE760747;
	Wed, 15 Apr 2026 09:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Szsfl1VUKuv; Wed, 15 Apr 2026 09:04:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACD4A600CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776243894;
	bh=HG5r9CsXm++J30U6+pXxtyB6ti3k7GWkSFNgjgKK4uk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJS83WLF+0Ih7AmgjNUskKnkZ4M/qQFnmzJC9t+ZCo3diSUjYh6ULOcpBlGRhI+As
	 Egz1fw5nNUfW4+tBAlo2+2FnKQ7oCIfVcO6OxwLWQkgg+09RLY3HGrIL8TtYG+0Aa7
	 BLdSlMWVEInft+Crq99CutE9h+7QLcVXyQii36fo96OFf39+S2oaFJ2WMEQF0hKT2F
	 LLU5MYxVrbpUNxC+e+OWu3HXdPiscGHBG8h16GhA3tlNVIxBwORoM3wVuodRselzEk
	 GxK8oaoWuvDUjtO/0OcOTJeZ3+zBhoNe6VXQKtvtyYF9E9GBqOtrIeYRnbIttYAqCS
	 f2fxEN2KC6+Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACD4A600CA;
	Wed, 15 Apr 2026 09:04:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB483375
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 09:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3C6C6F6A0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 09:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7D9tlbTyuCXP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 09:04:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A46E960747
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A46E960747
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A46E960747
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 09:04:50 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-JV9eXoeyNfyRSc4kgjfAig-1; Wed,
 15 Apr 2026 05:04:45 -0400
X-MC-Unique: JV9eXoeyNfyRSc4kgjfAig-1
X-Mimecast-MFC-AGG-ID: JV9eXoeyNfyRSc4kgjfAig_1776243884
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9CC19560AD; Wed, 15 Apr 2026 09:04:43 +0000 (UTC)
Received: from [10.44.33.94] (unknown [10.44.33.94])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CE7B1800446; Wed, 15 Apr 2026 09:04:39 +0000 (UTC)
Message-ID: <94692bc9-fe8a-4d78-967f-f2d2db7aa3a6@redhat.com>
Date: Wed, 15 Apr 2026 11:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260409102501.1447628-1-poros@redhat.com>
 <68b5cc9d-81d2-4ff5-9d3e-a6d6746dcb3e@redhat.com>
 <b40362c7-a749-4915-93a9-08243ab09cb8@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <b40362c7-a749-4915-93a9-08243ab09cb8@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: gMBMp3duvjNd3_joC01XbciY7CQB-u8FIz_wLlvht5U_1776243884
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776243889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HG5r9CsXm++J30U6+pXxtyB6ti3k7GWkSFNgjgKK4uk=;
 b=HYMs2//w7zE33FoeRn+g3qQe70TiaaCDBlUO+b/lORsbJekwrIxzrC0c6QkQpvlEhTVJSC
 jKPDMW/IucwivqayXA2fEstKzscWJ2kenXre/uyZtdeOoNk9roiDnQqf7hei3PAZClpVf3
 HNYu6viZRZ3xDVBv8jE38dLj6CMKCa8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYMs2//w
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] ice: fix missing dpll
 notifications for SW pins
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

On 4/14/26 10:46 PM, Jacob Keller wrote:
> On 4/14/2026 12:16 PM, Michal Schmidt wrote:
>> On 4/9/26 12:25, Petr Oros wrote:
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_dpll.c | 74 +++++++++++++++++++----
>>>    1 file changed, 63 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/
>>> ethernet/intel/ice/ice_dpll.c
>>> index 3f8cd5b8298b57..d817f17dcf1951 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>> @@ -1154,6 +1154,30 @@ ice_dpll_input_state_get(const struct dpll_pin
>>> *pin, void *pin_priv,
>>>                          extack, ICE_DPLL_PIN_TYPE_INPUT);
>>>    }
>>>    +/**
>>> + * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a
>>> state change
>>> + * @d: pointer to dplls struct
>>> + * @changed: the SW pin that was explicitly changed (already notified
>>> by dpll core)
>>> + *
>>> + * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1
>>> and
>>> + * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
>>> + * expander, the paired pin's state may also change.  Send a change
>>> + * notification for the peer pin so userspace consumers monitoring the
>>> + * peer via dpll netlink learn about the update.
>>> + *
>>> + * Context: Can be called under pf->dplls.lock, dpll_pin_change_ntf()
>>> is safe.
>>> + */
>>> +static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>>> +                    struct ice_dpll_pin *changed)
>>> +{
>>> +    struct ice_dpll_pin *peer;
>>> +
>>> +    peer = (changed >= d->sma && changed < d->sma +
>>> ICE_DPLL_PIN_SW_NUM) ?
>>> +        &d->ufl[changed->idx] : &d->sma[changed->idx];
>>> +    if (peer->pin)
>>> +        dpll_pin_change_ntf(peer->pin);
>>> +}
>>> +
>>>    /**
>>>     * ice_dpll_sma_direction_set - set direction of SMA pin
>>>     * @p: pointer to a pin
>>> @@ -1233,6 +1257,8 @@ static int ice_dpll_sma_direction_set(struct
>>> ice_dpll_pin *p,
>>>                ret = ice_dpll_pin_state_update(p->pf, target,
>>>                                type, extack);
>>>        }
>>> +    if (!ret)
>>> +        ice_dpll_sw_pin_notify_peer(d, p);
>>>          return ret;
>>>    }
>>
>> ice_dpll_sma_direction_set() runs to process a DPLL_CMD_PIN_SET command
>> from userspace. It runs with dpll_lock held - taken in dpll_pin_pre_doit().
>> ice_dpll_sw_pin_notify_peer() -> dpll_pin_change_ntf() will take
>> dpll_lock again and deadlock.
>>
> 
> Yep. I think you could use __dpll_pin_change_ntf() which is the version
> that assumes the lock is held.. but that function is not exported
> outside of drivers/dpll.
> 
> Either way, this needs to be fixed somehow before I can apply it.
> 
> Thanks,
> Jake

I'm solving the similar situation where some setting on some output pin
can change also sibling pin.

E.g. changing frequency on OUTxP also changes frequency on OUTxN in
certain situations (depending on signal format of the output)...

In such cases would be useful to inform about such change on sibling
pin.

Thanks,
Ivan

