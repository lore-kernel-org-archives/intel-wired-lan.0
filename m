From: tndave <tushar.n.dave@oracle.com>
Date: Mon, 22 May 2017 16:13:24 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: Use le32_to_cpu before
	evaluating HW desc fields.
In-Reply-To: <1495481779.4878.6.camel@intel.com>
References: <1493680559-6728-1-git-send-email-tushar.n.dave@oracle.com>
 <1494976037.40313.1.camel@intel.com>
 <8607da8f-51fa-b3e5-2b71-a28863f1fe84@oracle.com>
 <1495481779.4878.6.camel@intel.com>
Message-ID: <9f105a6c-2f55-6ad5-1140-03c37340bba1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 05/22/2017 12:36 PM, Jeff Kirsher wrote:
> On Fri, 2017-05-19 at 18:12 -0700, tndave wrote:
>> On 05/16/2017 04:07 PM, Jeff Kirsher wrote:
>>> On Mon, 2017-05-01 at 16:15 -0700, Tushar Dave wrote:
>>>> i40e hardware descriptor fields are in little-endian format. Driver
>>>> must use le32_to_cpu while evaluating these fields otherwise on
>>>> big-endian arch we end up evaluating incorrect values, cause errors
>>>> like:
>>>>
>>>> i40evf 0001:04:02.0: Expected response 0 from PF, received 285212672
>>>> i40evf 0001:04:02.1: Expected response 0 from PF, received 285212672
>>>>
>>>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++--
>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> Due to recent patches already applied to my tree, this patch does not
>>> apply cleanly.  Feel free to send an updated patch, if the change is
>>> still needed.
>>
>> Hi Jeff,
>>
>> I just tried the same patch on Dave's latest linux-net and it applies
>> cleanly. Wondering if I should clone your tree and make sure it applies?
>> If so, I may need to do same for all my future patches as well, thats a
>> extra bit of work!
>>
>> Most of the time, mine are bug fixes and I always use linux-net when
>> upstreaming my patches for Intel Ethernet drivers.
>
> As Alex has already pointed out, yes, you should be using my dev-queue
> branch on either next-queue or net-queue trees.  As you know, I have a
> number of patches currently in the queue which won't show up on linux-net
> until they get pushed to David Miller.
>
> If you use my tree for the Intel drivers, you may find we already fix the
> issue or your fix may need to be re-worked due to changes in the code which
> are currently in the "queue".
Jeff,

Tried the same patch (using git am) on your net-queue tree
branch:dev-queue and the patch applies cleanly.

FYI, right now 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/net-queue.git:dev-queue 
has top commit:
  "i40e/i40evf: proper update of the page_offset field"

My system has:  patch --version
GNU patch 2.7.1

Thanks.
-Tushar
>
