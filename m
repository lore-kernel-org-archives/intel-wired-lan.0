From: Young, James M <james.m.young@intel.com>
Date: Tue, 16 Jun 2015 21:45:12 +0000
Subject: [Intel-wired-lan] [net-next S5 12/15] i40e/i40evf: Add support
 for	pre-allocated pages for PD
In-Reply-To: <1430161042-28494-13-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA186B4@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Latif, Faisal
> Subject: [Intel-wired-lan] [net-next S5 12/15] i40e/i40evf: Add support for
> pre-allocated pages for PD
> 
> From: Faisal Latif <faisal.latif@intel.com>
> 
> The i40e_add_pd_table_entry() routine is being modified to handle both
> cases where a backing page is passed and where backing page is allocated in
> i40e_add_pd_table_entry().
> 
> For PBLE resource management, it is more efficient for it to manage its
> backing pages. For VF, PBLE backing page addresses will be send to PF driver
> for PBLE resource.
> 
> The i40e_remove_pd_bp() is also modified to not free pre-allocated pages
> and free only ones which were allocated in i40e_add_pd_table_entry().
> 
> Signed-off-by: Faisal Latif <faisal.latif@intel.com>
> Change-ID: Ie673f0403f22979e9406f5a94048dceb91bcf9a8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c     | 30 +++++++++++++++++-------
> --
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h     |  4 +++-
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_hmc.h   |  4 +++-
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

