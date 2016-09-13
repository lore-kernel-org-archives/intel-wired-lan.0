From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 16:28:57 +0000
Subject: [Intel-wired-lan] [next PATCH S46 2/8] i40evf: enable
	adaptive	interrupt throttling
In-Reply-To: <1473715124-31296-3-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCFF5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 2/8] i40evf: enable adaptive
> interrupt throttling
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> All of the code to support adaptive interrupt throttling is already in the
> interrupt handler, it just needs to be enabled. Fill out the data structures
> properly to make it happen. Single-flow traffic tests may show slightly lower
> throughput, but interrupts per second will drop by about 75%.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I9cd7d42c025b906bf1bb85c6aeb6112684aa6471
> ---
> Testing Hints : Use itop to monitor interrupt load and run netperf.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Interrupts significantly lower with patch applied as expected


