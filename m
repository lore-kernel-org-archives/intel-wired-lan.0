From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 17 Nov 2021 23:59:19 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: fix adding different tunnels
In-Reply-To: <20211116102438.11756-1-michal.swiatkowski@linux.intel.com>
References: <20211116102438.11756-1-michal.swiatkowski@linux.intel.com>
Message-ID: <5ae646ac06ec21eeb82dda74b13c79f84709bcb4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-11-16 at 11:24 +0100, Michal Swiatkowski wrote:
> Adding filters with the same values inside for VXLAN and geneve
> causes hw
> error, because it looks exactly the same. To choose between different
> type of tunnels new recipe is needed. Add storing tunnel types in
> creatig recipes function and start checking it in finding function.
> 
> Change getting open tunnels function to return port on correct tunnel
> type. This is needed to copy correct port to dummy packet.
> 
> Block user from adding enc_dst_port via tc flower, because? VXLAN and
> geneve filters can be created only with destination port which was
> previously opened.
> 
> Fixes: 8b032a55c1bd5 ("ice: low level support for tunnels")
> Signed-off-by: Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> ---
> ?.../net/ethernet/intel/ice/ice_ethtool_fdir.c?? |? 4 ++--
> ?drivers/net/ethernet/intel/ice/ice_fdir.c?????? |? 2 +-
> ?drivers/net/ethernet/intel/ice/ice_flex_pipe.c? |? 6 ++++--
> ?drivers/net/ethernet/intel/ice/ice_flex_pipe.h? |? 3 ++-
> ?drivers/net/ethernet/intel/ice/ice_switch.c???? | 17 ++++++++++++---
> --
> ?drivers/net/ethernet/intel/ice/ice_tc_lib.c???? |? 3 ++-
> ?6 files changed, 23 insertions(+), 12 deletions(-)

The added function parameters need to be documented:

drivers/net/ethernet/intel/ice/ice_switch.c:3801: warning: Function
parameter or member 'tun_type' not described in 'ice_find_recp'
drivers/net/ethernet/intel/ice/ice_flex_pipe.c:2047: warning: Function
parameter or member 'type' not described in 'ice_get_open_tunnel_port'

