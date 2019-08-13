From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:07:48 +0000
Subject: [Intel-wired-lan] [PATCH S27 03/15] ice: Always notify FW of VF
 reset
In-Reply-To: <20190808143938.4968-3-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D411606@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 03/15] ice: Always notify FW of VF
> reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The call to ice_dis_vsi_txq() acts as the notification to the firmware that the
> VF is being reset. Because of this, we need to make this call every time we
> reset, regardless of whatever else we do to stop the tx queues.
> 
> Without this change, VF resets would fail to complete on interfaces that
> were up and running.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 ++++++++++++-------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


