Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC90C7EE20
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Apr 2023 00:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DECF440199;
	Wed, 19 Apr 2023 00:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DECF440199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681865442;
	bh=N9yQiWkH64jewU0pe/0xuR88M8UA4uQmAJR6F2PTU9A=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=l0hiykeTa9DZ8AGXAghE5Po32xte8S0puFgt/L4igHCaL1DqC4GJt9AAOJGanO1QC
	 Vu9iTF+Ri/kO9+i83Dw2Mkqn/p73vd8KoqX8aj8PM45ILNJ1dcRCwOxBukbuTQjJ6k
	 AJrDXnMAcQmyhKcujcUbHaEWOUlvdYVUJqoeSZ+fS27+t0XfNSEAM/LXJZ7SvC0e5X
	 PkPH8v0DFfavy2vgqMl4lJX+2zicmsKvy9MRKyvK5LnU4RvmiKNUpgUkEKvw4Rq/oN
	 26Mqq/E/0wKGuIQFdat6FACeL5QjzNXuc8gjt+AfQnj90YbI8CPMNqrUuBk0cngvIi
	 WLtmZMljPkOyQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ttieu5TdRlu1; Wed, 19 Apr 2023 00:50:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF06E41771;
	Wed, 19 Apr 2023 00:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF06E41771
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7F4EB1C429C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 00:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5406D83F18
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 00:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5406D83F18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WIXOQy7z5vcM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Apr 2023 00:50:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA60483F16
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com
 [115.236.118.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA60483F16
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 00:50:38 +0000 (UTC)
Received: from [0.0.0.0] (unknown [172.96.223.238])
 by mail-m11875.qiye.163.com (Hmail) with ESMTPA id CC7CF28020C;
 Wed, 19 Apr 2023 08:50:22 +0800 (CST)
Message-ID: <3fece61c-3cf3-8e0b-f7de-8e61d4ec9037@sangfor.com.cn>
Date: Wed, 19 Apr 2023 08:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Michal Kubiak <michal.kubiak@intel.com>
References: <20230408140030.5769-1-dinghui@sangfor.com.cn>
 <20230408140030.5769-2-dinghui@sangfor.com.cn>
 <ZD6/H9DotpfOxr1+@localhost.localdomain>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <ZD6/H9DotpfOxr1+@localhost.localdomain>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTENCVkwaGB1DHx1LQkhOTFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpMSVVCTVVJSUhVSUhDWVdZFhoPEhUdFFlBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Tid: 0a8796fdd30e2eb1kusncc7cf28020c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6SAw5MT0NPBEQOD1MDEND
 SzIwCixVSlVKTUNKQ01OT0hLQ05OVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlKTElVQk1VSUlIVUlIQ1lXWQgBWUFNTkNKNwY+
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: Fix use-after-free in
 free_netdev
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
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>, keescook@chromium.org,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
 Huang Cun <huangcun@sangfor.com.cn>, linux-kernel@vger.kernel.org,
 grzegorzx.szczurek@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2023/4/19 0:02, Michal Kubiak wrote:
> On Sat, Apr 08, 2023 at 10:00:29PM +0800, Ding Hui wrote:
>> We do netif_napi_add() for all allocated q_vectors[], but potentially
>> do netif_napi_del() for part of them, then kfree q_vectors and lefted
>> invalid pointers at dev->napi_list.
>>
>> If num_active_queues is changed to less than allocated q_vectors[] by
>> by unexpected, when iavf_remove, we might see UAF in free_netdev like this:
> 
> Nitpick: the word "by" is accidentally doubled.
> 

Oops, I noticed too, and I'll update in v2.

> Also, I would recommend to add a description of reproduction steps (most
> preferably a script or a command sequence) which triggers such an error
> reported by KASAN.
> 

Sure, I'll update in v2.

>>
>> [ 4093.900222] ==================================================================
>> [ 4093.900230] BUG: KASAN: use-after-free in free_netdev+0x308/0x390
>> [ 4093.900232] Read of size 8 at addr ffff88b4dc145640 by task test-iavf-1.sh/6699
>> [ 4093.900233]
>> [ 4093.900236] CPU: 10 PID: 6699 Comm: test-iavf-1.sh Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
>> [ 4093.900238] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS 2.0 04/09/2021
>> [ 4093.900239] Call Trace:
>> [ 4093.900244]  dump_stack+0x71/0xab
>> [ 4093.900249]  print_address_description+0x6b/0x290
>> [ 4093.900251]  ? free_netdev+0x308/0x390
>> [ 4093.900252]  kasan_report+0x14a/0x2b0
>> [ 4093.900254]  free_netdev+0x308/0x390
>> [ 4093.900261]  iavf_remove+0x825/0xd20 [iavf]
>> [ 4093.900265]  pci_device_remove+0xa8/0x1f0
>> [ 4093.900268]  device_release_driver_internal+0x1c6/0x460
>> [ 4093.900271]  pci_stop_bus_device+0x101/0x150
>> [ 4093.900273]  pci_stop_and_remove_bus_device+0xe/0x20
>> [ 4093.900275]  pci_iov_remove_virtfn+0x187/0x420
>> [ 4093.900277]  ? pci_iov_add_virtfn+0xe10/0xe10
>> [ 4093.900278]  ? pci_get_subsys+0x90/0x90
>> [ 4093.900280]  sriov_disable+0xed/0x3e0
>> [ 4093.900282]  ? bus_find_device+0x12d/0x1a0
>> [ 4093.900290]  i40e_free_vfs+0x754/0x1210 [i40e]
>> [ 4093.900298]  ? i40e_reset_all_vfs+0x880/0x880 [i40e]
>> [ 4093.900299]  ? pci_get_device+0x7c/0x90
>> [ 4093.900300]  ? pci_get_subsys+0x90/0x90
>> [ 4093.900306]  ? pci_vfs_assigned.part.7+0x144/0x210
>> [ 4093.900309]  ? __mutex_lock_slowpath+0x10/0x10
>> [ 4093.900315]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e]
>> [ 4093.900318]  sriov_numvfs_store+0x214/0x290
>> [ 4093.900320]  ? sriov_totalvfs_show+0x30/0x30
>> [ 4093.900321]  ? __mutex_lock_slowpath+0x10/0x10
>> [ 4093.900323]  ? __check_object_size+0x15a/0x350
>> [ 4093.900326]  kernfs_fop_write+0x280/0x3f0
>> [ 4093.900329]  vfs_write+0x145/0x440
>> [ 4093.900330]  ksys_write+0xab/0x160
>> [ 4093.900332]  ? __ia32_sys_read+0xb0/0xb0
>> [ 4093.900334]  ? fput_many+0x1a/0x120
>> [ 4093.900335]  ? filp_close+0xf0/0x130
>> [ 4093.900338]  do_syscall_64+0xa0/0x370
>> [ 4093.900339]  ? page_fault+0x8/0x30
>> [ 4093.900341]  entry_SYSCALL_64_after_hwframe+0x65/0xca
>> [ 4093.900357] RIP: 0033:0x7f16ad4d22c0
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> index 095201e83c9d..a57e3425f960 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>> @@ -1849,19 +1849,15 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
>>   static void iavf_free_q_vectors(struct iavf_adapter *adapter)
>>   {
>>   	int q_idx, num_q_vectors;
>> -	int napi_vectors;
>>   
>>   	if (!adapter->q_vectors)
>>   		return;
>>   
>>   	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
>> -	napi_vectors = adapter->num_active_queues;
>>   
>>   	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
>>   		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
>> -
>> -		if (q_idx < napi_vectors)
>> -			netif_napi_del(&q_vector->napi);
>> +		netif_napi_del(&q_vector->napi);
>>   	}
>>   	kfree(adapter->q_vectors);
>>   	adapter->q_vectors = NULL;
> 
> The fix looks correct to me.
> We actually call "netif_napi_add()" for all allocated q_vectors unconditionally
> in "iavf_alloc_q_vectors()").
> 

If you don't mind, I'll add Acked-by: tag in v2, thanks.

> Thanks,
> Michal
> 
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
