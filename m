From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:13:27 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 03/10] macvlan: Use
 software path for offloaded local, broadcast, and multicast traffic
In-Reply-To: <20180403211609.7880.1015.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211609.7880.1015.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AEEF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:16 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 03/10] macvlan: Use
> software path for offloaded local, broadcast, and multicast traffic
> 
> This change makes it so that we use a software path for packets that are
> going to be locally switched between two macvlan interfaces on the same
> device. In addition we resort to software replication of broadcast and
> multicast packets instead of offloading that to hardware.
> 
> The general idea is that using the device for east/west traffic local to the
> system is extremely inefficient. We can only support up to whatever the
> PCIe limit is for any given device so this caps us at somewhere around 20G for
> devices supported by ixgbe. This is compounded even further when you take
> broadcast and multicast into account as a single 10G port can come to a crawl
> as a packet is replicated up to 60+ times in some cases. In order to get away
> from that I am implementing changes so that we handle broadcast/multicast
> replication and east/west local traffic all in software.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   39 +++++--------------
>  drivers/net/macvlan.c                           |   47 ++++++++++-------------
>  3 files changed, 33 insertions(+), 57 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


