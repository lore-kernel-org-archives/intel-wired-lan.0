From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 16 Oct 2017 15:13:12 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 4/6] net/sched:
	Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00979BC@AcuExch.aculab.com>
References: <20171013004005.17416-1-vinicius.gomes@intel.com>
 <20171013004005.17416-5-vinicius.gomes@intel.com>
 <20171013195924.GA19439@khorivan>
 <063D6719AE5E284EB5DD2968C1650D6DD00979BC@AcuExch.aculab.com>
Message-ID: <87376in3lz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi David,

David Laight <David.Laight@ACULAB.COM> writes:

[...]

>> > index 099bf5528fed..41e349df4bf4 100644
>> > --- a/include/uapi/linux/pkt_sched.h
>> > +++ b/include/uapi/linux/pkt_sched.h
>> > @@ -871,4 +871,22 @@ struct tc_pie_xstats {
>> >  	__u32 maxq;             /* maximum queue size */
>> >  	__u32 ecn_mark;         /* packets marked with ecn*/
>> >  };
>> > +
>> > +/* CBS */
>> > +struct tc_cbs_qopt {
>> > +	__u8 offload;
>
> You probably don't want unnamed padding in a uapi structure.

Yeah, this needs to be fixed.

>
>> > +	__s32 hicredit;
>> > +	__s32 locredit;
>> > +	__s32 idleslope;
>> > +	__s32 sendslope;
>> > +};
>> > +
>> > +enum {
>> > +	TCA_CBS_UNSPEC,
>> > +	TCA_CBS_PARMS,
>> > +	__TCA_CBS_MAX,
>> > +};
>> > +
>> > +#define TCA_CBS_MAX (__TCA_CBS_MAX - 1)
>
> Why not:
> 	TCA_CBS_PARMS,
> 	TCA_CBS_NEXT,
> 	TCA_CBS_MAX = TCA_CBS_NEXT - 1,

The way it is proposed, at least is consistent with the rest of the
file. So, if you don't have any stronger reasons, I'd like to keep it
this way.

>
> ...
> 	David


Cheers,
--
Vinicius
