From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 18 Feb 2022 05:01:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for inner
 etype in switchdev
In-Reply-To: <20220116090142.2934-1-martyna.szapar-mudlaw@intel.com>
References: <20220116090142.2934-1-martyna.szapar-mudlaw@intel.com>
Message-ID: <MW3PR11MB4554674306EF10709454AE7C9C379@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Martyna Szapar-Mudlaw
>Sent: Sunday, January 16, 2022 2:32 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for inner etype in
>switchdev
>
>Enable support for adding TC rules that filter on the inner EtherType field of
>tunneled packet headers.
>
>Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
>---
> .../ethernet/intel/ice/ice_protocol_type.h    |   2 +
> drivers/net/ethernet/intel/ice/ice_switch.c   | 272 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  15 +-
> 3 files changed, 277 insertions(+), 12 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
