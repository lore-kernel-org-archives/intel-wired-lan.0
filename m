Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB5C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Nov 2022 16:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A39340B13;
	Tue, 22 Nov 2022 16:08:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A39340B13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669133323;
	bh=hcfWDqDqlKl7I+8XQu8+HCOxi50R7/Ge1MNUeGfKaKQ=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ewd203YeJmEiqiIGseTRCP/94+8EHrkNa1IVGxvUVhkY+ipHI3o7p2m2lgBc7+02a
	 +KKhDlCc+vlT6AZrky3Ul5FDAcRyvLPCFWYwffsgmXLIuICLrGVqPULrFVGvJVva18
	 OtgcnFzcZcnzizsx2r5G5rRU2hFTNLNCuumLf3RcF20jffYFJmRYZ4FCXCWJgSby+A
	 sT6Lf6aFTRbdk83Npbx0orFY8azBSkjD8av9jhXSwmWUFcZbxgUBQrNCwlUmotwcX3
	 SBh++PzV8ddJL70Dzv1BRXUTdHTG1jXpizu2I1vy18K2KrGD03NgU9ubkzH8kd9BcP
	 S5G3pOQ2Wqaiw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtV36VtSSFg3; Tue, 22 Nov 2022 16:08:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7139640B48;
	Tue, 22 Nov 2022 16:08:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7139640B48
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 987901BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CAAA4021C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CAAA4021C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ds0iuemzUZg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Nov 2022 02:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A29C40108
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A29C40108
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:55:48 +0000 (UTC)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NGTM12QSRzJnhG;
 Tue, 22 Nov 2022 10:52:29 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:55:43 +0800
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20221120061757.264242-1-cuigaosheng1@huawei.com>
 <Y3u95fVsT/7zXQQp@boxer>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <322f3167-d5e4-502a-ccb0-1f79ae254d3e@huawei.com>
Date: Tue, 22 Nov 2022 10:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y3u95fVsT/7zXQQp@boxer>
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:08:37 +0000
Subject: Re: [Intel-wired-lan] [PATCH net] intel/igbvf: free irq on the
 error path in igbvf_request_msix()
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
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> s/free_irq1/free_irq_tx ?
>
>>   
>>   	adapter->rx_ring->itr_register = E1000_EITR(vector);
>>   	adapter->rx_ring->itr_val = adapter->current_itr;
>> @@ -1083,10 +1083,14 @@ static int igbvf_request_msix(struct igbvf_adapter *adapter)
>>   	err = request_irq(adapter->msix_entries[vector].vector,
>>   			  igbvf_msix_other, 0, netdev->name, netdev);
>>   	if (err)
>> -		goto out;
>> +		goto free_irq2;
> s/free_irq2/free_irq_rx ?
>

Thanks for taking time to review this patch, I have made a patch v2 and submit it.

link: https://patchwork.kernel.org/project/netdevbpf/patch/20221122022852.1384927-1-cuigaosheng1@huawei.com/


On 2022/11/22 2:05, Maciej Fijalkowski wrote:
> On Sun, Nov 20, 2022 at 07:17:57AM +0100, Gaosheng Cui wrote:
>> In igbvf_request_msix(), irqs have not been freed on the err path,
>> we need to free it. Fix it.
>>
>> Fixes: d4e0fe01a38a ("igbvf: add new driver to support 82576 virtual functions")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> Hi,
>
>> ---
>>   drivers/net/ethernet/intel/igbvf/netdev.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
>> index 3a32809510fc..e212ca16df00 100644
>> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
>> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
>> @@ -1074,7 +1074,7 @@ static int igbvf_request_msix(struct igbvf_adapter *adapter)
>>   			  igbvf_intr_msix_rx, 0, adapter->rx_ring->name,
>>   			  netdev);
>>   	if (err)
>> -		goto out;
>> +		goto free_irq1;
> s/free_irq1/free_irq_tx ?
>
>>   
>>   	adapter->rx_ring->itr_register = E1000_EITR(vector);
>>   	adapter->rx_ring->itr_val = adapter->current_itr;
>> @@ -1083,10 +1083,14 @@ static int igbvf_request_msix(struct igbvf_adapter *adapter)
>>   	err = request_irq(adapter->msix_entries[vector].vector,
>>   			  igbvf_msix_other, 0, netdev->name, netdev);
>>   	if (err)
>> -		goto out;
>> +		goto free_irq2;
> s/free_irq2/free_irq_rx ?
>
>>   
>>   	igbvf_configure_msix(adapter);
>>   	return 0;
>> +free_irq2:
>> +	free_irq(adapter->msix_entries[--vector].vector, netdev);
>> +free_irq1:
>> +	free_irq(adapter->msix_entries[--vector].vector, netdev);
>>   out:
>>   	return err;
> Besides above suggestions, change LGTM.
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
>>   }
>> -- 
>> 2.25.1
>>
> .
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
