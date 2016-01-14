From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:09:29 +0000
Subject: [Intel-wired-lan] [next PATCH 02/11] igb: Refactor
	VFTA	configuration
In-Reply-To: <20160107071030.13648.82290.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071030.13648.82290.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F14C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 02/11] igb: Refactor VFTA        configuration
>
> This patch starts the clean-up process on the VFTA configuration.
> Specifically in this patch I attempt to address and simplify several items
> while also updating the code to bring it more inline with what is already
> in ixgbe.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c |   37 ++++++++-
>  drivers/net/ethernet/intel/igb/e1000_hw.h    |    2 -
>  drivers/net/ethernet/intel/igb/e1000_mac.c   |  102 ++++++++------------------
>  drivers/net/ethernet/intel/igb/e1000_mac.h   |    2 -
>  4 files changed, 67 insertions(+), 76 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
