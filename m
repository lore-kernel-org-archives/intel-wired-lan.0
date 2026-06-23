Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E17CDB46F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jun 2026 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8508840910;
	Tue, 23 Jun 2026 10:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G849-H0KY-Rc; Tue, 23 Jun 2026 10:57:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B26A540981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782212273;
	bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pPUZ11X9SAli69EPYZ6gBdKwWKk79uxIYJNfiM0iLkYeukaRKhgNcMgkImMIAXsvo
	 sryRlODhkwvpIorD6Oz20e/U/bbmOLcc4ABN1ibq3pJ//AbTppk/tgqfN+tx3v5TQ1
	 L824m/5JkqjtlybRQm+EWo9SVbfCGdXx2av9gd9T9h9fH/C+Ea19gBU/yAIWeO0wXI
	 DmpB1R/FHQ5oOZcEMRbhX/5eOlNUPibPhcr96/Unz5BL1XSWInLmHsBp3DNkLf9pvH
	 fegX3ar6GHZ3BoCG6P5ndKvk0Imku6bHGhuMogSyMEyjf13DEmhPeiCsb8ueOR1vJa
	 pMRU0k04kZTYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B26A540981;
	Tue, 23 Jun 2026 10:57:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA64367
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2AE94027F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:57:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0RKlBPsIOSaO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jun 2026 10:57:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 95CA040252
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95CA040252
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95CA040252
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:57:50 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-DPkL3pDOOD-DUohD3hDXtg-1; Tue, 23 Jun 2026 06:57:46 -0400
X-MC-Unique: DPkL3pDOOD-DUohD3hDXtg-1
X-Mimecast-MFC-AGG-ID: DPkL3pDOOD-DUohD3hDXtg_1782212265
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4621b17733cso2798207f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 03:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212265; x=1782817065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
 b=VXV3U04n90Ujh+ITn7/ekvZ0dDcmdbHv9HUOHxdxqCWK3dwcq8E5Oz4y8GQhmZ0zkX
 NuOxaw+SehLCP+SHVFmdLaPMmImlUdAWCS7XJhUaRuy8/wRLP2qJYw0NoEbYUqPTD7ZS
 FFjY8FiDshNRr8RpOU6mCtYA7/EDOJa7FUonOKbczOZqfBkDAaNfL9KzyQfvtJE+erFn
 ucQZHSzeIcjMrI4HQ6WnUdWMxgRhkAZ5F1czHxfP+ZDH4GgZFrTOGuqvCW7IV94cowGe
 XHUbuWcIYAYQohexXSyknmh7pZX/2u4lvyk/QBspzrX2s4H8fhzCBgWCkl9kJ3+/Pp1r
 Wv2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ85f9sXhxlwFwzMQy2of8Yu5XlCzfWxM54y0Rciz9ZzrviydZ/5h7seHsLNHMyemkRwhfHcHhlyqQL2vX5neCk=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzDbx3cZax8YRBlKvkYuKefXpR/f47C8l6G1fN7QeemjgdQwnon
 sz3UHpwkzV8jW2CVOK0gLlf2TVW1uAMWhpyLlvf1p0rSmjeyFBqWfx3hQ0UhBjx3hk8PWfHDEcl
 xx4j+vFu/ZWhwflz6gAUZQITtUgLT8R0vdP6w3/wKs75r7CHRb3Uh3r3hbe4rNK3ihqnd97k=
X-Gm-Gg: AfdE7cm39eU4Q3MtIp8ojWbUo5EDKlKQqfxaF+bLsNiojOF/2rbb3FWagK3u7FhAKXH
 GLxSsHZWJNFIKgRkhsS3L/ZvNccbVuqJovmKZX6BtZEN0sBe5CprzN/wrHhnWZaPlqYhVjTfURl
 WAgHLE8EgtrJ5i2lBY+/bA+z5IVRHnWU2hvgmjMRFxlHa4y9DmTPgYRUVOTpPfyFgqk8E42RGbp
 XTcGQaKbq8IAP3voE6Yd622sLhjKUivNLudERN2bJVtfBH3fbFHmveQBW1Zupyly1mw4+k/BIKK
 KzrCrz9QsRY9KzU9JpGhFGUEZbSejIm9amIQrZKajyIF++F8NE5cZsWi6clRdmPgoz9MC4PWcw=
 =
X-Received: by 2002:a05:600c:e558:10b0:490:bcc1:4edb with SMTP id
 5b1f17b1804b1-49240e95442mr204023945e9.27.1782212265020; 
 Tue, 23 Jun 2026 03:57:45 -0700 (PDT)
X-Received: by 2002:a05:600c:e558:10b0:490:bcc1:4edb with SMTP id
 5b1f17b1804b1-49240e95442mr204023585e9.27.1782212264580; 
 Tue, 23 Jun 2026 03:57:44 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496cdsm260372885e9.10.2026.06.23.03.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 03:57:43 -0700 (PDT)
Message-ID: <987aa5d0-9ca8-4038-b77f-94adba497e40@redhat.com>
Date: Tue, 23 Jun 2026 12:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260622081030.2312129-1-poros@redhat.com>
 <20260623102934.1072800-1-horms@kernel.org>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260623102934.1072800-1-horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tfCqFVqzO7UqVeLP12RtZu5GFxpKw_CKscv3BAXFtBA_1782212265
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1782212269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qdcx8pE/nw7N4Xhb05KzxoHXjXPkYTO5AuxwEAinnqw=;
 b=inS2tRJwY/DvzDm9CywpTPkYaBzFieTzQlcyoy1fodwlZInNvUtjgPB7o8I153K2rZv76/
 U3K2OOqIlVZzoqf8amoFtX2zvntBYHYLLGRcSMUPMAeHbdYSUBrYEgp2ZuJmeNsi3EawKP
 c5ROJXEwaR69EIafMmoRYMBEATVxWTI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=inS2tRJw
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: clear the default
 forwarding VSI rule when releasing a VSI
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


On 6/23/26 12:29, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: clear the default forwarding VSI rule when releasing a VSI
>
> This patch restores the cleanup of the default forwarding VSI rule
> in ice_vsi_release(), clearing it when the VSI owns it. This prevents
> a rule leak if a trusted VF enters promiscuous mode and is then destroyed.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>>   		return -ENODEV;
>>   	pf = vsi->back;
>>   
>> +	if (ice_is_vsi_dflt_vsi(vsi))
>> +		ice_clear_dflt_vsi(vsi);
>> +
> [Severity: High]
> Is there a time-of-check to time-of-use race here?
>
> ice_is_vsi_dflt_vsi() acquires and releases the filt_rule_lock to check if
> the current VSI is the default. If true, ice_clear_dflt_vsi() is called,
> which acquires the lock again during rule removal.
>
> If the lock is dropped between these two calls, could another thread
> establish a new default VSI rule before ice_clear_dflt_vsi() runs?
>
> When ice_clear_dflt_vsi() executes, it appears the rule search only matches
> by l_data and flag:
>
> ice_switch.c:ice_find_rule_entry() {
> 	if (!memcmp(&f_info->l_data, &list_itr->fltr_info.l_data,
> 		    sizeof(f_info->l_data)) &&
> 	    f_info->flag == list_itr->fltr_info.flag) {
>          ...
> }
>
> For the default VSI rule, l_data is empty, so it might match any newly
> established default rule.
>
> And since ice_remove_rule_internal() does not appear to validate the
> vsi_handle for non-list rules:
>
> ice_switch.c:ice_remove_rule_internal() {
> 	if (list_elem->fltr_info.fltr_act != ICE_FWD_TO_VSI_LIST) {
> 		remove_rule = true;
>          ...
> }
>
> Could this blindly remove the default forwarding configuration for a
> completely unrelated VSI?
  The dropped lock isn't new here. The whole dflt_vsi API is check-then-act.
  ice_vsi_sync_fltr() does the same if (ice_is_vsi_dflt_vsi(vsi))
  ice_clear_dflt_vsi(vsi), and this path runs under vf->cfg_lock, the same
  domain as the ice_vf_clear_all_promisc_modes() cleanup it restores. There
  is at most one DFLT rule per direction, because a second default VSI folds
  both into one ICE_FWD_TO_VSI_LIST, which is the leak this fixes, so the
  empty l_data match is unambiguous. In that list case removal honors the
  handle via ice_rem_update_vsi_list() and drops only the requested VSI. The
  unvalidated whole rule branch is only the single VSI case where that 
VSI is
  the sole default, so removing it is intended. An unrelated removal would
  require another context to clear this VSI and install a different sole
  default in the gap, but those flows are serialized per context with rtnl,
  vf->cfg_lock and ICE_CFG_BUSY.

Regards,

Petr


>>   	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>>   		ice_rss_clean(vsi);

