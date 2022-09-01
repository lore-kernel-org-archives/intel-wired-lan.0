Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD16ECAAD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Sep 2022 12:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D479823DD;
	Thu,  1 Sep 2022 12:35:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D479823DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1662035737;
	bh=ouTFFQMaTFcwpPmM+2ZzCq9KfPM9idTqwUr06jI74b0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=0/a42I19E6v+4QQE2yNNz8r0oEWG7mYT2TL/s7hvoWcfVlKFHE3tKXv5BWq6pAh5t
	 lk0kW+qCSj+SmEUx+InoyqcEVvnNOCHo+lvJCOJCDch0wQbk2DdHohdIW47QpdIXyx
	 VcaknigtVKtHPlCFoHgw5wUqYNqBPCCXS2f0ClNTjPbUDDuNIWvGg2xjvr9rICjIVV
	 qy5nGlPbp6wAx8IUYMawKKJW/4xrl+MdjAhaZVp/YIhkQ7ilFbSp5vKPGEp9BJV8nx
	 WBr3Tg0w/3+qDVy12XBVjW07UnoLHM2Mv25WDIcumdFQh3deJQpdxOxmxQBfCi28gw
	 szt4ncUi4+q7w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvQjBsc3r7aS; Thu,  1 Sep 2022 12:35:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8ACA826BF;
	Thu,  1 Sep 2022 12:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8ACA826BF
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 4D9141BF338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Sep 2022 12:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24829826BF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Sep 2022 12:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24829826BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bYP9uU_vKL_V for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Sep 2022 12:35:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D0A6823DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D0A6823DD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Sep 2022 12:35:34 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-zrMXhqQyMuSFiWNVlDBt7Q-1; Thu, 01 Sep 2022 08:35:31 -0400
X-MC-Unique: zrMXhqQyMuSFiWNVlDBt7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 m22-20020a7bca56000000b003a652939bd1so749814wml.9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 01 Sep 2022 05:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=yDej3L3EBFcquZyEQEc+a5RUlj6LMW4FI5qypeLF5Ro=;
 b=1lHGkkHHAUSVRG7xRF+Gsh7f5QCmQ719oIobF3N17Wn69VnewJAwAfEhu6p0QVVIq5
 GOmLrKLeP4PD9db5cOYF1x+f/VAk24+1ZS4eefRFT0J93iqaGjHST58jmbdr5IwEUU2l
 DmhWfxTQxc/2iHinLwb8ShaIVuTW6Uzg4JPk3XqBdAgIJMGov0yAidDcn3qaN70q90pb
 Fr0rPiJgL2/W4k1HrGvR7h0/fkKgw965N5GpXvwzlBRpNY5Kdwy7nzuYzp7ynQYW7d9A
 ZhOJa5iEUztPyutOxQQemEZCFxeWYSTyxOen8mUjBz1XBSSW2k89KZ2KxOyL9BL2lbXg
 KApA==
X-Gm-Message-State: ACgBeo2uhLRWG4u3cVKxFgAvHUGcPrtn2DVj0XC0CMCKFFQV0224tvbp
 L3xqX3Zijiq42xsBXrvZbWiqNQ4eg90IHNEtJMaio5WvXfTdwlDcdRH9ZdxTldpXeB0W25Lkqlb
 DUFRABZCWRZJdtRo9f59doR08ky7pOw==
X-Received: by 2002:a05:6000:1f0c:b0:226:f3f3:9929 with SMTP id
 bv12-20020a0560001f0c00b00226f3f39929mr2138919wrb.362.1662035730805; 
 Thu, 01 Sep 2022 05:35:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Qn3VLevJs4PCzhQuaYamKPXouY8mPpkSXkDpdoVfr2pH2/yCqlIePiC8CdVndbpV39DeiKg==
X-Received: by 2002:a05:6000:1f0c:b0:226:f3f3:9929 with SMTP id
 bv12-20020a0560001f0c00b00226f3f39929mr2138883wrb.362.1662035730510; 
 Thu, 01 Sep 2022 05:35:30 -0700 (PDT)
Received: from debian.home
 (2a01cb058d71f600677dd509c7265258.ipv6.abo.wanadoo.fr.
 [2a01:cb05:8d71:f600:677d:d509:c726:5258])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1c5448000000b003a63a3b55c3sm5794948wmi.14.2022.09.01.05.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Sep 2022 05:35:30 -0700 (PDT)
Date: Thu, 1 Sep 2022 14:35:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20220901123527.GA3398@debian.home>
References: <20220901120131.1373568-1-wojciech.drewek@intel.com>
 <20220901120131.1373568-3-wojciech.drewek@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220901120131.1373568-3-wojciech.drewek@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1662035732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDej3L3EBFcquZyEQEc+a5RUlj6LMW4FI5qypeLF5Ro=;
 b=SHBEw5jE0QDtCBXl65XhdRATLUwntlEg7KOWEJJs0zzFgzzogH4IbdrieeSidF283nEZ6/
 +F5QUezIFq3yNn5Fmyqg5wPhDFIIbFFkdTtWhTCVgd95TtEWuLGdEbxwHSEJOM+TfPiUEj
 hWALiBxKoBDgTRugOWMzyOwMtnI8LoQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SHBEw5jE
Subject: Re: [Intel-wired-lan] [RFC PATCH net-next v3 2/5] flow_dissector:
 Add L2TPv3 dissectors
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: simon.horman@corigine.com, kurt@linutronix.de, komachi.yoshiki@gmail.com,
 jchapman@katalix.com, edumazet@google.com, boris.sukholitko@broadcom.com,
 louis.peens@corigine.com, intel-wired-lan@lists.osuosl.org, vladbu@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 baowen.zheng@corigine.com, maksym.glubokiy@plvision.eu, jiri@resnulli.us,
 paulb@nvidia.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Sep 01, 2022 at 02:01:28PM +0200, Wojciech Drewek wrote:
> Allow to dissect L2TPv3 specific field which is:
> - session ID (32 bits)
> 
> L2TPv3 might be transported over IP or over UDP,
> this ipmplementation is only about L2TPv3 over IP.
> IP protocold carries L2TPv3 when ip_proto is

Nit: you didn't fix the spelling of "protocold". It's probably not
worth to send a new version just because of this typo though.

> Acked-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v3: move !dissector_uses_key() check before calling
>     __skb_header_pointer
> ---
>  include/net/flow_dissector.h |  9 +++++++++
>  net/core/flow_dissector.c    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 6c74812d64b2..5ccf52ef8809 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -289,6 +289,14 @@ struct flow_dissector_key_pppoe {
>  	__be16 type;
>  };
>  
> +/**
> + * struct flow_dissector_key_l2tpv3:
> + * @session_id: identifier for a l2tp session
> + */
> +struct flow_dissector_key_l2tpv3 {
> +	__be32 session_id;
> +};
> +
>  enum flow_dissector_key_id {
>  	FLOW_DISSECTOR_KEY_CONTROL, /* struct flow_dissector_key_control */
>  	FLOW_DISSECTOR_KEY_BASIC, /* struct flow_dissector_key_basic */
> @@ -320,6 +328,7 @@ enum flow_dissector_key_id {
>  	FLOW_DISSECTOR_KEY_HASH, /* struct flow_dissector_key_hash */
>  	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct flow_dissector_key_num_of_vlans */
>  	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe */
> +	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
>  
>  	FLOW_DISSECTOR_KEY_MAX,
>  };
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 764c4cb3fe8f..8180e65ab8e2 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -204,6 +204,30 @@ static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
>  	skb_flow_get_icmp_tci(skb, key_icmp, data, thoff, hlen);
>  }
>  
> +static void __skb_flow_dissect_l2tpv3(const struct sk_buff *skb,
> +				      struct flow_dissector *flow_dissector,
> +				      void *target_container, const void *data,
> +				      int nhoff, int hlen)
> +{
> +	struct flow_dissector_key_l2tpv3 *key_l2tpv3;
> +	struct {
> +		__be32 session_id;
> +	} *hdr, _hdr;
> +
> +	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_L2TPV3))
> +		return;
> +
> +	hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
> +	if (!hdr)
> +		return;
> +
> +	key_l2tpv3 = skb_flow_dissector_target(flow_dissector,
> +					       FLOW_DISSECTOR_KEY_L2TPV3,
> +					       target_container);
> +
> +	key_l2tpv3->session_id = hdr->session_id;
> +}
> +
>  void skb_flow_dissect_meta(const struct sk_buff *skb,
>  			   struct flow_dissector *flow_dissector,
>  			   void *target_container)
> @@ -1497,6 +1521,10 @@ bool __skb_flow_dissect(const struct net *net,
>  		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
>  					data, nhoff, hlen);
>  		break;
> +	case IPPROTO_L2TP:
> +		__skb_flow_dissect_l2tpv3(skb, flow_dissector, target_container,
> +					  data, nhoff, hlen);
> +		break;
>  
>  	default:
>  		break;
> -- 
> 2.31.1
> 

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
