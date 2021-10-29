From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:55:22 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] virtchnl: Use the BIT() macro for
 capability/offload flags
In-Reply-To: <20210507220911.116361-2-brett.creeley@intel.com>
References: <20210507220911.116361-1-brett.creeley@intel.com>
 <20210507220911.116361-2-brett.creeley@intel.com>
Message-ID: <MN2PR11MB422448D2DF3C335BF08D4AC582879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Creeley, Brett
> Sent: Friday, May 7, 2021 3:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] virtchnl: Use the BIT() macro for
> capability/offload flags
> 
> Currently raw hex values are used to define specific bits for each
> capability/offload in virtchnl.h. Using raw hex values makes it unclear which
> bits are used/available. Fix this by using the BIT() macro so it's immediately
> obvious which bits are used/available.
> 
> Also, move the VIRTCHNL_VF_CAP_ADV_LINK_SPEED define in the correct
> place to line up with the other bit values and add a comment for its purpose.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 40 ++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


