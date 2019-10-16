From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:18:14 +0000
Subject: [Intel-wired-lan] [PATCH S31 04/15] ice: Update Boot
 Configuration Section read of NVM
In-Reply-To: <20191009140953.14087-4-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-4-anthony.l.nguyen@intel.com>
Message-ID: <0918d97f0a6d4aefaf78e43bb403632d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 04/15] ice: Update Boot Configuration
> Section read of NVM
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> The Boot Configuration Section Block has been moved to the Preserved Field
> Area (PFA) of NVM. Update the NVM reads that involves Boot Configuration
> Section.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 66
> +++++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_common.h |
> 3 +
>  drivers/net/ethernet/intel/ice/ice_nvm.c    | 51 +++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_nvm.h    |  1 +
>  drivers/net/ethernet/intel/ice/ice_type.h   |  3 +
>  5 files changed, 115 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


