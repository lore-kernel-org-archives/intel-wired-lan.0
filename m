From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 18 May 2020 16:09:06 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <87blmkq1y3.fsf@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <87wo59oyhr.fsf@intel.com>
 <20200518135613.379f6a63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87h7wcq4nx.fsf@intel.com>
 <20200518152259.29d2e3c7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87blmkq1y3.fsf@intel.com>
Message-ID: <20200518160906.40e9d8bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 May 2020 16:05:08 -0700 Vinicius Costa Gomes wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> >> That was the (only?) strong argument in favor of having frame preemption
> >> in the TC side when this was last discussed.
> >> 
> >> We can have a hybrid solution, we can move the express/preemptible per
> >> queue map to mqprio/taprio/whatever. And have the more specific
> >> configuration knobs, minimum fragment size, etc, in ethtool.
> >> 
> >> What do you think?  
> >
> > Does the standard specify minimum fragment size as a global MAC setting?  
> 
> Yes, it's a per-MAC setting, not per-queue. 

If standard defines it as per-MAC and we can reasonably expect vendors
won't try to "add value" and make it per queue (unlikely here AFAIU),
then for this part ethtool configuration seems okay to me.
