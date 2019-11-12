From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:30:55 +0000
Subject: [Intel-wired-lan] [PATCH S33 02/15] ice: Correct capabilities
 reporting of max TCs
In-Reply-To: <20191108142331.10221-2-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-2-anthony.l.nguyen@intel.com>
Message-ID: <d2966547500b4fd480be2f89075500c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 02/15] ice: Correct capabilities
> reporting of max TCs
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Firmware always returns 8 as the max number of supported TCs. However on
> devices with more than 4 ports, the maximum number of TCs per port is
> limited to 4. Check and, if necessary, correct the reporting of capabilities for
> devices with more than 4 ports.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


