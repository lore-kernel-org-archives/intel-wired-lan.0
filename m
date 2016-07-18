From: Florian Westphal <fw@strlen.de>
Date: Mon, 18 Jul 2016 17:18:41 +0200
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <20160718151841.GA19066@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

kan.liang at intel.com <kan.liang@intel.com> wrote:
> From: Kan Liang <kan.liang@intel.com>
> 
> It is a big challenge to get good network performance. First, the network
> performance is not good with default system settings. Second, it is too
> difficult to do automatic tuning for all possible workloads, since workloads
> have different requirements. Some workloads may want high throughput.

Seems you did lots of tests to find optimal settings for a given base
policy.

What is missing in the kernel UAPI so userspace could do these settings
on its own, without adding this policy stuff to the kernel?

It seems strange to me to add such policies to the kernel.
Addmittingly, documentation of some settings is non-existent and one needs
various different tools to set this (sysctl, procfs, sysfs, ethtool, etc).

But all of these details could be hidden from user.
Have you looked at tuna for instance?
