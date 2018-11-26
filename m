From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 26 Nov 2018 12:15:04 +0530
Subject: [Intel-wired-lan] [PATCH] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <20181124140554.GG3175@vkoul-mobl.Dlink>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
 <20181124140554.GG3175@vkoul-mobl.Dlink>
Message-ID: <5228bcdb-b140-a86a-6c9c-488f1a723353@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/24/2018 07:35 PM, Vinod Koul wrote:
> On 23-11-18, 15:24, Anshuman Khandual wrote:
> 
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -386,7 +386,8 @@ EXPORT_SYMBOL(dma_issue_pending_all);
>>  static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
>>  {
>>  	int node = dev_to_node(chan->device->dev);
>> -	return node == -1 || cpumask_test_cpu(cpu, cpumask_of_node(node));
>> +	return node == NUMA_NO_NODE ||
>> +		cpumask_test_cpu(cpu, cpumask_of_node(node));
>>  }
> 
> I do not see dev_to_node being updated first, that returns -1 so I would
> prefer to check for -1 unless it return NUMA_NO_NODE

Sure will update dev_to_node() to return NUMA_NO_NODE as well.
