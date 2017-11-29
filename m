From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:09:22 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 12/16] ixgbe: Do
 not manipulate macvlan Tx queues when performing macvlan offload
In-Reply-To: <20171122185723.29785.8129.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185723.29785.8129.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFCD2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 12/16] ixgbe: Do not
> manipulate macvlan Tx queues when performing macvlan offload
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We should not be stopping/starting the upper devices Tx queues when
> handling a macvlan offload. Instead we should be stopping and starting traffic
> on our own queues.
> 
> In order to prevent us from doing this I am updating the code so that we no
> longer change the queue configuration on the upper device, nor do we
> update the queue_index on our own device. Instead we can just use the
> queue index for our local device and not update the netdev in the case of
> the transmit rings.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   12 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  121 +++++-------------------
> -
>  2 files changed, 25 insertions(+), 108 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


