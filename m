From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:54:53 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] virtchnl: Remove unused
 VIRTCHNL_VF_OFFLOAD_RSVD define
In-Reply-To: <20210507220911.116361-1-brett.creeley@intel.com>
References: <20210507220911.116361-1-brett.creeley@intel.com>
Message-ID: <MN2PR11MB42249E6063F76A0AEB11E63682879@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 1/2] virtchnl: Remove unused
> VIRTCHNL_VF_OFFLOAD_RSVD define
> 
> Remove unused define that is currently marked as reserved. This will open
> up space for a new feature if/when it's introduced. Also, there is no reason
> to keep unused defines around.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


