From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 19:00:55 +0000
Subject: [Intel-wired-lan] [next PATCH S17 05/11] i40e/i40evf:
	adjust	interrupt throttle less frequently
In-Reply-To: <1443464220-148318-6-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3175@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 05/11] i40e/i40evf: adjust
> interrupt throttle less frequently
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The adaptive ITR (interrupt throttle rate) algorithm was adjusting the
> hardware's interrupt rate too frequently.  This caused a lot of variation in the
> interrupt rate for fairly constant workloads.
> 
> Change the code to have a counter and adjust only once every N number of
> interrupts.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I0460f1f86571037484eca5aca36ac4d889cb8389
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h          |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 22
> ++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     |  4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 23
> +++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   |  4 ++--
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  2 ++
>  8 files changed, 53 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, lower CPU usage and higher throughput observed with patch applied.
