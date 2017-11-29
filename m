From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:01:18 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 03/16] ixgbe: Add
 support for macvlan offload RSS on X550 and clean-up pool handling
In-Reply-To: <20171122185628.29785.72704.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185628.29785.72704.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC3F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 03/16] ixgbe: Add
> support for macvlan offload RSS on X550 and clean-up pool handling
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> In order for RSS to work on the macvlan pools of the X550 we need to
> populate the MRQC, RETA, and RSS key values for each pool. This patch
> makes it so that we now take care of that.
> 
> In addition I have dropped the macvlan specific configuration of psrtype since
> it is redundant with the code that already exists for configuring this value.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   62 ++++++++++------------
> ---
>  1 file changed, 25 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


