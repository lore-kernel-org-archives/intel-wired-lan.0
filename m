Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD655C36010
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Apr 2025 02:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F638169F;
	Tue,  8 Apr 2025 02:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IY002EvV0c9t; Tue,  8 Apr 2025 02:20:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E39E7811DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744078836;
	bh=mTadr6hlfyyWPFYhpnPzSUF00n3EJeBKU1nvkMa6B0k=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iktVeLfYXiZd1TjNEXeF4gP+FMENDC/zxmNGoMEG+TBu5qZz5Ttx7ja9KP/QhYFdE
	 h5L/3QVjrVZ60y8kW3K3Om8O8tFO1DnflM30wvABAfyVRkzw0tuR8kZigVSu9sJABV
	 omisu2g0iank6Attg0Hpm6HRBB13q0bLcC5iUTIyfZMyhjWjfXd5c3U62HOGiRlWEy
	 PpUKw+T8oaOojKkWnT6jF+x9JHPqMkL221iMjQIISdHt3KiTQ7urIDBLsNDzq102Al
	 B01YNrTZF3v/rMOZ5EqWP+d4skIs+nRkXeupKgdkSqlVbg3jk05xiy8kZA5Nov1+bN
	 LIhku8lpKDdCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E39E7811DC;
	Tue,  8 Apr 2025 02:20:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DF5A1DE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F9AC404F9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQd5DFCA6I-a for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Apr 2025 02:20:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.170;
 helo=out-170.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 90F8B40175
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90F8B40175
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90F8B40175
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Apr 2025 02:20:34 +0000 (UTC)
Message-ID: <6c463f96-18e7-4ee9-ba74-524772e008b4@linux.dev>
Date: Tue, 8 Apr 2025 10:19:39 +0800
MIME-Version: 1.0
To: Simon Horman <horms@kernel.org>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
 <20250407140242.GK395307@horms.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20250407140242.GK395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1744078831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mTadr6hlfyyWPFYhpnPzSUF00n3EJeBKU1nvkMa6B0k=;
 b=NFCY8Y1dz+KkzOURdbfKAdoFb/kvpmtBEKKkSOhVv/lWdHckn8yhFGmrio62gou0llqR8F
 nNZD1lvurUHtiBwoPdFh/RlO6qSkOpkSk5gefPoSfRzaI+AeVRMMhHIT7oRWeoYo60qlDp
 8oNKKm8SHQ1AtqnSrzpKmESCeexcwSU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=NFCY8Y1d
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


在 2025/4/7 22:02, Simon Horman 写道:
> On Tue, Mar 25, 2025 at 10:01:49AM +0800, Xuanqiang Luo wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
>> pointer values"), we need to perform a null pointer check on the return
>> value of ice_get_vf_vsi() before using it.
>>
>> v2: Add "iwl-net" to the subject and modify the name format.
>>
>> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> index 14e3f0f89c78..53bad68e3f38 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
>>   	dev = ice_pf_to_dev(pf);
>>   	vf_vsi = ice_get_vf_vsi(vf);
>>   
> nit, but not need to repost because of this: it's seems nicer
> not to have not to have a blank line here. And instead, if one is
> really wanted, put it above the ice_get_vf_vsi() line.
>
Thank you for the reminder. I will take this into consideration when
submitting other patches next time. Since vf_vsi and its judgment logic
are logically adjacent, it's better not to separate them with blank
lines.

>> +	if (!vf_vsi) {
>> +		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
>> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>> +		goto err_exit;
>> +	}
>> +
>>   #define ICE_VF_MAX_FDIR_FILTERS	128
>>   	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>>   	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
>> -- 
>> 2.27.0
>>
>>
