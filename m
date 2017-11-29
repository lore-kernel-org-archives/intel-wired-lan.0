From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:10:25 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 14/16] ixgbe: Fix
 handling of macvlan Tx offload
In-Reply-To: <20171122185735.29785.22305.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185735.29785.22305.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFCF2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 14/16] ixgbe: Fix
> handling of macvlan Tx offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This update makes it so that we report the actual number of Tx queues via
> real_num_tx_queues but are still restricted to RSS on only the first pool by
> setting num_tc equal to 1. Doing this locks us into only having the ability to
> setup XPS on the queues in that pool, and only those queues should be used
> for transmitting anything other than macvlan traffic.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   20 ++++++++++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


