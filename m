Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96047C36010
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Apr 2025 02:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B3C2404A8;
	Tue,  8 Apr 2025 02:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DguQLDheKCLb; Tue,  8 Apr 2025 02:16:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6036B406E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744078572;
	bh=lPjoLTdoallsCTo09suEBRnN2BCJJBA5YHjIc4x9f54=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlXSd8wG5ZTtziocYgP8eGV3qZnS70NOkxmhfY+pBZ0DgXLTw/KfyqcK7Spsjxm/K
	 /BL+G5fLVSdQDjTPibS6MCS9/o9vNDhRc4pDcbdgCGpIJ/zdxF35W3yEssY74L3Y9S
	 oMK+vBEhF3rQ9zN9dQFUQy7jxaLqp2Kvz+gDHwxVwSCeSIgpZTBpMRsVuIzogKKk4y
	 3t9X6dSAQBXzHpaNn/0q+WRIjr0G+2NVUI3tBr7eahy810T8wbWcoT59tLYeliYr4g
	 1w71XEO3ebU9ksSvQRJMk0lKulcbcGajNQCLEtiHDzwQh5UTNTdcgpu+kDZXD32Z6x
	 pTmKSBqWUlUSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6036B406E1;
	Tue,  8 Apr 2025 02:16:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BDD71DE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A50F406E1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwXyJxxzeSZK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Apr 2025 02:16:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.172;
 helo=out-172.mta0.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 62C3B404A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62C3B404A8
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [91.218.175.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62C3B404A8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:16:09 +0000 (UTC)
Message-ID: <b209be10-2653-4a9e-bb9d-683fc9c0cf50@linux.dev>
Date: Tue, 8 Apr 2025 10:15:13 +0800
MIME-Version: 1.0
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
 <4a960ad6-6118-4db8-9511-a1e3bb5b66f3@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <4a960ad6-6118-4db8-9511-a1e3bb5b66f3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1744078566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lPjoLTdoallsCTo09suEBRnN2BCJJBA5YHjIc4x9f54=;
 b=E1xlKyIcR69jh405rRGhisEKnGfRwzmSoeTe/aS8yt3OOGp3JLUINTh0nhqxVEtDDJyyFz
 Zs/dOfYr7S4QTnsgPHhq04WcOjmwtcvodR50TtN9Hq1mUnsoqSxXA90JXEcusWyYWotMZ7
 9F6ZWcEFi4pnWpG5YWS9Z9+pLszonbQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=E1xlKyIc
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Check VF VSI Pointer
 Value in ice_vc_add_fdir_fltr()
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


在 2025/3/27 18:22, Przemek Kitszel 写道:
> On 3/25/25 03:01, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
>> pointer values"), we need to perform a null pointer check on the return
>> value of ice_get_vf_vsi() before using it.
>>
>> v2: Add "iwl-net" to the subject and modify the name format.
>>
>> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR 
>> filters")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
> (technically the changelog (v2:...) should be placed here, with 
> additional "---" line afterwards; no need to resubmit just for that)
>
Thank you for your guidance. I'll keep this in mind. :) BRs! Xuanqiang

>> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c 
>> b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..53bad68e3f38 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 
>> *msg)
>>       dev = ice_pf_to_dev(pf);
>>       vf_vsi = ice_get_vf_vsi(vf);
>>   +    if (!vf_vsi) {
>> +        dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
>> +        v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +        goto err_exit;
>> +    }
>> +
>>   #define ICE_VF_MAX_FDIR_FILTERS    128
>>       if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>>           vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
