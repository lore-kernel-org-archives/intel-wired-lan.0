From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 20:58:48 +0000
Subject: [Intel-wired-lan] [next PATCH S55 09/14] i40evf: track
 outstanding	client request
In-Reply-To: <1480377971-23412-10-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38FAA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S55 09/14] i40evf: track outstanding
> client request
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The iWarp client cannot continue until this operation has been completed by
> the PF driver. Sleep (with timeout) until the reply from the PF driver has
> been received.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I5dc41b857bba32d0218b7ce167b5da122dadf349
> ---
> Testing Hints : Load up VF RDMA with > 2 active VFs.
> 
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 4 ++++
>  3 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


