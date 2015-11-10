From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:37:23 +0000
Subject: [Intel-wired-lan] [PATCH v4 5/6] i40e:Add geneve tunnel
	offload	support
In-Reply-To: <1447178205-99510-5-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
 <1447178205-99510-5-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1FD3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Tuesday, November 10, 2015 9:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 5/6] i40e:Add geneve tunnel offload
> support
> 
> This patch adds driver hooks to implement ndo_ops to add/del udp port in
> the HW to identify GENEVE tunnels.
> 
> Also cleans up the features_check path now that we support multiple udp
> based tunnels.
> 
> Add a spin_lock to guard the common data structure for the udp based
> tunnels.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 61
> ++++++++++++++++++++++-------
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 +-
>  3 files changed, 50 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
