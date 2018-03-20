From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 20 Mar 2018 21:08:29 +0000
Subject: [Intel-wired-lan] [RFC PATCH 2/5] ixgbevf: Add support for
 XDP_TX action
In-Reply-To: <a2a3ae8e-771b-7185-434c-91e419adfec0@gmail.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
 <20180226213745.14508-3-anthony.l.nguyen@intel.com>
 <a2a3ae8e-771b-7185-434c-91e419adfec0@gmail.com>
Message-ID: <4C5EDC162D52824D9E7FB1446983F3EEC925F2DB@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: John Fastabend [mailto:john.fastabend at gmail.com]
> Sent: Friday, March 16, 2018 2:06 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Subject: Re: [Intel-wired-lan] [RFC PATCH 2/5] ixgbevf: Add support for XDP_TX
> action
> 
> On 02/26/2018 01:37 PM, Tony Nguyen wrote:
> > This implements the XDP_TX action which is modeled on the ixgbe
> > implementation. However instead of using CPU id to determine which XDP
> > queue to use, this uses the received RX queue index, which is similar
> > to i40e. Doing this eliminates the restriction that number of CPUs not
> > exceed number of XDP queues that ixgbe has.
> >
> 
> For XDP_TX using the receive queue as the index for tx is going to solve the
> fewer queues than CPUs issue however for redirects this creates a different
> problem. Namely, how to choose a TX queue and get exclusive access to it. In
> ixgbe because everything is aligned by cpu index we can be guaranteed to have
> exclusive access to a queue, that scheme doesn't work with the above.
> 
> However, I think that is fine because in general expecting to have as many driver
> queues as CPUs in a VM is possibly more of a stretch than in the hypervisor.
> 
> So do you plan to implement xdp_redirect in the future? If so any ideas how to
> support that? Maybe look over some of the patches on the list around this. Also
> supporting more cpus than queues in ixgbe is still needed.
> 
> Thanks,
> John
> 
There are no immediate plans to implement xdp_redirect.  The current plan is to
wait for the xdp_redirect changes to bottom out and then look into the
implementation.

Thanks,
Tony
> 
> > Also, based on the number of queues available, the number of TX queues
> > may be reduced when an XDP program is loaded in order to accommodate
> > the XDP queues.
> >
> > Based largely on commit 33fdc82f0883 ("ixgbe: add support for XDP_TX
> > action")
> >
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> 
> 
> [...]
