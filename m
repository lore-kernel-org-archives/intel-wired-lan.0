From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Tue, 20 Oct 2020 09:00:01 -0400
Subject: [Intel-wired-lan] [PATCH v4 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20201020073055.GY2611@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-5-nitesh@redhat.com>
 <20201016122046.GP2611@hirez.programming.kicks-ass.net>
 <79f382a7-883d-ff42-394d-ec4ce81fed6a@redhat.com>
 <20201019111137.GL2628@hirez.programming.kicks-ass.net>
 <20201019140005.GB17287@fuller.cnet>
 <20201020073055.GY2611@hirez.programming.kicks-ass.net>
Message-ID: <078e659e-d151-5bc2-a7dd-fe0070267cb3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/20/20 3:30 AM, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 11:00:05AM -0300, Marcelo Tosatti wrote:
>>> So I think it is important to figure out what that driver really wants
>>> in the nohz_full case. If it wants to retain N interrupts per CPU, and
>>> only reduce the number of CPUs, the proposed interface is wrong.
>> It wants N interrupts per non-isolated (AKA housekeeping) CPU.
> Then the patch is wrong and the interface needs changing from @min_vecs,
> @max_vecs to something that expresses the N*nr_cpus relation.

Reading Marcelo's comment again I think what is really expected is 1
interrupt per non-isolated (housekeeping) CPU (not N interrupts).

My bad that I missed it initially.

-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201020/3d789976/attachment-0001.asc>
