From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:03:40 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 05/16] ixgbe: Fix
 limitations on macvlan so we can support up to 63 offloaded devices
In-Reply-To: <20171122185640.29785.25035.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185640.29785.25035.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC63@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 05/16] ixgbe: Fix
> limitations on macvlan so we can support up to 63 offloaded devices
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change is a fix of the macvlan offload so that we correctly handle
> macvlan offloaded devices. Specificaly we were configuring our limits based
> on the assumption that we were going to max out the RSS indices for every
> mode. As a result when we went to 15 or more macvlan interfaces we were
> forced into the 2 queue RSS mode on VFs even though they could have still
> supported 4.
> 
> This change splits the logic up so that we limit either the total number of
> macvlan instances if DCB is enabled, or limit the number of RSS queues used
> per macvlan (instead of per pool) if SR-IOV is enabled. By doing this we can
> make best use of the part.
> 
> In addition I have increased the maximum number of supported interfaces to
> 63 with one queue per offloaded interface as this more closely reflects the
> actual values supported by the interface.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    6 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   |    9 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   35 ++++++++++-----------
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   27 ++++++-------------
>  4 files changed, 34 insertions(+), 43 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


