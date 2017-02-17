From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:28:53 +0000
Subject: [Intel-wired-lan] [next PATCH v5 08/12] igb: Add support for
 ethtool private flag to allow use of legacy Rx
In-Reply-To: <20170207022646.9864.10096.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022646.9864.10096.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB95@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:27 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 08/12] igb: Add support for ethtool
> private flag to allow use of legacy Rx
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Since there are potential drawbacks to the new Rx allocation approach I
> thought it best to add a "chicken bit" so that we can turn the feature off
> if in the event that a problem is found.
> 
> It also provides a means of validating the legacy Rx path in the event that
> we are forced to fall back.  At some point in the future when we are
> convinced we don't need it anymore we might be able to drop the legacy-rx
> flag.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v4: Move patch up so that we add support for RX_LEGACY flag before we add
>     support for the new approach.
>     Added actual creation of the RX_LEGACY flag to this patch.
> 
>  drivers/net/ethernet/intel/igb/igb.h         |    1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |   48
> ++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
