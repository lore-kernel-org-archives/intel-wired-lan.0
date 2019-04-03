From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:59:09 +0000
Subject: [Intel-wired-lan] [next PATCH S4 09/11] i40e: Add support for
 X710 B/P & SFP+ cards
In-Reply-To: <20190329220840.51187-9-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D37880C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 09/11] i40e: Add support for X710
> B/P & SFP+ cards
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> New device ids are created to support X710 backplane and SFP+ cards.
> 
> This patch adds in i40e driver support for 2.5GbaseT and 5GbaseT speed.
> It's implemented by checking I40E_CAP_PHY_TYPE_2_5GBASE_T,
> I40E_CAP_PHY_TYPE_5GBASE_T bits from f/w and setting corresponding bits
> in ethtool link ksettings supported and advertising masks.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 12 +++++-
> drivers/net/ethernet/intel/i40e/i40e_common.c |  5 +++
> drivers/net/ethernet/intel/i40e/i40e_devids.h |  3 ++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 42 ++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  6 +++
>  6 files changed, 74 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


