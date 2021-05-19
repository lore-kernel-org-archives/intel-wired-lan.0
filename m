From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Wed, 19 May 2021 16:12:27 +0000
Subject: [Intel-wired-lan] [PATCH intel-net v2 1/6] i40e: add correct
 exception tracing for XDP
In-Reply-To: <20210510093854.31652-2-magnus.karlsson@gmail.com>
References: <20210510093854.31652-1-magnus.karlsson@gmail.com>
 <20210510093854.31652-2-magnus.karlsson@gmail.com>
Message-ID: <DM6PR11MB3292834F3FBC9AE8D4F6FD0BF12B9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Monday, May 10, 2021 3:09 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; intel-wired-
> lan at lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: netdev at vger.kernel.org; brouer at redhat.com
> Subject: [Intel-wired-lan] [PATCH intel-net v2 1/6] i40e: add correct exception
> tracing for XDP
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add missing exception tracing to XDP when a number of different errors can
> occur. The support was only partial. Several errors where not logged which
> would confuse the user quite a lot not knowing where and why the packets
> disappeared.
> 
> Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
> Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++++-
> drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
