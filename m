From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:06:56 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 08/16] ixgbe:
 Assume provided MAC filter has been verified by macvlan
In-Reply-To: <20171122185658.29785.82075.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185658.29785.82075.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC92@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 08/16] ixgbe: Assume
> provided MAC filter has been verified by macvlan
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The macvlan driver itself will validate the MAC address that is configured for a
> given interface. There is no need for us to verify it again.
> 
> Instead we should be checking to verify that we actuall allocate the filter and
> have not run out of resources to configure a MAC rule in our filter table.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


