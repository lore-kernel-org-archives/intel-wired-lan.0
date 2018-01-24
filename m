From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 24 Jan 2018 14:46:24 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180124030436.sukodrg2t3ckazu6@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost> <877es81d9e.fsf@intel.com>
 <20180124030436.sukodrg2t3ckazu6@localhost>
Message-ID: <87607qzxhb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> On Tue, Jan 23, 2018 at 01:22:37PM -0800, Vinicius Costa Gomes wrote:
>> What I think would be the ideal scenario would be if the clockid
>> parameter to the TBS Qdisc would not be necessary (if offload was
>> enabled), but that's not quite possible right now, because there's no
>> support for using the hrtimer infrastructure with dynamic clocks
>> (/dev/ptp*).
>
> We don't need hrtimer for HW offloading.  Just enqueue the packets.  I
> thought we agreed that user space get the ordering correct.  In fact,
> davem insisted on it, IIRC.

About the ordering of packets, From here [1], there are 3 clear points
(in my understanding):

1. Re-ordering of TX descriptors on the device queue should/must not
   happen;

2. Out of order requests are an error;

3. Timestamps in the past are an error;

The only robust way that we could think of about keeping the the packets
in order for the device queue is re-ordering packets in the Qdisc.

We tried to reach out for confirmation [2] of this understanding but
didn't receive any word.

Even if we reach a decision that the Qdisc should not re-order packets
(we wouldn't have any dependency on hrtimers in the offload case, as you
pointed out), we still need hrtimers for the software implementation.

So, I guess, the problem remains, if it's possible for the user to
express a /dev/ptp* clock, what should we do? 

>
> Thanks,
> Richard

Cheers,
--
Vinicius


[1] https://patchwork.ozlabs.org/comment/1770302/

[2] https://patchwork.ozlabs.org/comment/1816492/q
