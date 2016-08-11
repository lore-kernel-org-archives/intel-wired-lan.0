From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Thu, 11 Aug 2016 21:59:25 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Force VLNCTRL.VFE to be set in
 all VMDq paths
In-Reply-To: <147095231662.4841.672399088639313718.stgit@ahduyck-desk.amr.corp.intel.com>
References: <147095231662.4841.672399088639313718.stgit@ahduyck-desk.amr.corp.intel.com>
Message-ID: <1470952763.31962.54.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-08-11 at 14:51 -0700, Alexander Duyck wrote:
> When I was adding the code for enabling VLAN promiscuous mode with
> SR-IOV
> enabled I had inadvertently left the VLNCTRL.VFE bit unchanged as I
> has
> assumed there was code in another path that was setting it when we
> enabled
> SR-IOV.??This wasn't the case and as a result we were just disabling
> VLAN
> filtering for all the VFs apparently.
> 
> Also the previous patches were always clearing CFIEN which was always
> set
> to 0 by the hardware anyway so I am dropping the redundant bit
> clearing.
> 
> Fixes: 16369564915a ("ixgbe: Add support for VLAN promiscuous with
> SR-IOV")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Hey Jeff,

I'm still working out the kinks of setting up yet another devel system,
otherwise I would have flagged this as being for the net queue. ?If you
need I can resubmit the patch, but I figure I will wait until you say
it is necessary.

Also I added a "Fixes:" line as this will need to be ported back into
several stable trees. ?It is a bug that Email found in the VLAN patches
I submitted for ixgbe a little while back.

Thanks.

- Alex
