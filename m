From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 20 Nov 2020 09:58:14 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201120141621.GC7027@hoboy.vegasvil.org>
References: <20201114025704.GA15240@hoboy.vegasvil.org>
 <874klo7pwp.fsf@intel.com> <20201117014926.GA26272@hoboy.vegasvil.org>
 <87d00b5uj7.fsf@intel.com> <20201118125451.GC23320@hoboy.vegasvil.org>
 <87wnyi2o1e.fsf@intel.com> <20201120141621.GC7027@hoboy.vegasvil.org>
Message-ID: <877dqf29mx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> On Wed, Nov 18, 2020 at 04:22:37PM -0800, Vinicius Costa Gomes wrote:
>
>> Talking with the hardware folks, they recommended using the periodic
>> method, the one shot method was implemented as a debug/evaluation aid.
>
> I'm guessing ...
>
> The HW generates pairs of time stamps, right?

Not exactly.

On the PTM protocol there are four timestamps involved:
 - T1, when the NIC sends the Request message;
 - T2, when the PCIe root receives the Request message;
 - T3, when the PCIe root sends the Response message;
 - T4, when the NIC receives the Response message;

The NIC registers expose these values (I am using ' to indicate
timestamps captured on the previous cycle):
 - T1 (on this cycle);
 - T2 and T2' (on this and on the previous cycle);
 - (T4 - T1) and (T4' - T1') (on this and on the previous cycle);
 - (T3' - T2') (on the previous cycle).

Yeah, applications would be most interested in a pair (host, device)
timestamps, but as Miroslav said, a third value expressing the
propagation delay from those values could be also useful.

>
> And these land in the device driver by means of an interrupt, right?

Again, not exactly. I have to either poll for a "valid bit" on a status
register or wait for a "fake" (all zeroes source and destination
addresses) ethernet frame to arrive on a specific queue.

Just for information the "fake" packet has different information:
 - T1 (on this cycle);
 - T2 (on this cycle);
 - (T4' - T1') (on the previous cycle);
 - (T3 - T2) (on this cycle);

>
> If that is so, then maybe the best way to expose the pair to user
> space is to have a readable character device, like we have for the
> PTP_EXTTS_REQUEST2.  The ioctl to enable reporting could also set the
> message rate.

Sounds reasonable.

>
> Although it will be a bit clunky, it looks like we have reserved room
> enough for a second, eight-byte time stamp.

The question is if we want to also expose some of the other values.


Cheers,
-- 
Vinicius
