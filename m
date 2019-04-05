From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 04 Apr 2019 18:32:16 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v1] igb: Fix limiting the
 number of queues to number of cpus
In-Reply-To: <461c66428b411644e78ad5a9a44c47442c9b6edf.camel@intel.com>
References: <20190404215632.9881-1-vinicius.gomes@intel.com>
 <461c66428b411644e78ad5a9a44c47442c9b6edf.camel@intel.com>
Message-ID: <87bm1lck4f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Jeff Kirsher <jeffrey.t.kirsher@intel.com> writes:

> A module parameter maybe fine for our out-of-tree driver, but not for the
> kernel driver.
>
> NACK on the basis that a new module parameter is being introduced for the
> driver.  This is not acceptable by Dave Miller or myself.  As of now, I do
> not have a alternative solution to propose unfortunately.

I understand completely. This patch already served its purpose :-)

>
> I will discuss the issue with my fellow developers and hopefully we can
> come up with a kernel interface that all drivers can use to handle this
> issue.

Thank you.

If it helps, the only other alternative I can think of is a sysctl knob,
something like:

net.core.netdev_max_num_queues

And the default value would be the number of cpus.

Cheers,
--
Vinicius
