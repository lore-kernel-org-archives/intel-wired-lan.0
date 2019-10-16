From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:23:18 +0000
Subject: [Intel-wired-lan] [PATCH S31 11/15] ice: print unsupported
 module message
In-Reply-To: <20191009140953.14087-11-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-11-anthony.l.nguyen@intel.com>
Message-ID: <b926d31d82a144e1adfa63216179b8d0@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S31 11/15] ice: print unsupported module
> message
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Print message to inform user if unsupported module is inserted, and extend
> the topology / configuration detection.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 4 ++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 6 ++++++
>  2 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


