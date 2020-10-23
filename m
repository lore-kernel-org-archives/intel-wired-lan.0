From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Fri, 23 Oct 2020 09:10:41 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201023085826.GP2611@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
 <20201020134128.GT2628@hirez.programming.kicks-ass.net>
 <6736e643-d4ae-9919-9ae1-a73d5f31463e@redhat.com>
 <260f4191-5b9f-6dc1-9f11-085533ac4f55@redhat.com>
 <20201023085826.GP2611@hirez.programming.kicks-ass.net>
Message-ID: <9ee77056-ef02-8696-5b96-46007e35ab00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/23/20 4:58 AM, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 01:47:14PM -0400, Nitesh Narayan Lal wrote:
>
>> Hi Peter,
>>
>> So based on the suggestions from you and Thomas, I think something like the
>> following should do the job within pci_alloc_irq_vectors_affinity():
>>
>> + ? ? ? if (!pci_is_managed(dev) && (hk_cpus < num_online_cpus()))
>> + ? ? ? ? ? ? ? max_vecs = clamp(hk_cpus, min_vecs, max_vecs);
>>
>> I do know that you didn't like the usage of "hk_cpus < num_online_cpus()"
>> and to an extent I agree that it does degrade the code clarity.
> It's not just code clarity; I simply don't understand it. It feels like
> a band-aid that breaks thing.
>
> At the very least it needs a ginormous (and coherent) comment that
> explains:
>
>  - the interface
>  - the usage
>  - this hack

That make sense.

>
>> However, since there is a certain inconsistency in the number of vectors
>> that drivers request through this API IMHO we will need this, otherwise
>> we could cause an impact on the drivers even in setups that doesn't
>> have any isolated CPUs.
> So shouldn't we then fix the drivers / interface first, to get rid of
> this inconsistency?
>

Considering we agree that excess vector is a problem that needs to be
solved across all the drivers and that you are comfortable with the other
three patches in the set. If I may suggest the following:

- We can pick those three patches for now, as that will atleast fix a
? driver that is currently impacting RT workloads. Is that a fair
? expectation?

- In the meanwhile, I will start looking into individual drivers that
? consume this API to find out if there is a co-relation that can be
? derived between the max_vecs and number of CPUs. If that exists then I
? can go ahead and tweak the API's max_vecs accordingly. However, if this
? is absolutely random then I can come up with a sane comment
? before this check that covers the list of items you suggested.

- I also want to explore the comments made by Thomas which may take
? some time.


-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201023/2ac925b4/attachment-0001.asc>
