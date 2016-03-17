From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 17 Mar 2016 14:56:14 -0400
Subject: [Intel-wired-lan] [E1000-devel] i40e card Tx resets
In-Reply-To: <56EA1481.80600@gmail.com>
References: <20160314214333.GP5084@oracle.com> <56E7A7B6.5030209@gmail.com>
 <56E7CE18.9020004@gmail.com> <20160315105433.GC11063@oracle.com>
 <56E8D0C5.307@gmail.com> <20160316032523.GC19052@oracle.com>
 <56E94786.9090701@gmail.com> <20160316143654.GD21307@oracle.com>
 <56EA1481.80600@gmail.com>
Message-ID: <20160317185614.GA14078@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/17/16 10:20), zhuyj wrote:
> 1. modprobe NET_PKTGEN
> 
> 2. download the tar file and uncompress to any directory.
> This tar file is from kernel. It is in samples/pktgen/
> 
> 3. cd pktgen
> 
> 4. pktgen_sample02_multiqueue.sh -i ethx -s size -t cpu_number

Indeed, I see the same thing as you, and it was very easy to 
reproduce. It was very interesting that the problem can happen with
as few as 3 threads, at which point I see the TX hang at exactly
-s 12305 

I see:
i40e 0000:82:00.0: TX driver issue detected, PF reset issued
i40e 0000:82:00.0 eth2: VSI_seid 390, Hung TX queue 0, tx_pending: 492, NTC:0x140, HWB: 0x140, NTU: 0x12c, TAIL: 0x12c

I think the common factor in both our test cases is that we have some
kernel thread that can efficiently send packets without any context
switches. 

Has anyone here seen this before? I'll see if I can find some cycles
to figure this out, if not, maybe its worth bringing up on netdev,
to see if others have seen this, and to draw some patterns.

> 
> If size is set to a big number, the similar defect will occur.
> Adjust this size to a appropriate number, my defect will not occur.
> 
> In the test, I found some types igb nic, such as i210, will work
> well no matter the size is a big number.
> some nic, such as 82580, it will not work well if the size is too big.
> 
> As such, I think my problem results from the hardware and the big
> size triggers this problem.
> 
> I hope this can help us all.
> 
> Zhu Yanjun
