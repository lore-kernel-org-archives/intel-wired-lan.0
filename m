From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 16 Nov 2017 11:33:58 -0800
Subject: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
In-Reply-To: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <20171116113358.00001d5a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 16 Nov 2017 09:37:48 -0600
Brian King <brking@linux.vnet.ibm.com> wrote:

> Resending as the first attempt is not showing up in the list archive.
> 
> This patch converts several network drivers to use smp_rmb
> rather than read_barrier_depends. The initial issue was
> discovered with ixgbe on a Power machine which resulted
> in skb list corruption due to fetching a stale skb pointer.
> More details can be found in the ixgbe patch description.

Thanks for the fix Brian, I bet it was a tough debug.

The only users in the entire kernel of read_barrier_depends() (not
smp_read_barrier_depends) are the Intel network drivers.

Wouldn't it be better for power to just fix read_barrier_depends to do
the right thing on power? The question I'm not sure of the answer to is:
Is it really the wrong barrier to be using or is the implementation in
the kernel powerpc wrong?

So I think the right thing might actually to be to:
Fix arch powerpc read_barrier_depends to not be a noop, as the
semantics of the read_barrier_depends seems to be sufficient to solve
this problem, but it seems not to work for powerpc?

Alex Duyck may have the most clarity on this problem, and possible
solutions so I made sure to CC him.
