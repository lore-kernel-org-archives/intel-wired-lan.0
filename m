From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 1 Oct 2021 21:59:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2
In-Reply-To: <20210929133715.149736-1-karen.sornek@intel.com>
References: <20210929133715.149736-1-karen.sornek@intel.com>
Message-ID: <SN6PR11MB3229FD578A9B1B87A33327FBC6AB9@SN6PR11MB3229.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: Wednesday, September 29, 2021 6:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2

Why is this the same title as the other patch? As this is for the virtchnl file, it should use 'virtchnl:' and reflect what this patch is doing.

> Changes required for iavf patch "Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2"
> to work properly.

Please explain what this patch is introducing; more information is needed here.

> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 330
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 330 insertions(+)
> 
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h index

