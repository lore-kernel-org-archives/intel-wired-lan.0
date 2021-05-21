From: Jambekar, Vishakha <vishakha.jambekar@intel.com>
Date: Fri, 21 May 2021 11:44:54 +0000
Subject: [Intel-wired-lan] [PATCH intel-net v2 4/6] igb: add correct
 exception tracing for XDP
In-Reply-To: <20210510093854.31652-5-magnus.karlsson@gmail.com>
References: <20210510093854.31652-1-magnus.karlsson@gmail.com>
 <20210510093854.31652-5-magnus.karlsson@gmail.com>
Message-ID: <SA2PR11MB4940856C4DD29124DACB6654FF299@SA2PR11MB4940.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH intel-net v2 4/6] igb: add correct exception
> tracing for XDP
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add missing exception tracing to XDP when a number of different errors can
> occur. The support was only partial. Several errors where not logged which
> would confuse the user quite a lot not knowing where and why the packets
> disappeared.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Tested-by: Vishakha Jambekar<vishakha.jambekar@intel.com>
