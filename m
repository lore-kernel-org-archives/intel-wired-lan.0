From: Andi Kleen <andi@firstfloor.org>
Date: Mon, 18 Jul 2016 12:43:57 -0700
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <7a03a353-4c1e-2bb4-2550-f84fc4cc79ac@stressinduktion.org>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <20160718154512.GK5871@two.firstfloor.org>
 <7a03a353-4c1e-2bb4-2550-f84fc4cc79ac@stressinduktion.org>
Message-ID: <20160718194357.GL5871@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> I wonder if this can be attacked from a different angle. What would be
> missing to add support for this in user space? The first possibility
> that came to my mind is to just multiplex those hints in the kernel.

"just" is the handwaving part here -- you're proposing a micro kernel
approach where part of the multiplexing job that the kernel is doing
is farmed out to a message passing user space component.

I suspect this would be far more complicated to get right and
perform well than a straight forward monolithic kernel subsystem --
which is traditionally how Linux has approached things.

The daemon would always need to work with out of date state
compared to the latest, because it cannot do any locking with the
kernel state.  So you end up with a complex distributed system with multiple
agents "fighting" with each other, and the tuning agent
never being able to keep up with the actual work.

Also of course it would be fundamentally less efficient than
kernel code doing that, just because of the additional context
switches needed.

-Andi
