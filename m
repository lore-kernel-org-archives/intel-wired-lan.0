From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 20:55:23 +0000
Subject: [Intel-wired-lan] [next PATCH S17 04/11] i40e/i40evf:
	change	dynamic interrupt thresholds
In-Reply-To: <1443464220-148318-5-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2D6F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S17 04/11] i40e/i40evf: change
> dynamic interrupt thresholds
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The dynamic algorithm, while now working, doesn't have good performance
> in 40G mode.
> 
> One part of this patch addresses the high cpu utilization of some small
> streaming workloads that the driver should reduce CPU in.
> 
> It also changes the minimum ITR that the dynamic algorithm will settle on,
> causing our minimum latency to go from 12us to about 14us, when using
> adaptive mode.
> 
> It also changes the BULK interrupt rate to allow maximum throughput on a
> 40Gb connection with a single thread of transmit, clamping interrupt rate to
> 8000 for TX makes single thread traffic go too slow.
> 
> The new ULTRA bulk setting is introduced and is used when the rx packet
> rate on this queue exceeds 40000 packets per second.  This value of 40000
> was chosen because the automatic tuning of minimum ITR=20us means that
> a single queue can't quite achieve that many packets per second from a
> round-robin test.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Icce8faa128688ca5fd2c4229bdd9726877a92ea2
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 27
> +++++++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 27
> +++++++++++++++++++++------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  3 +++
>  4 files changed, 48 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
