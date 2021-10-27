From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 27 Oct 2021 16:49:53 +0000
Subject: [Intel-wired-lan] [next-queue v2 4/4] ice: support for GRE in
 eswitch
In-Reply-To: <20211012183106.2315477-5-anthony.l.nguyen@intel.com>
References: <20211012183106.2315477-1-anthony.l.nguyen@intel.com>
 <20211012183106.2315477-5-anthony.l.nguyen@intel.com>
Message-ID: <MW3PR11MB4554903A2C75D02CC92ADB319C859@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Tony Nguyen
>Sent: Wednesday, October 13, 2021 12:01 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [next-queue v2 4/4] ice: support for GRE in eswitch
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Mostly reuse code from geneve and vxlan in TC parsing code. Add new GRE
>header to match on correct fields. Create new dummy packets with GRE fields.
>
>Instead of checking if any encap values are presented in TC flower, check if
>device is tunnel type or redirect is to tunnel device. This will allow adding all
>combination of rules. For example filters only with inner fields.
>
>Return error in case device isn't tunnel but encap values are presented.
>
>gre example:
>- create tunnel device
>ip l add $NVGRE_DEV type gretap remote $NVGRE_REM_IP local $VF1_IP \ dev
>$PF
>- add tc filter (in switchdev mode)
>tc filter add dev $NVGRE_DEV protocol ip parent ffff: flower dst_ip \
>$NVGRE1_IP action mirred egress redirect dev $VF1_PR
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/ice_flex_pipe.c    |   4 +
> .../net/ethernet/intel/ice/ice_flex_type.h    |   2 +
> .../ethernet/intel/ice/ice_protocol_type.h    |  10 ++
> drivers/net/ethernet/intel/ice/ice_switch.c   | 111 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  28 +++--
> 5 files changed, 145 insertions(+), 10 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
