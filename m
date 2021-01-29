From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 29 Jan 2021 15:12:58 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <20210129135702.0f8cf702@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-3-vinicius.gomes@intel.com>
 <20210126000924.jjkjruzmh5lgrkry@skbuf>
 <87wnvvsayz.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210129135702.0f8cf702@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <878s8bs5fp.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org> writes:
>> > First I'm interested in the means: why check for preempt == U32_MAX when
>> > you determine that all traffic classes are preemptible? What if less
>> > than 32 traffic classes are used by the netdev? The check will be
>> > bypassed, won't it?  
>> 
>> Good catch :-)
>> 
>> I wanted to have this (at least one express queue) handled in a
>> centralized way, but perhaps this should be handled best per driver.
>
> Centralized is good. Much easier than reviewing N drivers to make sure
> they all behave the same, and right.

The issue is that it seems that not all drivers/hw have the same
limitation: that at least one queue needs to be configured as
express/not preemptible.

That's the point I was trying to make when I suggested for the check to
be done per-driver, different limitations.


Cheers,
-- 
Vinicius
