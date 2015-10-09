From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Fri, 9 Oct 2015 17:25:36 +0800
Subject: [Intel-wired-lan] [Patch V3 5/9] i40e: Use numa_mem_id() to
 better support memoryless node
In-Reply-To: <56178419.6090503@jp.fujitsu.com>
References: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
 <1439781546-7217-6-git-send-email-jiang.liu@linux.intel.com>
 <4197C471DCF8714FBA1FE32565271C148FFFF4D3@ORSMSX103.amr.corp.intel.com>
 <alpine.DEB.2.10.1508191717450.30666@chino.kir.corp.google.com>
 <20151008132037.fc3887da0818e7d011cb752f@linux-foundation.org>
 <56175637.50102@linux.intel.com> <56178419.6090503@jp.fujitsu.com>
Message-ID: <56178810.8040200@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015/10/9 17:08, Kamezawa Hiroyuki wrote:
> On 2015/10/09 14:52, Jiang Liu wrote:
>> On 2015/10/9 4:20, Andrew Morton wrote:
>>> On Wed, 19 Aug 2015 17:18:15 -0700 (PDT) David Rientjes
>>> <rientjes@google.com> wrote:
>>>
>>>> On Wed, 19 Aug 2015, Patil, Kiran wrote:
>>>>
>>>>> Acked-by: Kiran Patil <kiran.patil@intel.com>
>>>>
>>>> Where's the call to preempt_disable() to prevent kernels with
>>>> preemption
>>>> from making numa_node_id() invalid during this iteration?
>>>
>>> David asked this question twice, received no answer and now the patch
>>> is in the maintainer tree, destined for mainline.
>>>
>>> If I was asked this question I would respond
>>>
>>>    The use of numa_mem_id() is racy and best-effort.  If the unlikely
>>>    race occurs, the memory allocation will occur on the wrong node, the
>>>    overall result being very slightly suboptimal performance.  The
>>>    existing use of numa_node_id() suffers from the same issue.
>>>
>>> But I'm not the person proposing the patch.  Please don't just ignore
>>> reviewer comments!
>> Hi Andrew,
>>     Apologize for the slow response due to personal reasons!
>> And thanks for answering the question from David. To be honest,
>> I didn't know how to answer this question before. Actually this
>> question has puzzled me for a long time when dealing with memory
>> hot-removal. For normal cases, it only causes sub-optimal memory
>> allocation if schedule event happens between querying NUMA node id
>> and calling alloc_pages_node(). But what happens if system run into
>> following execution sequence?
>> 1) node = numa_mem_id();
>> 2) memory hot-removal event triggers
>> 2.1) remove affected memory
>> 2.2) reset pgdat to zero if node becomes empty after memory removal
> 
> I'm sorry if I misunderstand something.
> After commit b0dc3a342af36f95a68fe229b8f0f73552c5ca08, there is no
> memset().
Hi Kamezawa,
	Thanks for the information. The commit solved the issue what
I was puzzling about. With this change applied, thing should work
as expected. Seems it would be better to enhance __build_all_zonelists()
to handle those offlined empty nodes too, but that really doesn't
make to much difference:)
	Thanks for the info again!
Thanks!
Gerry
