From: Florian Westphal <fw@strlen.de>
Date: Mon, 18 Jul 2016 18:17:28 +0200
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07712C1968E@SHSMSX103.ccr.corp.intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <20160718151841.GA19066@breakpoint.cc>
 <37D7C6CF3E00A74B8858931C1DB2F07712C1968E@SHSMSX103.ccr.corp.intel.com>
Message-ID: <20160718161728.GB19066@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Liang, Kan <kan.liang@intel.com> wrote:
> > What is missing in the kernel UAPI so userspace could do these settings on its
> > own, without adding this policy stuff to the kernel?
> 
> The main purpose of the proposal is to simplify the configuration. Too many
> options will let them confuse. 
> For normal users, they just need to tell the kernel that they want high throughput
> for the application. The kernel will take care of the rest.
> So, I don't think we need an interface for user to set their own policy settings.

I don't (yet) agree that the kernel is the right place for this.
I agree that current (bare) kernel config interface(s) for this are
hard to use.

> > It seems strange to me to add such policies to the kernel.
> 
> But kernel is the only place which can merge all user's requests.

I don't think so.

If different requests conflict in a way that is possible to do something
meaningful the I don't see why userspace tool cannot do the same
thing...

> > Addmittingly, documentation of some settings is non-existent and one needs
> > various different tools to set this (sysctl, procfs, sysfs, ethtool, etc).
> > 
> > But all of these details could be hidden from user.
> > Have you looked at tuna for instance?
> 
> Not yet. Is there similar settings for network?

Last time I checked tuna could only set a few network-related sysctls
and handle irq settings/affinity, but not e.g. tune irq coalescening
or any other network interface specific settings.
