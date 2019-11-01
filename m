From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:50:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: implement VF stats
 NDO
In-Reply-To: <20191029003707.45245-1-jesse.brandeburg@intel.com>
References: <20191029003707.45245-1-jesse.brandeburg@intel.com>
Message-ID: <a99f8f7254764ad9836aa8df76930669@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, October 28, 2019 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2] i40e: implement VF stats NDO
> 
> Implement the VF stats gathering via the kernel via ndo_get_vf_stats().
> The driver will show per-VF stats in the output of the command:
> ip -s link show dev <PF>
> 
> Testing Hints:
> ip -s link show dev eth0
> will return non-zero VF stats.
> ...
>    vf 0 MAC 00:55:aa:00:55:aa, spoof checking on, link-state enable, trust off
>    RX: bytes  packets  mcast   bcast
>    128000     1000     104     104
>    TX: bytes  packets
>    128000     1000
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> 
> v2: remove transmit stats from multicast and broadcast based on feedback,
> add a little to commit message.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 48 +++++++++++++++++++
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
>  3 files changed, 51 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


