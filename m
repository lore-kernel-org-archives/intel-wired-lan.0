From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 17:44:01 +0000
Subject: [Intel-wired-lan] [next PATCH S16 08/15] i40e/i40evf:
	moderate	interrupts differently
In-Reply-To: <1443463964-148204-9-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2C33@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 08/15] i40e/i40evf: moderate
> interrupts differently
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The XL710 hardware has a different interrupt moderation design that can
> support a limit of total interrupts per second per vector, in addition to the
> "number of interrupts per second"
> controls already established in the driver.  This combination of hardware
> features allows us to set very low default latency settings but minimize the
> total CPU utilization by not making too many interrupts, should the user
> desire.
> 
> The current driver implementation is still enabling the dynamic moderation in
> the driver, and only using the rx/tx-usecs limit in ethtool to limit the interrupt
> rate per second, by default.
> 
> The new code implemented in this patch
> 2) adds init/use of the new "Interrupt Limit" register
> 3) adds ethtool knob to control/report the limits above
> 
> Usage is ethtool -C ethx rx-usecs-high <value> Where <value> is number of
> microseconds to create a rate of 1/N interrupts per second, regardless of rx-
> usecs or tx-usecs values. Since there is a credit based scheme in the
> hardware, the rx-usecs and tx-usecs can be configured for very low latency
> for short bursts, but once the credit runs out the refill rate on the credits is
> limited by rx-usecs-high.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I3a1075d3296123b0f4f50623c779b027af5b188d
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 24
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 +++++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 10 ++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 10 ++++++++++
>  5 files changed, 52 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, ethtool command line switches correctly set and displayed values for tx-usecs-high
