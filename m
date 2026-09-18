Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B196C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A7EF60E3E;
	Fri, 18 Sep 2026 13:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvqtxV0MOlLi; Fri, 18 Sep 2026 13:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 79E9A60E27
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789737670;
	b=sZYHQEuiMwTYuF84W4l9sjaANZNlfDxBrsL2aNAJ+2afS6ky4N0vy6thEFz5TgdbSPFQ
	 CZYtV5Jo5c1q1iztQ7rCdbu4OR7kOVNlzoBj+H5Z3L05BIEKmWAIbmBeV6duKCsZN1np7
	 d7zONwrm4amjc95IWWfmmHqMbjF5PtRLlaU/Kjs2XNxHgAyhlgyw9P1/Kfjb4OjCGIN4J
	 aReKBqlwzXkfByssBhpFgRtVhp5fILcjiala8erRY9QQvZ8fSeusouJHZDZJbd03e2Jif
	 X/UcbEHN8OwmL3HQhJg/ObxTbDij1TfayX5JDB1qTgdglSBPH5yXcAD83amJ0pF0QAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789737670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PKgGIwXVKzbhODDkHaOxHq3ff9BfKZv39Eom7kMyE+A=;
	b=hDiya8diY5i6tioXZVQxWDKD1D5/SUgI1pnuZ6ieyx2UoSAKrZkt0OqIo+ftviMV10zS
	 36SVcjKsRzpZ5wqLMOJ315Qis943P2syndoYdpO9S7knnC9na0A4pPEwmBrwXm5iYb0ye
	 VAj5E+N2iWdmLJOLc/AGldpbz/mESPcFTxYcc3cERkkUt5loKtZ0HTJBfjV4bFb2Wyg4E
	 53j2DrjdQkiHcwA4N/LLFON/iUx0SNhPFXA0wh4Cup1aJSufvUohLERunY+gsMxip6U0u
	 V36ZJxtHCINZq7qG1PTt0cTjvyXUIFxkC4RYScuVxRSQRPfPJ65ZGkKy4EcgT6IS7xA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789737670;
	bh=PKgGIwXVKzbhODDkHaOxHq3ff9BfKZv39Eom7kMyE+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJhlcBsCF0QtBk3js9CFwOr2wRk1VE3BcWiSt6xHm2Y3XmKVLIWjQ70TGRJK/hOMy
	 F+fjkIGH1okmwasAT/f+uwXQBVjmF6goPgJ8GX0dBmQNvayUym8rRgRIHnjtbh1icQ
	 InYW7FJKvk9BI5OUE/fvBXNtFGW5CmZNevoAd/6sfn+e4Mq/YBZFCecf5NYmWABIHm
	 nBuW9kkq0zkty/SdFIDXQW/saALGfCW5MSNIo7rHxFDTC0CK/7GGC6mNM7fv9VoP5D
	 mEbYcGg2eGEdq9Qx7uDQRi84Vy7QRf2n+3ATpjT4O6AyX7MFbXIic9lzfB3L9gsNzv
	 5Efu1Iaac92+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79E9A60E27;
	Fri, 18 Sep 2026 13:21:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3290029B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23FB140D5A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kn__9aPtIdim for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:21:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 33A0940D59
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789737668;
 b=g8gIj99lPjZHsYyU1yuSu6Y1kkclyjdyT/k4gzaWXuORoaWQ9FIA4Oet090Abg2d26bK
 A+Nx7ReB8o7jVd6sAXI3LYq5qPNHRkXDzSiP9JjB3+/UEJjMt5fGqcI8+LxBXGJVpqKPN
 Tv9ewTO3II6iTePpJCHQfr21X/oUzw8vxSUTjjOyFhIgPnu4Yb7xhUWmbPTY3UeS1vkUu
 lUL3jmgDRLaMRZU2VxZAOQ0EU9fERIUG+XA4bDk0xBhXKfECDFxb3YXuXXxOTCbSw2S/n
 LuIDseBvznu11bUROcw13Kbyi5KyXSCOGyx9EDBK88BJaMu7ei8K+JFoahK7214I6xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789737668;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=PKgGIwXVKzbhODDkHaOxHq3ff9BfKZv39Eom7kMyE+A=;
 b=rBHoVKybyKrV2iExqfn1VYsjhKojjj7ERw+jeFMX+YkAD4rTv1E48S+Jf2gf9HVXzfCK
 GVUaoNPYG+Z2A1ijxMNHIdiUHTL4z0XzzgcUPMlj3oCneRMxEdYm8Onw84RqFJxWAXtlY
 bdSCksPEdZgakcqGIUQ+GmjR709x++WjsKegWTGla5iOy5CiwNbTb0KiIbMsGUKSWzaBy
 6TsaQwt6RyygfYMlyJXc63XBnjOU6+IgP3Mx9QpTXEmYwaGGV1nJlrBXAGNEoJTLgF6GV
 DoN+o22MXtfearCHIYyR7cEwkOOUNUQ0KxbWHSqfEf6j03QLRMDvjpG4S9onkZraObA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="OY/LDeWu"; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OY/LDeWu
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33A0940D59
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789737668; x=1821273668;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IA2rsTc+PxLml4S/5TdF0FD6CQXNPkVFWayEW4455Wc=;
 b=OY/LDeWuotvhBaAhyVNNkVeKT2xy/6jeePdBFT05KcOg8Z+EilwPYQlw
 vb+MQhVhPnYwv7a65Oyu6t8o2WJvEw2jdqkqNDFwu4ir4DkfQQ6a2L2d7
 1k0+5S+KjqZhzH8GEq7OC7C4T7FS6H7daxl9gU7+dGqxd+B/kMnTIjtu0
 7cGB9YuhmZ0XBGGfauexJwbS1XR8rCRYRCo7bCtwRT/41ymO1izbxCNfI
 +nEd12hB8sfRvZY9tPw4s6Mm1V5EcQpqTaBkodAauPLzvWPczjgor2lRC
 pr3TMNBRc5dsh6DMk9fBuKBy1L9AKfG/iVRX4sZPvp/W3r0PB7IzIt8e6 g==;
X-CSE-ConnectionGUID: yrB6UVqxQFKb7Z62Vavssw==
X-CSE-MsgGUID: e6uUDoFRSO+MlT7zeByTig==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="107745373"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="107745373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:21:07 -0700
X-CSE-ConnectionGUID: dLkaI1PsRLO+pPt4TQgJ4w==
X-CSE-MsgGUID: HVtyOs/lQoiW5s7Tm2LZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="268144043"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:21:07 -0700
Received: from [10.246.40.5] (unknown [10.246.40.5])
 by linux.intel.com (Postfix) with ESMTP id EFDB020B5708;
 Fri, 18 Sep 2026 06:21:04 -0700 (PDT)
Message-ID: <f8e03883-d596-409e-ac17-f7e78ea8575b@linux.intel.com>
Date: Fri, 18 Sep 2026 15:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
 <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 17.09.2026 11:43, Aleksandr Loktionov wrote:

> @@ -220,12 +238,28 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>  	struct ice_pf *pf = priv->pf;
>  	struct ice_hw *hw = &pf->hw;
>  	size_t length;
> +	u8 comp_bit;

Nit: initialize to u8 comp_bit = 0; - harmless as-is since the default: path returns early, but it silences static-analysis warnings about a variable set only inside a switch.

>  	int status;
>  
>  	switch (component->identifier) {
>  	case NVM_COMP_ID_OROM:
> +		comp_bit = ICE_FWU_COMP_OROM;
> +		break;
>  	case NVM_COMP_ID_NVM:
> +		comp_bit = ICE_FWU_COMP_NVM;
> +		break;
>  	case NVM_COMP_ID_NETLIST:
> +		comp_bit = ICE_FWU_COMP_NETLIST;
> +		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
> +			dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
> +				component->identifier);
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Unable to update due to unknown firmware component");
> +			return -EOPNOTSUPP;
> +		}
> +		comp_bit = ICE_FWU_COMP_MANIFEST;
>  		break;
>  	default:
>  		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",



> @@ -676,6 +746,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  		return -EINVAL;
>  	}
>  
> +	/* ice_send_component_table() is called for every component in the
> +	 * PLDM image before pldmfw_flash_image() ever calls this function,
> +	 * so priv->seen_components is already fully populated by the time
> +	 * the first component reaches ice_flash_component().
> +	 */
> +	if (ice_has_erot_incomplete(priv)) {

This check runs on every call to ice_flash_component(), but pldmfw_ops guarantees all send_component_table() calls finish before any flash_component() call. Since transfer_flag on the last call to ice_send_component_table() carries PLDM_TRANSFER_FLAG_END, the completeness check could run exactly once there instead of being repeated for every component in ice_flash_component().

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
> +		return -EINVAL;

Commit message says "reject with -EPERM", but the code returns -EINVAL. Please align the commit message with the actual errno, or fix the errno if -EPERM was intended.

> +	}
>  	/* Mark this component for activating at the end */
>  	priv->activate_flags |= flag;
>  




Both patches are missing a proper Subject: line — the commit message starts directly with the body text, so git log --oneline shows the From: line instead of a subject, and there is no [PATCH net-next vN x/2] ice: ... tag prefix as listed in the cover letter's shortlog. Please regenerate/resend with git format-patch so each patch carries its own subject line and revision/series tag, matching the titles already given in the cover letter shortlog.


Thanks,
Tomasz

