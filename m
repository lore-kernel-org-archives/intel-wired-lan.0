From: Jambekar, Vishakha <vishakha.jambekar@intel.com>
Date: Fri, 21 May 2021 11:39:39 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 3/5] ixgbe: add correct
 exception tracing for XDP
In-Reply-To: <20210423100446.15412-4-magnus.karlsson@gmail.com>
References: <20210423100446.15412-1-magnus.karlsson@gmail.com>
 <20210423100446.15412-4-magnus.karlsson@gmail.com>
Message-ID: <SA2PR11MB4940442F818ED0DA99E5F462FF299@SA2PR11MB4940.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Friday, April 23, 2021 3:35 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; intel-wired-
> lan at lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; brouer at redhat.com
> Subject: [Intel-wired-lan] [PATCH intel-net 3/5] ixgbe: add correct exception
> tracing for XDP
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add missing exception tracing to XDP when a number of different errors can
> occur. The support was only partial. Several errors where not logged which
> would confuse the user quite a lot not knowing where and why the packets
> disappeared.
> 
> Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
> Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++--------
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 13 ++++++++-----
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 

Tested-by: Vishakha Jambekar<vishakha.jambekar@intel.com>
