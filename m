From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 20 Nov 2019 02:55:20 +0000
Subject: [Intel-wired-lan] [next-queue/net-next PATCH] e1000e: Use
 netdev_info instead of pr_info for link messages
In-Reply-To: <20191031165537.24154.48242.stgit@localhost.localdomain>
References: <cf197ef61703cbaa64ac522cf5d191b4b74f64d6.camel@linux.intel.com>
 <20191031165537.24154.48242.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97179772@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Alexander Duyck <alexander.duyck@gmail.com>
> Sent: Thursday, October 31, 2019 9:59 AM
> To: joe at perches.com; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> davem at davemloft.net
> Cc: zdai at linux.vnet.ibm.com; nhorman at redhat.com;
> netdev at vger.kernel.org; smorumu1 at in.ibm.com; intel-wired-
> lan at lists.osuosl.org; Brown, Aaron F <aaron.f.brown@intel.com>;
> sassmann at redhat.com
> Subject: [next-queue/net-next PATCH] e1000e: Use netdev_info instead of
> pr_info for link messages
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Replace the pr_info calls with netdev_info in all cases related to the
> netdevice link state.
> 
> As a result of this patch the link messages will change as shown below.
> Before:
> e1000e: ens3 NIC Link is Down
> e1000e: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> After:
> e1000e 0000:00:03.0 ens3: NIC Link is Down
> e1000e 0000:00:03.0 ens3: NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> Rx/Tx
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> 
> Since Joe hasn't gotten back to me on if he wanted to do the patch or if
> he wanted me to do it I just went ahead and did it. This should address the
> concerns he had about the message formatting in "e1000e: Use rtnl_lock to
> prevent race".
> 
>  drivers/net/ethernet/intel/e1000e/netdev.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
