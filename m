From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:01:03 +0000
Subject: [Intel-wired-lan] [PATCH S8 11/16] ice: Fix debug print in
 ice_tx_timeout
In-Reply-To: <20181026174105.11628-12-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D2A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 11/16] ice: Fix debug print in
> ice_tx_timeout
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the debug print in ice_tx_timeout is printing useless and duplicate
> values. First, head is being assigned to tx_ring->next_to_clean and we are
> printing both of those values, but naming them HWB and NTC respectively.
> Also, reading tail always returns 0 so remove that as well.
> 
> Instead of assigning head the SW head (NTC) read the actual head register
> and change the debug print to note that this is HW_HEAD. Also reduce thei
> scope of a couple variables.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  3 +++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 15 +++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


