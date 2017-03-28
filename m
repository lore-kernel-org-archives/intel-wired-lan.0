From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Mar 2017 23:11:08 +0000
Subject: [Intel-wired-lan] [PATCH v7 2/2] ixgbe: add support for
	XDP_TX	action
In-Reply-To: <20170324043145.10293.75036.stgit@john-Precision-Tower-5810>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <20170324043145.10293.75036.stgit@john-Precision-Tower-5810>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040A559@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of John Fastabend
> Sent: Thursday, March 23, 2017 9:32 PM
> To: john.fastabend at gmail.com; alexander.duyck at gmail.com
> Cc: intel-wired-lan at lists.osuosl.org; u9012063 at gmail.com
> Subject: [Intel-wired-lan] [PATCH v7 2/2] ixgbe: add support for XDP_TX
> action
> 
> Add support for XDP_TX action.
> 
> A couple design choices were made here. First I use a new ring pointer
> structure xdp_ring[] in the adapter struct instead of pushing the newly
> allocated xdp TX rings into the tx_ring[] structure. This means we have to
> duplicate loops around rings in places we want to initialize both TX rings and
> XDP rings.
> But by making it explicit it is obvious when we are using XDP rings and when
> we are using TX rings. Further we don't have to do ring arithmatic which is
> error prone. As a proof point for doing this my first patches used only a single
> ring structure and introduced bugs in FCoE code and macvlan code paths.
> 
> Second I am aware this is not the most optimized version of this code
> possible. I want to get baseline support in using the most readable format
> possible and then once this series is included I will optimize the TX path in
> another series of patches.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   19 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   25 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   78 +++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  279
> +++++++++++++++++++---
>  4 files changed, 350 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


