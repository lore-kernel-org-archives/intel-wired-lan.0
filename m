From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:02:04 +0000
Subject: [Intel-wired-lan] [PATCH 02/16] ice: Add support to detect
 SR-IOV capability and mailbox queues
In-Reply-To: <20180920002339.11107-3-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC569@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 02/16] ice: Add support to detect SR-IOV
> capability and mailbox queues
> 
> Mailbox queue is a type of control queue that's used for communication
> between PF and VF. This patch adds code to initialize, configure and use
> mailbox queues.
> 
> This patch also adds support to detect and parse SR-IOV capabilities returned
> by the hardware.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  5 +++
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  2 ++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 22 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_controlq.c   | 46
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_controlq.h   |  2 ++
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 21 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 47
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_type.h       |  7 ++++
>  8 files changed, 151 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


