From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:09:47 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 13/16] ixgbe:
 avoid bringing rings up/down as macvlans are added/removed
In-Reply-To: <20171122185729.29785.42193.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185729.29785.42193.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFCE1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 13/16] ixgbe: avoid
> bringing rings up/down as macvlans are added/removed
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that instead of bringing rings up/down for various we
> just update the netdev pointer for the Rx ring and set or clear the MAC filter
> for the interface. By doing it this way we can avoid a number of races and
> issues in the code as things were getting messy with the macvlan clean-up
> racing with the interface clean-up to bring the rings down on shutdown.
> 
> With this change we opt to leave the rings owned by the PF interface for
> both Tx and Rx and just direct the packets once they are received to the
> macvlan netdev.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   28 +++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  102 +++++++++++++------
> ------
>  2 files changed, 72 insertions(+), 58 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


