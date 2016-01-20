From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 00:17:33 +0000
Subject: [Intel-wired-lan] [next PATCH S27 08/15] i40e/i40evf: don't
 lose	interrupts
In-Reply-To: <1452554307-20937-9-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
 <1452554307-20937-9-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98099F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Monday, January 11, 2016 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S27 08/15] i40e/i40evf: don't lose
> interrupts
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> While re-enabling interrupts the driver would clear all pending causes. This
> meant that if an interrupt was generated while the driver was cleaning or
> polling with interrupts disabled, then that interrupt was lost.  This could cause
> a queue to become dead, especially for receive.  Refactored the enable_icr0
> function in order to allow it to be decided by the caller whether the
> CLEARPBA (clear pending
> events) bit will be set while re-enabling the interrupt.
> 
> Also update copyright year in file headers.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ic1db100a05e13c98919057696db147a258ca365a
> ---
> Testing Hints: use pktgen or a traffic generator to send packets to the device
> and force it to enter polling.  If all queues are in use, usually a few of the
> queues will quit receiving.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |  7 +++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 ++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++++--
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 +++-
>  5 files changed, 20 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, queues don't drop when hammered with traffic
