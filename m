From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 16 Mar 2018 14:06:06 -0700
Subject: [Intel-wired-lan] [RFC PATCH 2/5] ixgbevf: Add support for
 XDP_TX action
In-Reply-To: <20180226213745.14508-3-anthony.l.nguyen@intel.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
 <20180226213745.14508-3-anthony.l.nguyen@intel.com>
Message-ID: <a2a3ae8e-771b-7185-434c-91e419adfec0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02/26/2018 01:37 PM, Tony Nguyen wrote:
> This implements the XDP_TX action which is modeled on the ixgbe
> implementation. However instead of using CPU id to determine which XDP
> queue to use, this uses the received RX queue index, which is similar
> to i40e. Doing this eliminates the restriction that number of CPUs not
> exceed number of XDP queues that ixgbe has.
> 

For XDP_TX using the receive queue as the index for tx is going to
solve the fewer queues than CPUs issue however for redirects this
creates a different problem. Namely, how to choose a TX queue and
get exclusive access to it. In ixgbe because everything is aligned
by cpu index we can be guaranteed to have exclusive access to a queue,
that scheme doesn't work with the above.

However, I think that is fine because in general expecting to have
as many driver queues as CPUs in a VM is possibly more of a stretch
than in the hypervisor.

So do you plan to implement xdp_redirect in the future? If so
any ideas how to support that? Maybe look over some of the patches
on the list around this. Also supporting more cpus than queues in
ixgbe is still needed.

Thanks,
John


> Also, based on the number of queues available, the number of TX queues
> may be reduced when an XDP program is loaded in order to accommodate the
> XDP queues.
> 
> Based largely on commit 33fdc82f0883 ("ixgbe: add support for XDP_TX
> action")
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---


[...]
