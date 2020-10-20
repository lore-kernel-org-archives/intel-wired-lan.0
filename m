From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Tue, 20 Oct 2020 10:39:38 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201020134128.GT2628@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
 <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
 <20201020134128.GT2628@hirez.programming.kicks-ass.net>
Message-ID: <6736e643-d4ae-9919-9ae1-a73d5f31463e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/20/20 9:41 AM, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 09:00:01AM -0400, Nitesh Narayan Lal wrote:
>> On 10/20/20 3:30 AM, Peter Zijlstra wrote:
>>> On Mon, Oct 19, 2020 at 11:00:05AM -0300, Marcelo Tosatti wrote:
>>>>> So I think it is important to figure out what that driver really wants
>>>>> in the nohz_full case. If it wants to retain N interrupts per CPU, and
>>>>> only reduce the number of CPUs, the proposed interface is wrong.
>>>> It wants N interrupts per non-isolated (AKA housekeeping) CPU.
>>> Then the patch is wrong and the interface needs changing from @min_vecs,
>>> @max_vecs to something that expresses the N*nr_cpus relation.
>> Reading Marcelo's comment again I think what is really expected is 1
>> interrupt per non-isolated (housekeeping) CPU (not N interrupts).
> Then what is the point of them asking for N*nr_cpus when there is no
> isolation?
>
> Either everybody wants 1 interrupts per CPU and we can do the clamp
> unconditionally, in which case we should go fix this user, or they want
> multiple per cpu and we should go fix the interface.
>
> It cannot be both.

Based on my understanding I don't think this is consistent, the number
of interrupts any driver can request varies to an extent that some
consumer of this API even request just one interrupt for its use.

This was one of the reasons why I thought of having a conditional
restriction.

But I agree there is a lack of consistency.

-- 
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201020/807f3acc/attachment-0001.asc>
