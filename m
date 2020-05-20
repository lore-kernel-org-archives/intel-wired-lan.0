From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 20 May 2020 15:35:44 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <159001094525.59702.8769665430201911136@sdkini-mobl1.amr.corp.intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <87wo59oyhr.fsf@intel.com>
 <20200518135613.379f6a63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87h7wcq4nx.fsf@intel.com>
 <20200518152259.29d2e3c7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87blmkq1y3.fsf@intel.com>
 <20200518160906.40e9d8bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <159001094525.59702.8769665430201911136@sdkini-mobl1.amr.corp.intel.com>
Message-ID: <874ksamdz3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Andre Guedes <andre.guedes@intel.com> writes:

>> If standard defines it as per-MAC and we can reasonably expect vendors
>> won't try to "add value" and make it per queue (unlikely here AFAIU),
>> then for this part ethtool configuration seems okay to me.
>
> Before we move forward with this hybrid approach, let's recap a few points that
> we discussed in the previous thread and make sure it addresses them
> properly.

Thanks for bringing them up.

>
> 1) Frame Preemption (FP) can be enabled without EST, as described in IEEE
> 802.1Q. In this case, the user has to create a dummy EST schedule in taprio
> just to be able to enable FP, which doesn't look natural.

What I meant by "dummy" schedule, is to configure taprio without
specifying any "sched-entry". And since we have support for adding
schedules during runtime, this might be even useful in general.

>
> 2) Mpqrio already looks overloaded. Besides mapping traffic classes into
> hardware queues, it also supports different modes and traffic shaping. Do we
> want to add yet another setting to it?

I also don't see this as a problem. The parameters that mqprio has carry
a lot of information, but the number of them is not that big.


Cheers,
-- 
Vinicius
