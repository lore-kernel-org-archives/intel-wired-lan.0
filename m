From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:32:07 +0000
Subject: [Intel-wired-lan] [PATCH S35 12/15] ice: suppress
 checked_return error
In-Reply-To: <20191212111307.33566-12-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-12-anthony.l.nguyen@intel.com>
Message-ID: <24673b915ac4455fa9862cefbb92666b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 12/15] ice: suppress checked_return
> error
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Coverity reports an error that is not really an error; suppress it.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


