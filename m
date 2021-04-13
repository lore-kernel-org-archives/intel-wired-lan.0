From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Tue, 13 Apr 2021 19:21:00 +0200
Subject: [Intel-wired-lan] [PATCH RFC net] igb: Fix XDP with PTP enabled
In-Reply-To: <CAKgT0UekqPNQxV6PzpEeis69z3e3YNcaFyot=nD7w26hLxPX2Q@mail.gmail.com>
References: <20210412101713.15161-1-kurt@linutronix.de>
 <20210412162846.42706d99@carbon>
 <CAKgT0UekqPNQxV6PzpEeis69z3e3YNcaFyot=nD7w26hLxPX2Q@mail.gmail.com>
Message-ID: <87fszuyubn.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue Apr 13 2021, Alexander Duyck wrote:
> On Mon, Apr 12, 2021 at 7:29 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
>> > +ktime_t igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va)
>> >  {
>> >       struct igb_adapter *adapter = q_vector->adapter;
>> > +     struct skb_shared_hwtstamps ts;
>> >       __le64 *regval = (__le64 *)va;
>> >       int adjust = 0;
>> >
>> >       if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
>> > -             return IGB_RET_PTP_DISABLED;
>> > +             return 0;
>> >
>> >       /* The timestamp is recorded in little endian format.
>> >        * DWORD: 0        1        2        3
>> > @@ -888,10 +887,9 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
>> >
>> >       /* check reserved dwords are zero, be/le doesn't matter for zero */
>> >       if (regval[0])
>> > -             return IGB_RET_PTP_INVALID;
>> > +             return 0;
>> >
>
> One thing that needs to be cleaned up in the patch is that if it is
> going to drop these return values it should probably drop the defines
> for them since I don't think they are used anywhere else.

Yes, of course. I'll clean it up before sending a non RFC version.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210413/d3b3f8ec/attachment.asc>
