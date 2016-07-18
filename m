From: Andi Kleen <andi@firstfloor.org>
Date: Mon, 18 Jul 2016 08:45:12 -0700
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <20160718151841.GA19066@breakpoint.cc>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
Message-ID: <20160718154512.GK5871@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> It seems strange to me to add such policies to the kernel.
> Addmittingly, documentation of some settings is non-existent and one needs
> various different tools to set this (sysctl, procfs, sysfs, ethtool, etc).

The problem is that different applications need different policies.

The only entity which can efficiently negotiate between different
applications' conflicting requests is the kernel. And that is pretty 
much the basic job description of a kernel: multiplex hardware
efficiently between different users.

So yes the user space tuning approach works for simple cases
("only run workloads that require the same tuning"), but is ultimately not
very interesting nor scalable.

-Andi
