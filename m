Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE1DC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A00F940D99;
	Fri, 18 Sep 2026 13:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2U7op3NSlHr; Fri, 18 Sep 2026 13:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F075C40D5F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789737108;
	b=nM41e3lUxA4HEs7WO+COL4CpV1QY9gY3LiVOSfE5MVk53WWGhXKaAseThfpCX9z6mS9b
	 cBK/XpOUqCNBPelkszzYdHRYTu0EgoJdhQ9Zji2YHwrtMm9CY8+RRJ9xJ1kegW5xF9Rot
	 3p8kjcgWgUxJKw9Kv5riEJSqCNHWzcjmsUDtznJ7DhbDq3ZYKMYkplSxbCqUzA4f9iTvl
	 uyZWeTQKa3kCxWJN4cEp0h6pj4ngR6xss+WYWul3HXUaM0l7un/RdVOADqsd4Q675+4hv
	 QsRWZ7Auz/xtUq2pOpHewP/vh2L9dObbxjSzR/Scwa6sM6pMOegpN7u4LjhIhtwP4eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789737108;
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
	bh=7qO+fK1x1CSwyj/vmp+JyOLzsUUHMZ4tQH32pnuDZ74=;
	b=kF81VxnjrdvLtKgPNpg3JC/VeE7tDF0cgp0Ssh3SPXmdxvDf2v+GzgR69XVa5WMM0inn
	 TqWIblAQ+rB/hvwDBT1GFvWn9txb4OCtHNS9ddSXCvNe9jvDp0ebOVJAIYIT7mKQ4FJO5
	 AJYUncY1w+8aIzIXg+aiKDV4UVfcfBpFPU5JTDvu/wODmGq9pWWxbZ92TSVtQXbBs7kh6
	 hV62/+YqkIU8/ZLPXEhNS64876qsnT/pgmmsFpWyouNv3kPHRFKQs9o8dDBIFpKNiPFGu
	 WvZ4NDax4hNFBMLuF6S6KvlTPZTFQimUeNCebFFyt+MsXNWyPw1Xah5XtTx96Dw7O5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789737108;
	bh=7qO+fK1x1CSwyj/vmp+JyOLzsUUHMZ4tQH32pnuDZ74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kG8aMUjtJ2aYR5c+5uBRZYPxHOpsoBCQwsLvMiAIUBw3usKe66j7DBlQ4w4ibKCPJ
	 4YNTDubI07SVAl8Sa8+meFuJNA6aYNGtAab8yR5HhLY35boRyVjRmmEOwqGHx0iXxw
	 8Fh7qxP+Mdf1qPEU82WLbu/i8zOlsGU2Kb5oAEfRWrVS3sdgkwVRRL3lMxlqEOt8ZX
	 3VMjUjNYASyIF3GGd+yM/SbpLxFTK2mM5SC32fdUHNVXr9fSgzryPVzF1lkidNGpw2
	 GTgqEq34oxbjrJmTNrR/YT1KoFLXNFk9+ibeEqZlXe/J1W0oZER0W1i7I7nUS263ox
	 vDeTbk3YRnsxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F075C40D5F;
	Fri, 18 Sep 2026 13:11:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 812C1224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61D4660DB0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEnP3dLUaFEV for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF15860DA9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789737105;
 b=U9nITFgQfuNNyWy5ZNT7wpsGcMKTelGoglVh9npE2oD2R0vnfaHmb6JEv2TSQO/HpOe7
 9oNQ07RRiMWBRpT/7UUz5xRRO1KOnGPYILj8tQBQcCL//BfyNn+qDLvyH1LQCJ7Ba6wut
 a/2MIa6YEUOCJLhJ9iSXqX5nU7QTBHDVTZc76Ni2e3k5Na6F4RBKxRbKeyVNqEKGHEmR2
 EuvqLZw4hO9D/iNo66mfqNp4EonZH9HMRflwTT8Np5tpCep4Vpr+bn0ZjrRCrp+CDl1m9
 HWTSO4gA6IyRY7OKXaJwV3o2MaWIwzDO8A5ql3o8iefNl/zpCvJm1QCZG0Zk9zOQI6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789737105;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=7qO+fK1x1CSwyj/vmp+JyOLzsUUHMZ4tQH32pnuDZ74=;
 b=nm92wSD80E2QmUQeOFJdOhV336accdD/muHHY1qzgRSJZDlf9SAJ7xzB1GlcQZwaxpQx
 LujR+JLsr/DYdCxQuz01P7eNXB8CaWEtZTPE2O/+AdBLki3zmQZVaF2Z5P5FNrzXPAgE2
 qFB7FqtjtQtJpNdn/UFjccQo0oxN3oodUj0ytXcaBS2b4RChfloawoZazK1cJJ8WqHtXl
 e2ipGgjhU/rj3QAuphD0goFs7VJjol6QC/ohkME+aMcBP/468eXIiqO1MXPiFP6A6GdD5
 mTUZHe5HxKpd8t4LqqIYLGTWc4lFIxOb9wV3XNKsvehIaC4Appqr+y5gBWuryinffjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bj0j9rEh; 
 arc=none smtp.remote-ip=192.198.163.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bj0j9rEh
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF15860DA9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789737105; x=1821273105;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OrsDueolDB48ZiSn/3OL7AJT7dY/bOm5zXfF8rvHKZo=;
 b=bj0j9rEhwKPrZK6jSk2lEIwFS5WIZGRBcJrEX6cChdgtzhoK8lWgGpgT
 fK1sDcIQu+wysMwACxHV6jqPoJedrhYDDurPeawB+Lf1dCloZ9Dw06Maw
 gyj6iEtAy4M8myXkyOJ4i7cCGnhqyyXJkZduFV5MD0COOp025DDXpFA9H
 6Fpx0k98AmY5Z/j5gX5CYqu8iQeURQdJeRlOTTY16kArZb6KFS4NOFbfS
 moOG2zs2C4En9S/yyQQeGSw/GMwlT+QKfMotBIaoWJP/jSjc9vnRkx5mK
 rtjRLoV0WCz6QBE4wT8aXge8m+hGCLaykwS6FJmgGweZWPtAXzYnh+qsA Q==;
X-CSE-ConnectionGUID: 3+xHY8XCSz2vy/aHS+yCtQ==
X-CSE-MsgGUID: t77Li14QT9i3/TmEK9CcZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89377242"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="89377242"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:11:43 -0700
X-CSE-ConnectionGUID: Hk5X61dyT6+ZX9/9ZYRvrg==
X-CSE-MsgGUID: Uyx18gd7SZKuT071NFmA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270092049"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:11:43 -0700
Received: from [10.246.40.5] (unknown [10.246.40.5])
 by linux.intel.com (Postfix) with ESMTP id 688C120B5708;
 Fri, 18 Sep 2026 06:11:41 -0700 (PDT)
Message-ID: <da315e5f-b71f-4c8c-8705-94f530ff3f25@linux.intel.com>
Date: Fri, 18 Sep 2026 15:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
 <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index 21f3b61..9ae7de2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -1105,6 +1105,45 @@ static int ice_determine_css_hdr_len(struct ice_hw *hw)
>  	return 0;
>  }
>  
> +/**
> + * ice_parse_erot_presence - detect eRoT and populate hw->erot_present
> + * @hw: pointer to the HW struct
> + *
> + * Uses the device capability LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT when
> + * advertised by firmware, falling back to the eRoT Presence fuse only when
> + * the capability is not advertised at all (older firmware).
> + *
> + * Priority:
> + *  1. Device capability external_pqc_rot_present (advertised && == 1)
> + *     => eRoT present
> + *  2. Fuse BIT(0) set (only when capability not advertised)
> + *     => eRoT present
> + *  3. Otherwise => eRoT not present
> + */
> +void ice_parse_erot_presence(struct ice_hw *hw)
> +{
> +	u16 fuse = 0;
> +	int err;
> +
> +	hw->erot_present = false;
> +
> +	if (hw->dev_caps.common_cap.external_pqc_rot_present) {
> +		hw->erot_present = true;
> +	} else if (!hw->dev_caps.common_cap.external_pqc_rot_present_cap_advertised) {
> +		err = ice_read_sr_word(hw, ICE_SR_EROT_PRESENCE_FUSE, &fuse);
> +		if (err)

On a read failure the code assumes erot_present = false, i.e. fails open on a mechanism whose whole purpose is preventing bricking from partial updates. A transient SR read failure on real eRoT hardware silently disables the guard in patch 2. Consider treating a read failure as erot_present = true instead, or justify why fail-open is safe here.

> +			dev_warn(ice_hw_to_dev(hw),
> +				 "Unable to read eRoT presence fuse (SR 0x%04x), err %d; assuming eRoT not present\n",
> +				 ICE_SR_EROT_PRESENCE_FUSE, err);
> +		else if (fuse & ICE_EROT_PRESENCE_FUSE_PRESENT)
> +			hw->erot_present = true;
> +	}
> +
> +	if (hw->erot_present)
> +		dev_info(ice_hw_to_dev(hw),
> +			 "eRoT (external Root of Trust) present\n");
> +}
> +
>  /**
>   * ice_init_nvm - initializes NVM setting
>   * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
> index e1d1a11..4b31dfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.h
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
> @@ -28,7 +28,12 @@ int ice_get_inactive_nvm_ver(struct ice_hw *hw, struct ice_nvm_info *nvm);
>  int
>  ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *netlist);
>  int ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size);
> +/* eRoT Presence fuse SR offset; BIT(0) set means eRoT present */
> +#define ICE_SR_EROT_PRESENCE_FUSE	0x1016
> +#define ICE_EROT_PRESENCE_FUSE_PRESENT	BIT(0)

Commit message and function doc describe the fuse as "bits[1:0]", but only bit 0 is checked/masked. Please confirm with the fuse spec whether bit 1 is truly unused, or whether this needs GENMASK(1,0) with a specific expected value.

> +
>  int ice_init_nvm(struct ice_hw *hw);
> +void ice_parse_erot_presence(struct ice_hw *hw);
>  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data);
>  int
>  ice_aq_update_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,


