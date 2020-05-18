From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 18 May 2020 15:06:26 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200518135613.379f6a63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <87wo59oyhr.fsf@intel.com>
 <20200518135613.379f6a63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <87h7wcq4nx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Jakub Kicinski <kuba@kernel.org> writes:
>
> Please take a look at the example from the cover letter:
>
> $ ethtool $ sudo ./ethtool --show-frame-preemption
> enp3s0 Frame preemption settings for enp3s0:
> 	support: supported
> 	active: active
> 	supported queues: 0xf
> 	supported queues: 0xe
> 	minimum fragment size: 68
>
> Reading this I have no idea what 0xe is. I have to go and query TC API
> to see what priorities and queues that will be. Which IMHO is a strong
> argument that this information belongs there in the first place.

That was the (only?) strong argument in favor of having frame preemption
in the TC side when this was last discussed.

We can have a hybrid solution, we can move the express/preemptible per
queue map to mqprio/taprio/whatever. And have the more specific
configuration knobs, minimum fragment size, etc, in ethtool.

What do you think?


Cheers,
-- 
Vinicius
