From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:11:36 +0000
Subject: [Intel-wired-lan] [next PATCH S10 05/10] i40e: Extend PHY
 access with page change flag
In-Reply-To: <20190920091724.51767-5-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-5-alice.michael@intel.com>
Message-ID: <fd0a09c561f14195ba76a200df4b8882@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Azarewicz, Piotr <piotr.azarewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 05/10] i40e: Extend PHY access
> with page change flag
> 
> From: Piotr Azarewicz <piotr.azarewicz@intel.com>
> 
> Currently FW use MDIO I/F number corresponded with current PF for PHY
> access. This code allow to specify used MDIO I/F number.
> 
> Add new field - command flags with only one flag for now. Added flag tells
> FW that it shouldn't change page while accessing QSFP module, as it was set
> manually.
> 
> Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  8 ++-
> drivers/net/ethernet/intel/i40e/i40e_common.c | 70 +++++++++++++++----
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  8 +--
>  .../net/ethernet/intel/i40e/i40e_prototype.h  | 26 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  5 files changed, 87 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>





