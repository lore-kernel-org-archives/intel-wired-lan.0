From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:08:07 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 10/16] ixgbe:
 Don't assume dev->num_tc is equal to hardware TC config
In-Reply-To: <20171122185711.29785.52716.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185711.29785.52716.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFCB2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 10/16] ixgbe: Don't
> assume dev->num_tc is equal to hardware TC config
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The code throughout ixgbe was assuming that dev->num_tc was populated
> and configured with the driver, when in fact this can be configured via
> mqprio without any hardware coordination other than restricting us to the
> real number of Tx queues we advertise.
> 
> Instead of handling things this way we need to keep a local copy of the
> number of TCs in use so that we don't accidently pull in the TC configuration
> from mqprio when it is configured in software mode.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c  |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 +++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   17 ++++++++---------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   22 ++++++++++++-------
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   |    8 ++++----
>  6 files changed, 29 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

