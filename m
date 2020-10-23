From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Fri, 23 Oct 2020 09:57:53 -0400
Subject: [Intel-wired-lan] [PATCH v4 2/4] sched/isolation: Extend
 nohz_full to isolate managed IRQs
In-Reply-To: <20201023132950.GA47962@lothringen>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-3-nitesh@redhat.com>
 <20201023132505.GZ2628@hirez.programming.kicks-ass.net>
 <20201023132950.GA47962@lothringen>
Message-ID: <804569ba-a980-a4e7-59a7-3ef4ac8660de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/23/20 9:29 AM, Frederic Weisbecker wrote:
> On Fri, Oct 23, 2020 at 03:25:05PM +0200, Peter Zijlstra wrote:
>> On Mon, Sep 28, 2020 at 02:35:27PM -0400, Nitesh Narayan Lal wrote:
>>> Extend nohz_full feature set to include isolation from managed IRQS. This
>> So you say it's for managed-irqs, the feature is actually called
>> MANAGED_IRQ, but, AFAICT, it does *NOT* in fact affect managed IRQs.
>>
>> Also, as per Thomas' earlier points, managed-irqs are in fact perfectly
>> fine and don't need help at at...
>>
>>> is required specifically for setups that only uses nohz_full and still
>>> requires isolation for maintaining lower latency for the listed CPUs.
>>>
>>> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Ah and yes there is this tag :-p
>
> So that's my bad, I really thought this thing was about managed IRQ.
> The problem is that I can't find a single documentation about them so I'm
> too clueless on that matter.

I am also confused with this terminology.
So my bad for not taking care of this.

-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201023/4cfec365/attachment.asc>
