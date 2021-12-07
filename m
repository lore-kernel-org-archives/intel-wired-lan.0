From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 7 Dec 2021 09:09:55 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix choosing udp header type
In-Reply-To: <20211116102426.11675-1-michal.swiatkowski@linux.intel.com>
References: <20211116102426.11675-1-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554BA2A155AD38D882B72299C6E9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Tuesday, November 16, 2021 3:54 PM
To: intel-wired-lan@osuosl.org
>Subject: [Intel-wired-lan] [PATCH net] ice: fix choosing udp header type
>
>In tunnels packet there can be two UDP headers:
>- outer which for hw should be mark as ICE_UDP_OF
>- inner which for hw should be mark as ICE_UDP_ILOS or as ICE_TCP_IL if
>  inner header is of TCP type
>
>In none tunnels packet header can be:
>- UDP, which for hw should be mark as ICE_UDP_ILOS
>- TCP, which for hw should be mark as ICE_TCP_IL
>
>Change incorrect ICE_UDP_OF for none tunnel packets to ICE_UDP_ILOS.
>ICE_UDP_OF is incorrect for none tunnel packets and setting it leads to error
>from hw while adding this kind of recipe.
>
>In summary, for tunnel outer port type should always be set to ICE_UDP_OF,
>for none tunnel outer and tunnel inner it should always be set to
>ICE_UDP_ILOS.
>
>Fixes: 9e300987d4a81 ("ice: VXLAN and Geneve TC support")
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_tc_lib.c | 26 ++++++++-------------
> 1 file changed, 10 insertions(+), 16 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
