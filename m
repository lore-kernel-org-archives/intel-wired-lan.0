Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E480CA5FA2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 13:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21CE180D7D;
	Mon, 28 Sep 2026 13:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrDX_pNHT0gG; Mon, 28 Sep 2026 13:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BF5D80D7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790600891;
	b=X0H0Uwy2vaKOaMLvjpdKh7Ne1owjjp3L7PBEIOfMioADmW05yPUWpjx7hsbuLREMbAYA
	 /hTKaVc3jchdnnJXDW0w2jQOrvkg9p+zLpUOa+GaFaS9ylprsv/zYEHTiTBU2fPbF1QdV
	 EmgEYO794GgM6KbZw2ZAYtrOFqB/DPC+qE4hT9UJP7zWdSlVlzij0Io2wZom6S0zfFg3n
	 WikDf6Z+o4RKVDf+MBpogEP8Sf/n7M6HZMg3+a0PCNhIiIbUtGcGahu4tcRUzGi+M9Dt2
	 vc+qQJlMu0sSAW2YWMOFQfTadIw7SC+wV6Vul2zO33bWnZeVUWQsrwaK4o+nq/MST+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790600891;
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
	bh=ibD6NF+g9D5vRFOzGmyOuK1Cd0NzsGIgjxGfm1lnKCo=;
	b=ZDvaDrZ+r/h0Zg8hyBU7wOa6OzLNz7m5nUrvq4VKAbdsfwD+wRsNxi+e/MyCnVkfw8On
	 P1zclLVrNksztMrSSkdHvNtF0QQd7Rt8ECObrQFSGzPzR1PxUR0laQG33hf85h0vE2uQG
	 jlyFhGGd+5j9c4Qekl1t2DBC1rPnsz0O/H30TIFvtc4U7+SwEWX5NYGdvY06FQpywgmT3
	 Fl4aca2pNnuEkiCANPk/f4abdyhjAiSWqnm95pzRwdWON0Jf10GfdK9V1TFQ5hHnBizP1
	 C7gQAhfx8+pBrB4PuUcuNwfuFjpiDuP9p+ITQwZBEEWwsYMfFdxOjNfinIkOxDBWI5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790600891;
	bh=ibD6NF+g9D5vRFOzGmyOuK1Cd0NzsGIgjxGfm1lnKCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hhvNLz49AdaAsS70YGBni7K1TUj//trtE2/y2ObYztfVCc86QZSQo+lt6ZERWYhud
	 Y1tl2ezQ3H03Ex92YrrSo+G0R9iSAdljmUgIiXbrM1dBf2MOfcGVstST2cXzy1glIa
	 m2w6F6Rnf8TvHMUKY51ggPScI23NCf4OaFF0BCjmA70DxveCjNu0CsqgKkB2rgvFKh
	 QPpcex7Sn/DtkW19UeamqG2hKCXKaKzEeJL/65l3stxj4GoMgm4Mdnb7PIqqSCxZVm
	 xx/n8h1loNioK7nDgpEaoGeUXgYsTJkA4g6Tec+ZRzR0EBHUedR7QWS+zOc0DVrx0i
	 uXfVU06C+sGnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BF5D80D7C;
	Mon, 28 Sep 2026 13:08:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 388BB72
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35D45605FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEQOpLWNp2SK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 13:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7F099605AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790600889;
 b=XuFW8Vlz32HLKGyhiea8hKcE0UJ6St7kl1L1EBBdfalCpyXpY2O7V7bHHtAshJo1HV34
 hqrQjA1nFVLom+qEntCcuWkZow/dbb5Xr84Bj8OK4pn6uS+J5sqhOvWwwhlCuHxOBfS7v
 sRkHo7ytZBJPaCBLbAqC/xq+msftkvIhTy8wHKAgvDicw2QJF+i+AFfAEJ7pFBO/FFn2c
 JG7MbI1NU8Gq5R2bMHLmMpq7nYzHnC+PcBDdtsuxbjTUn5chuX5BBp/op5qH7/68MFDar
 jTrPYde9LIG1mxyxBIF/pAuJIexm+iEci3mkT8GN8Ow9bxkQSAB50+GzVLcYO41asyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790600889;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ibD6NF+g9D5vRFOzGmyOuK1Cd0NzsGIgjxGfm1lnKCo=;
 b=cXaig6iczxCpAegrvUJDWsXkkYsk060CY7t0KKuxzEOoAbecnM95UP5DNftwCRXOUSvO
 EUMMH8y6+W4fDLhCPRqqIUeAV98CsbNFe3Ql7iQhRMs7sDv3Y8myYcnTWkZDuNXwjoWS2
 Q1BAYukYjnqc9ZILjp6WhOyNDqQxDG8ljWjPXL3eZZF9C8fq5+cGMh2bo3RYLPAeP6U+j
 y3ZuvRDQYTTuv9ojw5//nO0oMs5tds2OY5OyBQzELVmCcfzYT3yKPUSDWs11VmzdMpcAr
 Zj8+fACPDjDrZ/G/cFoeNEJtBKKgz39bbZvim8DtnaI9IdVHtuLtbzBJYhJ2joV1FVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YUQ9Kbx3; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YUQ9Kbx3
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F099605AF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790600890; x=1822136890;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bm9nAwO6vFtN0WgH54PMOwvG9IdII+DIteKoWycbzWE=;
 b=YUQ9Kbx39XQsze7YDX0rD5LGNHbtxTQJbPl/7W5RIIJ9FhuRBpprIRpd
 1gXnpA6jcwIA9pNiqPN9pcV2EvWBV3I1OHtAjXw52RlY7pjvXFvmJAlwI
 G2paemrjKROEsDhohB2V7x/7TidiL4gfS9UewY0hXUKed7N3B5GzRVKvF
 YQxb81rOjIKTqSQQ8WBSQE9BfpP58pJjZnZCI7du2vKpg0K/ey472t6Kv
 iUwRpxNCnPE9Ml4C17EKmHiecqg2Gu/wxrxT/O8RMlHAndHwj2DaMkyUb
 9m+8NpLHr8ayIp2FvVlAD1Y1PJyZB9Y0vme3afQlHdachbwlZHIOTITDy g==;
X-CSE-ConnectionGUID: BoERgjjQRquZpUzDnK5zJA==
X-CSE-MsgGUID: q+fr8w9MR/yqNo88Rodqig==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="93788051"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="93788051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:08:07 -0700
X-CSE-ConnectionGUID: bWy20A38Q7yp4PaIe4g4Rg==
X-CSE-MsgGUID: QjSfbDTUTcKUcBzEr6fg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="302999362"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:08:06 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
 by linux.intel.com (Postfix) with ESMTP id 0177920B5708;
 Mon, 28 Sep 2026 06:08:03 -0700 (PDT)
Message-ID: <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Date: Mon, 28 Sep 2026 15:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <20260928065306.1514795-2-xiaolinkui@126.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260928065306.1514795-2-xiaolinkui@126.com>
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



On 28.09.2026 08:53, Linkui Xiao wrote:

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 95abc6704820..df84dbe12cba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  		return -ENOMEM;
>  
>  	vsi = ice_vf_vsi_setup(vf);
> -	if (!vsi)
> -		return -ENOMEM;
> +	if (!vsi) {
> +		err = -ENOMEM;
> +		goto free_irqs;
> +	}
>  
>  	err = ice_vf_init_host_cfg(vf, vsi);
>  	if (err)
> @@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  
>  release_vsi:
>  	ice_vf_vsi_release(vf);
> +free_irqs:
> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
> +
>  	return err;
>  }
>  
> @@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>  				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
>  					vf->vf_id, retval);
>  				ice_vf_vsi_release(vf);
> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
> +						   vf->num_msix);

Nit: For consistency with the teardown: loop (which frees IRQs before releasing the VSI), consider swapping the order here too - currently this branch releases the VSI first, then frees IRQs, the opposite order. Not functionally significant, just readability.

>  				goto teardown;
>  			}
>  		}

Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>


