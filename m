From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 10 Mar 2022 10:38:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 7/7] ice: Support GTP-U
 and GTP-C offload in switchdev
In-Reply-To: <20220304164048.476900-8-marcin.szycik@linux.intel.com>
References: <20220304164048.476900-1-marcin.szycik@linux.intel.com>
 <20220304164048.476900-8-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB4554E0C520A2F1F2EB06BE009C0B9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Friday, March 4, 2022 10:11 PM
To: netdev@vger.kernel.org
>Cc: jiri at resnulli.us; xiyou.wangcong at gmail.com; osmocom-net-
>gprs at lists.osmocom.org; jhs at mojatatu.com; laforge at gnumonks.org; intel-
>wired-lan at lists.osuosl.org; kuba at kernel.org; davem at davemloft.net;
>pablo at netfilter.org
>Subject: [Intel-wired-lan] [PATCH net-next v10 7/7] ice: Support GTP-U and
>GTP-C offload in switchdev
>
>Add support for creating filters for GTP-U and GTP-C in switchdev mode. Add
>support for parsing GTP-specific options (QFI and PDU type) and TEID.
>
>By default, a filter for GTP-U will be added. To add a filter for GTP-C, specify
>enc_dst_port = 2123, e.g.:
>
>tc filter add dev $GTP0 ingress prio 1 flower enc_key_id 1337 \ enc_dst_port
>2123 action mirred egress redirect dev $VF1_PR
>
>Note: GTP-U with outer IPv6 offload is not supported yet.
>Note: GTP-U with no payload offload is not supported yet.
>
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
>v7: Fix ice_get_sw_prof_type kernel-doc
>v9: Fix GTP-C dummy packet selection, GTP-C IPv6 offload working
>v10: Rebase
>---
> drivers/net/ethernet/intel/ice/ice.h          |   1 +
> .../net/ethernet/intel/ice/ice_flex_pipe.c    |  31 +-
> .../net/ethernet/intel/ice/ice_flex_type.h    |   6 +-
> .../ethernet/intel/ice/ice_protocol_type.h    |  19 +
> drivers/net/ethernet/intel/ice/ice_switch.c   | 604 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_switch.h   |   9 +
> drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 105 ++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   3 +
> 8 files changed, 760 insertions(+), 18 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
