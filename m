Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B617DC77B60
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Apr 2023 01:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4510683C4F;
	Thu, 27 Apr 2023 01:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4510683C4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682558139;
	bh=F1+fYdLHL1Q5AkqoOr6D1KvSAW1l8t0EKnfHnWDMX3E=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YucPJJFxITSgHR5vMnKrtm3FAFJYedxevjSWIq6+k+Y6ia60YH0ggbvh81aIWF1Vj
	 jfPCRDHF83jw49aMTBwsVqHqCKIX6TprSi4WqQ/zlWk/q2GqHAg0fPhJTaHO1Ba74J
	 w/Y/zH1o3xeK0NO0QO4r5+EJJ0OmhGp831flEzudgbrPAFgSUECwFSGWfZgwSt+6W8
	 zr23Bm3LWjnwJd/SiD8VTCOgVvRsR/6CSgNgZoCv5jCNKiEfTvhCI3FTlfCMgZiK+u
	 qvtFdjc6dMG+Zfbk3OnijXtVYT/qQtZEDtQgDC0GiE+y4rau/e7XNwJiieJamYJvFR
	 IP3mKbgN6TseA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJvbvzeC48gs; Thu, 27 Apr 2023 01:15:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5011E83C59;
	Thu, 27 Apr 2023 01:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5011E83C59
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 743971BF39E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 01:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BEEA83C59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 01:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BEEA83C59
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id im0KqJfbRN_7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Apr 2023 01:15:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27EB283C4F
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com
 [115.236.118.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27EB283C4F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Apr 2023 01:15:33 +0000 (UTC)
Received: from [0.0.0.0] (unknown [172.96.223.238])
 by mail-m11876.qiye.163.com (Hmail) with ESMTPA id 2526A3C00F0;
 Thu, 27 Apr 2023 09:15:01 +0800 (CST)
Message-ID: <650acda0-9ec9-7634-3e01-e4870c8890b7@sangfor.com.cn>
Date: Thu, 27 Apr 2023 09:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Michal Kubiak <michal.kubiak@intel.com>, anthony.l.nguyen@intel.com
References: <20230419150709.24810-1-dinghui@sangfor.com.cn>
 <20230419150709.24810-2-dinghui@sangfor.com.cn>
 <ZElExd5bAL2FCpIB@localhost.localdomain>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <ZElExd5bAL2FCpIB@localhost.localdomain>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0lKVhofHU5LThhPGR0fTlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpMSVVCTVVJSUhVSUhDWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a87c0474c3d2eb2kusn2526a3c00f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Ihw4Cj0TT0oBIyo3Eyw8
 HTcaCk5VSlVKTUNJTk5DSkpKTEpNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlKTElVQk1VSUlIVUlIQ1lXWQgBWUFISEJINwY+
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] iavf: Fix use-after-free
 in free_netdev
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
Cc: pengdonglin@sangfor.com.cn, keescook@chromium.org,
 grzegorzx.szczurek@intel.com, mitch.a.williams@intel.com,
 jesse.brandeburg@intel.com, huangcun@sangfor.com.cn,
 linux-kernel@vger.kernel.org, gregory.v.rose@intel.com, edumazet@google.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 jeffrey.t.kirsher@intel.com, simon.horman@corigine.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2023/4/26 23:35, Michal Kubiak wrote:
> On Wed, Apr 19, 2023 at 11:07:08PM +0800, Ding Hui wrote:
>> Cc: Huang Cun <huangcun@sangfor.com.cn>
>> Acked-by: Michal Kubiak <michal.kubiak@intel.com>
> 
> I'm sorry, but I don't remember giving "Acked-by" tag for that patch.
> I gave "Reviewed-by" only for the v2 series.
> 

Sorry, that is added by myself since your reply for v1 "Looks OK to me"
and "Looks correct to me", and I tried to ask for your agreement.

> We can't add any tags if they weren't given by the person himself.

I apologize to you.

> Please fix that.

Hi Tony Nguyen,
the patches is already applied to your dev-queue branch, should I send
v3 or you can fix it in your git?

> Nacked-by: Michal Kubiak <michal.kubiak@intel.com>
> 
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>> ---
>> v1 to v2:
>>    - add Fixes: tag
>>    - add reproduction script
>>    - update commit message
>>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 

-- 
Thanks,
- Ding Hui

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
