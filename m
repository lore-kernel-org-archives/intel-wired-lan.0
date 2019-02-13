From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:15:35 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 05/12] i40e: Fix for 10G
 ports LED not blinking
In-Reply-To: <20190206230826.24970-5-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FB0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Marczak, Piotr <piotr.marczak@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 05/12] i40e: Fix for 10G ports
> LED not blinking
> 
> From: Piotr Marczak <piotr.marczak@intel.com>
> 
> On some hardware LEDs would not blink after command 'ethtool -p {eth-
> port}'
> in certain circumstances. Now, function does not care about the activity of
> the LED (though still preserves its state) but forcibly executes identification
> blinking and then restores the LED state.
> 
> Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 33 -------------------
>  1 file changed, 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


