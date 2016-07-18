From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date: Mon, 18 Jul 2016 21:04:30 +0200
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <20160718154512.GK5871@two.firstfloor.org>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <20160718154512.GK5871@two.firstfloor.org>
Message-ID: <7a03a353-4c1e-2bb4-2550-f84fc4cc79ac@stressinduktion.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 18.07.2016 17:45, Andi Kleen wrote:
>> It seems strange to me to add such policies to the kernel.
>> Addmittingly, documentation of some settings is non-existent and one needs
>> various different tools to set this (sysctl, procfs, sysfs, ethtool, etc).
> 
> The problem is that different applications need different policies.

I fear that if those policies get changed in future, people will rely on
some of their side-effects, causing us to add more and more policies
which basically just differ in those side-effects.

If you compare your policies to madvise or fadvise options, they seem a
have a much more strict and narrower effects, which can be reasoned much
more easily about.

> The only entity which can efficiently negotiate between different
> applications' conflicting requests is the kernel. And that is pretty 
> much the basic job description of a kernel: multiplex hardware
> efficiently between different users.

The multiplexing part seems to be not really relevant for the per-device
settings, thus being controllable from current user space just fine.
Per-task setting could be conflicting with per-socket settings which
could lead to non-deterministic behavior. Probably semantically it
should be made clear what overrides what here (here == cover letter).
Things like indeterminate allocation of sockets in a threaded
environment come to my mind. Also allocation strategy could very much
depend on the installed rss key.

> So yes the user space tuning approach works for simple cases
> ("only run workloads that require the same tuning"), but is ultimately not
> very interesting nor scalable.

I wonder if this can be attacked from a different angle. What would be
missing to add support for this in user space? The first possibility
that came to my mind is to just multiplex those hints in the kernel.
Implement a generic way to add metadata to sockets and allow tuning
daemons to retrieve them via sockdiag? I could imagine that if the
SO_INCOMING_CPU information would be visible in sockdiag, one could
already do more automatic tuning and basically allow to implement your
policy in user space.

Bye,
Hannes

