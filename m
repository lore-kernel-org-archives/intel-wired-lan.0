From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:28:12 +0000
Subject: [Intel-wired-lan] [PATCH S17 05/17] ice: Reduce scope of
 variable in ice_vsi_cfg_rxqs
In-Reply-To: <20190228232603.32156-6-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368E7A@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S17 05/17] ice: Reduce scope of variable in
> ice_vsi_cfg_rxqs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Reduce scope of the variable 'err' to inside the for loop instead of using it as a
> second looping conditional. Also while here, improve the debug message if
> we fail to configure a Rx queue.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


