From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:20:45 +0000
Subject: [Intel-wired-lan] [PATCH S31 07/15] ice: Adjust DCB INIT for SW
 mode
In-Reply-To: <20191009140953.14087-7-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-7-anthony.l.nguyen@intel.com>
Message-ID: <120bace6ea894c99884de7b04b7aa6c0@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S31 07/15] ice: Adjust DCB INIT for SW
> mode
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Adjust ice_init_dcb to set the is_sw_lldp boolean in the case where the FW
> has been detected to be in an untenable state such that the driver should
> forcibly make sure it is off.
> 
> This will ensure that the FW is in a known state.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


