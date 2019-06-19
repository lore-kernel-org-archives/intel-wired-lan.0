From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jun 2019 23:15:13 +0000
Subject: [Intel-wired-lan] [net-next ] iavf: Fix up debug print macro
In-Reply-To: <20190617231058.15343-1-jeffrey.t.kirsher@intel.com>
References: <20190617231058.15343-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3F8D53@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, June 17, 2019 4:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next ] iavf: Fix up debug print macro
> 
> This aligns the iavf_debug() macro with the other Intel drivers.
> 
> Add the bus number, bus_id field to i40e_bus_info so output shows each
> physical port(i.e func) in following format:
>   [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]
> domains are numbered from 0 to ffff), bus (0-ff), slot (0-1f) and function (0-
> 7).
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_osdep.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


