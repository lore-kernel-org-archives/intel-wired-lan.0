From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Apr 2018 22:17:38 +0000
Subject: [Intel-wired-lan] [iwl next-queue PATCH 10/10] ixgbe: Avoid
 performing unnecessary resets for macvlan offload
In-Reply-To: <20180403211645.7880.13012.stgit@ahduyck-green-test.jf.intel.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211645.7880.13012.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95AF62@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, April 3, 2018 2:17 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [iwl next-queue PATCH 10/10] ixgbe: Avoid
> performing unnecessary resets for macvlan offload
> 
> The original implementation for macvlan offload has us performing a full port
> reset every time we added a new macvlan. This shouldn't be necessary and
> can be avoided with a few behavior changes.
> 
> This patches updates the logic for the queues so that we have essentially 3
> possible configurations for macvlan offload. They consist of 15 macvlans with
> 4 queues per macvlan, 31 macvlans with 2 queues per macvlan, and 63
> macvlans with 1 queue per macvlan. As macvlans are added you will
> encounter up to 3 total resets if you add all the way up to 63, and after that
> the device will stay in the mode supporting up to 63 macvlans until the L2FW
> flag is cleared.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  192
> +++++++++++++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    5 -
>  2 files changed, 135 insertions(+), 62 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


