From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:35:33 +0000
Subject: [Intel-wired-lan] [PATCH S18 07/15] ice: Refactor
 getting/setting coalesce
In-Reply-To: <20190416172128.27184-8-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3998FC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 07/15] ice: Refactor getting/setting
> coalesce
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the driver has an uneven amount of Rx/Tx queues setting the
> coalesce settings through ethtool will result in an error. This is happening
> because in the setting coalesce flow we are reporting an error if either Rx or
> Tx fails.
> 
> Also, the flow for setting/getting per_q_coalesce and setting/getting
> coalesce settings for the entire device is different.
> 
> Fix these issues by adding one function, ice_set_q_coalesce(), and another,
> ice_get_q_coalesce(), that both getting/setting per_q and entire device
> coalesce can use. This makes handling the error cases generic between the
> two flows and simplifies
> __ice_set_coalesce() and __ice_get_coalesce().
> 
> Also, add a header comment to __ice_set_coalesce().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 152 ++++++++++++-------
>  1 file changed, 93 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


