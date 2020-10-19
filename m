From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 19 Oct 2020 10:25:14 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201019140005.GB17287@fuller.cnet>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
Message-ID: <48a2a9a1-d664-6770-e088-27a7786e0f7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/19/20 10:00 AM, Marcelo Tosatti wrote:
> On Mon, Oct 19, 2020 at 01:11:37PM +0200, Peter Zijlstra wrote:
>> On Sun, Oct 18, 2020 at 02:14:46PM -0400, Nitesh Narayan Lal wrote:

[...]

>>>> Also, do we really need to have that conditional on hk_cpus <
>>>> num_online_cpus()? That is, why can't we do this unconditionally?
>>> FWIU most of the drivers using this API already restricts the number of
>>> vectors based on the num_online_cpus, if we do it unconditionally we can
>>> unnecessary duplicate the restriction for cases where we don't have any
>>> isolated CPUs.
>> unnecessary isn't really a concern here, this is a slow path. What's
>> important is code clarity.

Right, I can skip that check then.

>>
>>> Also, different driver seems to take different factors into consideration
>>> along with num_online_cpus while finding the max_vecs to request, for
>>> example in the case of mlx5:
>>> MLX5_CAP_GEN(dev, num_ports) * num_online_cpus() +
>>> ?????????????? MLX5_EQ_VEC_COMP_BASE
>>>
>>> Having hk_cpus < num_online_cpus() helps us ensure that we are only
>>> changing the behavior when we have isolated CPUs.
>>>
>>> Does that make sense?
>> That seems to want to allocate N interrupts per cpu (plus some random
>> static amount, which seems weird, but whatever). This patch breaks that.
> On purpose. For the isolated CPUs we don't want network device 
> interrupts (in this context).
>
>> So I think it is important to figure out what that driver really wants
>> in the nohz_full case. If it wants to retain N interrupts per CPU, and
>> only reduce the number of CPUs, the proposed interface is wrong.
> It wants N interrupts per non-isolated (AKA housekeeping) CPU.
> Zero interrupts for isolated interrupts.

Right, otherwise we may end up in a situation where we run out of per CPU
vectors while we move the IRQs from isolated CPUs to housekeeping.


-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201019/c70b8a10/attachment-0001.asc>
