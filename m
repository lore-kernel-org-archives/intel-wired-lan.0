From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 20:51:19 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 1/8] i40e:
 add	VF capabilities to virtual channel interface
In-Reply-To: <1433449442-31420-2-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C0D2@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, June 04, 2015 1:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 1/8] i40e: add VF
> capabilities to virtual channel interface
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> To prepare for the changes coming up in the X722 device and future devices,
> the virtual channel interface has to change slightly. The VF driver can now
> report what its capable of supporting, which then informs the PF driver when
> it sends the configuration information back to the VF.
> 
> A 1.1 VF driver on a 1.0 PF driver should not send its capabilities.
> Likewise, a 1.1 PF driver controlling a 1.0 VF driver should not expect or
> depend upon receiving the VF capabilities.
> 
> All other aspects of the API are unchanged.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Acked-by: Anjali Singhai <anjali.singhai@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: I530cc55f107edd1ee8bdf95830aa90b87854058a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 16 +++++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 16 +++++++++++-----
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>

Actually not testable on net-next kernel as I cannot find a API 1.0 i40e/evf driver that will build on the 4.1.0rc7 kernel (kcompat issues) This patch does not break current i40e/evf driver operation so I am letting it pass.
