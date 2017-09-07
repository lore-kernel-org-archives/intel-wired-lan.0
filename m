From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 7 Sep 2017 17:53:15 +0200
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907152751.GA9064@sisyphus.home.austad.us>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
 <20170907124018.deinzo3c4ice3q7n@localhost>
 <20170907152751.GA9064@sisyphus.home.austad.us>
Message-ID: <20170907155315.5gqy5e4susl25wa2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 07, 2017 at 05:27:51PM +0200, Henrik Austad wrote:
> On Thu, Sep 07, 2017 at 02:40:18PM +0200, Richard Cochran wrote:
> And if you want to this driver to act as a bridge, how do you accomodate 
> change in network requirements? (i.e. how does this work with switchdev?)

To my understanding, this Qdisc idea provides QoS for the host's
transmitted traffic, and nothing more.

> - Or am I overthinking this?

Being able to configure the external ports of a switchdev is probably
a nice feature, but that is another story.  (But maybe I misunderstood
the authors' intent!)

> If you have more than 1 application in userspace that wants to send data 
> using this scheduler, how do you ensure fair transmission of frames? (both 
> how much bandwidth they use,

There are many ways to handle this, and we shouldn't put any of that
policy into the kernel.  For example, there might be a monolithic
application with configurable threads, or an allocation server that
grants bandwidth to applications via IPC, or a multiplexing stream
server like jack, pulse, etc, and so on...

> but also ordering of frames from each application)

Not sure what you mean by this.

> Do you expect all of this to be handled in userspace?

Yes, I do.

Thanks,
Richard



