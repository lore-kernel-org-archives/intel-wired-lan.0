From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 26 Nov 2018 19:32:44 +0530
Subject: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <bcf609de-c60a-d6ad-7acb-6c59c412adbc@redhat.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
 <bcf609de-c60a-d6ad-7acb-6c59c412adbc@redhat.com>
Message-ID: <20049f8a-b68f-8af2-c4c7-9410781f37fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/26/2018 06:18 PM, David Hildenbrand wrote:
> On 26.11.18 13:26, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Added inclusion of 'numa.h' header at various places per Andrew
>> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks David. My bad, forgot to add your review tag from the earlier version.
