From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 13 Oct 2017 10:12:18 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 4/6] net/sched:
	Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <1507862553.31614.53.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20171013004005.17416-1-vinicius.gomes@intel.com>
 <20171013004005.17416-5-vinicius.gomes@intel.com>
 <1507862553.31614.53.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <87efq7m0p9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Eric Dumazet <eric.dumazet@gmail.com> writes:

[...]

>
> Your mixing of s64 and u64 is disturbing.
>
> do_div() handles u64, not s64.
>
> div64_s64() might be needed in place of do_div()

I wasn't very comfortable about the signal juggling either. Didn't know
about div64_s64(), looks much better. Will fix, thanks.


Cheers,
--
Vinicius
