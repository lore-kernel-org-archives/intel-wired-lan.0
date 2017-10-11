From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 11 Oct 2017 14:38:46 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 3/5] net/sched:
	Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <20171011065809.GB2039@nanopsycho>
References: <20171011004400.14946-1-vinicius.gomes@intel.com>
 <20171011004400.14946-4-vinicius.gomes@intel.com>
 <20171011065809.GB2039@nanopsycho>
Message-ID: <87vajlmkk9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jiri Pirko <jiri@resnulli.us> writes:

[...]

>>+struct tc_cbs_qopt_offload {
>>+	u8 enable;
>>+	s32 queue;
>>+	s32 hicredit;
>>+	s32 locredit;
>>+	s32 idleslope;
>>+	s32 sendslope;
>
> Please introduce the qdisc in one patch, then offload it in second. That
> is what I requested already. 2 patches please.
>
> [...]

Will move these declarations to the offload patch.

>
>
>>+static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
>>+	.next		=	NULL,
>
> It is already 0, no need to re-init.

Will fix.


Cheers,
--
Vinicius
