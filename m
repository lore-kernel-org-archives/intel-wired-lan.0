From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:26:01 +0000
Subject: [Intel-wired-lan] [PATCH S17 01/17] ice: Calculate ITR
 increment based on direct calculation
In-Reply-To: <20190228232603.32156-2-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368E3A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 01/17] ice: Calculate ITR increment
> based on direct calculation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when calculating how much to increment ITR by inside of
> ice_update_itr() we do some estimations and intermediate calculations.
> Instead of doing estimations, just do the calculation directly. This allows for a
> more accurate value and it makes it easier for the next person to understand
> and update.
> 
> Also, remove the dividing the ITR value by 2 when latency driven because the
> ITR values are already so low for 100Gbps speed. This should help get to the
> desired ITR value faster.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 135 ++++++++++++++-------------
> ---
>  1 file changed, 63 insertions(+), 72 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


