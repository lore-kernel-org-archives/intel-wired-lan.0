From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Jan 2016 20:44:28 +0000
Subject: [Intel-wired-lan] [next PATCH S24 05/12] i40evf: add new
 write-back	mode
In-Reply-To: <1450823114-29514-6-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-6-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C465@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 05/12] i40evf: add new write-back
> mode
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Add write-back on interrupt throttle rate timer expiration support for the
> i40evf driver, when running on X722 devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 ++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 16 ++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  5 +++++
>  3 files changed, 27 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no tx_timeout/tx hangs noted with stress traffic
