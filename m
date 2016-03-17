From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 17 Mar 2016 12:28:14 -0700
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <20160317185614.GA14078@oracle.com>
References: <20160314214333.GP5084@oracle.com> <56E7A7B6.5030209@gmail.com>
 <56E7CE18.9020004@gmail.com> <20160315105433.GC11063@oracle.com>
 <56E8D0C5.307@gmail.com> <20160316032523.GC19052@oracle.com>
 <56E94786.9090701@gmail.com> <20160316143654.GD21307@oracle.com>
 <56EA1481.80600@gmail.com> <20160317185614.GA14078@oracle.com>
Message-ID: <20160317122814.00000adf@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 17 Mar 2016 14:56:14 -0400
Sowmini Varadhan <sowmini.varadhan@oracle.com> wrote:

> On (03/17/16 10:20), zhuyj wrote:
> > 1. modprobe NET_PKTGEN
> > 
> > 2. download the tar file and uncompress to any directory.
> > This tar file is from kernel. It is in samples/pktgen/
> > 
> > 3. cd pktgen
> > 
> > 4. pktgen_sample02_multiqueue.sh -i ethx -s size -t cpu_number
> 
> Indeed, I see the same thing as you, and it was very easy to 
> reproduce. It was very interesting that the problem can happen with
> as few as 3 threads, at which point I see the TX hang at exactly
> -s 12305 

Okay, sorry I hadn't jumped into this thread yet.

I can uniquivically tell you that what Sowmini saw with the MDD with
stack based RDS-STRESS testing is *NOT* the same as what you're seeing
while using pktgen with invalid huge skb->data buffers.

We can ask on netdev if the driver should defend against this kind of
input to hard_start_xmit (transmit routine), but the driver doesn't
check the maximum length of the skb to see if it is invalid, because
the stack can never build (only pktgen can) these invalid SKBs.

The issue is that pktgen builds skb->data with a contiguous buffer of
whatever size transmit requested, (regardless of MTU) and then sends it
straight to the transmit routine, no segmentation flags, no MSS set.

This causes the driver to build a transmit descriptor with an invalid
length, which the hardware then "ASSERTS" on by issuing an MDD
interrupt and freezing the bad acting queue.

> I see:
> i40e 0000:82:00.0: TX driver issue detected, PF reset issued
> i40e 0000:82:00.0 eth2: VSI_seid 390, Hung TX queue 0, tx_pending: 492, NTC:0x140, HWB: 0x140, NTU: 0x12c, TAIL: 0x12c
> 
> I think the common factor in both our test cases is that we have some
> kernel thread that can efficiently send packets without any context
> switches. 

You've found a red herring (mistakenly connected two separate events)
so I think you can stop going down this path (pktgen).

> Has anyone here seen this before? I'll see if I can find some cycles
> to figure this out, if not, maybe its worth bringing up on netdev,
> to see if others have seen this, and to draw some patterns.

we don't need to bring it up on netdev.  We have a way to troubleshoot
MDDs that I can send to you, if you want to do the work.  Otherwise we
need to have some time to reproduce here.

> > If size is set to a big number, the similar defect will occur.
> > Adjust this size to a appropriate number, my defect will not occur.
> > 
> > In the test, I found some types igb nic, such as i210, will work
> > well no matter the size is a big number.
> > some nic, such as 82580, it will not work well if the size is too big.

This is mostly a combination of driver implementation and how the
hardware handles a descriptor that is too large.  The driver *could*
check to make sure the skb->data is never too large, but in that same
vein, we *could* fix pktgen to never send a frame greater than MTU down
to the driver.

> > 
> > As such, I think my problem results from the hardware and the big
> > size triggers this problem.
> > 
> > I hope this can help us all.

Unfortunately Zhu's problem with pktgen is not a reproducer of
Sowmini's problem.

In the case of pktgen, it is a "don't do that, because it hurts" kind of
bug. In the case of rds-stress, we need to reproduce it here and figure
out what hardware constraint the driver is violating during set up of
the transmit.

