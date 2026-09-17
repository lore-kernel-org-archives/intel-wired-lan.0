Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3149C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E5AC407A0;
	Thu, 17 Sep 2026 09:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mxd-f18vP9I8; Thu, 17 Sep 2026 09:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0B234076D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789637737;
	b=NPfrA3uQeywb7N4xNMH2+Cn+zwUZhnLhVCgO32sczwUE5BY6tYRFYjnpQxNpO9qQs/61
	 +LqSC8kHicgSCMyPZ4Sqb4qArAGArZpXllPtdn2bx2sVwTe8Vn2zng6UmzYbU2akdpGlY
	 FqhCD8S46ExyxjjZxuZS7S7XbCgyjj7DGTjj5tKiSSczShLGGhdDiET+8yWVPQ6FIs/Wv
	 2xqZu+CarINtDMI+7do1oUQEP1euZ9fJKQemxZYBLrBSzFEBFJN832TOErz82fUZZO6lU
	 JL95HiL1JAn+nU2C97UO54IZXFi21aR8BMYGpbtwl7rMSoI5X7eCCbT6FfzsvCwDGrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789637737;
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
	bh=Hpcu8HKF+lPG8WrM+n8jjPhyzRRcnW1Z7qq+QZLruxU=;
	b=MzoYRllD3Hi7PbDBNemOwBWabn0sJhEUWY0vYqxosVxZLdcmwOgjZk80TDMrSX27DnIj
	 Jh872TMwmllwOJfjQ2yFbJtkcjsoAqz2sLa9BWZ2wUuwnX7J8Yz5482f1vjuaE7nsUoMh
	 R9RvAQ1fZ8c7LToc6FbxJOFKe1PVVox1USysaXo/r2WJjcb0qLN8+mdYnkJYN8C1y7eNM
	 +t3JlmwaTQl7MaU1YjXf9zGN9tWqY24LIwUQGkAl6IkM31rcm9XzbphFn9g1eT6Jp5+0l
	 TbTMMKIyEgVcd+IaAUbMKUKzwvA7ueXzRzYFqeLyCvlm/pya6V2yvHx45I/vdyHf4sA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789637737;
	bh=Hpcu8HKF+lPG8WrM+n8jjPhyzRRcnW1Z7qq+QZLruxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kRRvsvZvb3+KUGODPSzUSq4pFTQk6DcYfjcTSyQ5PfOazmQByVoXpkDt8AuNDtECP
	 kkShsazgyMMvF495bw0l9hsM37ZHT6/FINpTl+ygF98yPpLjGmrI+NOyBGtPxjF0Fs
	 AlxfjH2p69tQ46+W0LRnkJhUgUokH/I9x1aA6NZMP3St/XRcf9qTYTElFJfn+gjdpE
	 3Lk3YKYruExqUdjS4poTfjPTUtUG9mEcyAtq9bix1MZlXD35MZFGP/eq+mM/wCCXRu
	 8DvxHP8qmrabu4HTe//vShdnNJoIPkec00N65SOCVhamfhwsPJHBzRDnajLjXE8nYb
	 d5/9zRvs59gmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0B234076D;
	Thu, 17 Sep 2026 09:35:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6352129B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AC3480EE8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU37LhofYIeO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D082680EEE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789637734;
 b=aG2VkEOiuUDFpoOOxZlqKk/YRU9iVqPv7qNHbNH0iVM1tSzFZ2IZNCi08VzD3Y5qgFoL
 /l1mdVbj+8SvKgGaZCUl7yajv9dxOqzfwduTOjhufXnmKYOl3V1hr2iFpRmvs08pGDikw
 1eF9V+Mrj0mMwTqq7K/WJ7c8v8uXAUlWviBGVGwR5NYEWm7UhoKiprUsTxhICDlxyVlWW
 wMUIg6WlYDmmnGbMm6lh8yvVhb3Q7iQybegOudjlcdxLIV+Sxqe7T12sa8KNF0qa8AcsA
 qShNxGMbYx2qoJ3na/LH3wXhtVdNYq/AFh5Krm/rF3LgMozPNYcqcasIWuGM+SaD5vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789637734;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=Hpcu8HKF+lPG8WrM+n8jjPhyzRRcnW1Z7qq+QZLruxU=;
 b=S9qZ9VMgIJN962M7NBepNzpc3369F5SfoHgACKl9A5z8r/A+fieu+v7D/bU5bqy4yWWv
 +AP/s2lKVibNunTXttS5U2PjgLUzbed4GKsW/nwRIPBa7cwAc8PGLo0TE0e4gUCQs+UC7
 5j+IGEUdpXds3aMFhX5Bhcsq5VigNH0E7PCBgYmtgi9jxY8ZjWvdMSuHtVrdx62tVM8ti
 ui4TDgTHxNc9S+fvBtaYXYAgj2WgVApJE+KVedTqhh0EBJeijb+hTOpyx4RAd4P9YH2bc
 qvLfNFc29pzL7wTzCoR0IlpVuUKiOSDeFpnfuRx6/ZnZlB9bd7xBQw334PrWVZH15xg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UGgnumDV; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UGgnumDV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D082680EEE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789637734; x=1821173734;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AV1TJBNzs8Rx6IDeXsnEOhbgxjuLcvQpuzTJRUwdisw=;
 b=UGgnumDViUjAkRPo0zeE3toq75LEZub+bPcuVfznRTHLB+GdSElL13fZ
 huXuh+2zFNL8DkanfNEeUc2Tfm1XxAy2cCcPT0flVeZNcZKfHiQ1dDMV/
 ZU5AhbhXE4uFdEUK7yd4GMQGeKN2oevtWGYuFEHJZeXiy/0IUo6p6EgC8
 XTAK1imRpw1QKH9j4rymbz+ge9UQCa0lbakpgT6zLYExJp5sVj61O4l+2
 pFZcXY76Xx+tM/acX7COvMVqXCbZjNqTEXrx9aqMxKn1P5LuowdEpk2qa
 BYnGWTUUyZrVJgmT5gLBsvnS0UU1RNqpX2sk7+8tXRKVfEdcxxA5cz3S3 A==;
X-CSE-ConnectionGUID: 8FZSbImvSw6Pt6A5V5jzXw==
X-CSE-MsgGUID: mA8Jo20CQ5uowrXRLGP4ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107548510"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107548510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:35:32 -0700
X-CSE-ConnectionGUID: j2D/QbbVTk69Xysud5NNTg==
X-CSE-MsgGUID: efBg71spTW2HiZMM7PbkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298764816"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:35:32 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 293B120B5708;
 Thu, 17 Sep 2026 02:35:29 -0700 (PDT)
Message-ID: <5ffcee35-e44e-4c54-978b-42bb79601c3f@linux.intel.com>
Date: Thu, 17 Sep 2026 11:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
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



On 15.09.2026 14:55, Aleksandr Loktionov wrote:

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ef1ce10..d53307b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2507,7 +2507,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
>  		}


		/* print message only when processing device capabilities
		 * during initialization.
		 */
		if (caps == &hw->dev_caps.common_cap)
			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");


This message is still printed whenever num_funcs > 4, regardless of the new mac_type != ICE_MAC_E830 check above it. On E830 devices with more than 4 ports, RDMA now stays enabled but this log line still claims it's unavailable. Please gate it on the same condition used to actually disable caps->rdma.


Thanks,
Tomasz

