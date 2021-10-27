From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 27 Oct 2021 10:30:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: send correct vc status
 in switchdev
In-Reply-To: <20211013062707.353095-1-michal.swiatkowski@linux.intel.com>
References: <20211013062707.353095-1-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554B1FBA7025BA7B524CBD29C859@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Wednesday, October 13, 2021 11:57 AM
To: intel-wired-lan@osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: send correct vc status in
>switchdev
>
>Part of virtchannel messages are treated in different way in switchdev mode
>to block configuring VFs from iavf driver side. This blocking was done by doing
>nothing and returning succes, event without sending response.
>
>Not sending response for opcodes that aren't supported in switchdev mode
>leads to block iavf driver message handling. This happens for example when
>vlan is configured at VF config time (VLAN module is already loaded).
>
>To get rid of it ice driver should answer for each VF message. In switchdev
>mode:
>- for adding/deleting VLAN driver should answer success without doing
>  anything to allow creating vlan device on VFs
>- for enabling/disabling VLAN stripping  and promiscuous mode driver
>  should answer not supported, this feature in switchdev can be only
>  set from host side
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 63 ++++++++++++++-----
> 1 file changed, 49 insertions(+), 14 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
