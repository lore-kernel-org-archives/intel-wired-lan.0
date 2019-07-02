From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:53:48 +0000
Subject: [Intel-wired-lan] [PATCH S22 08/16] ice: Only bump Rx tail and
 release buffers once per napi_poll
In-Reply-To: <20190626092027.52845-8-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-8-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE28@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Creeley, Brett <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 08/16] ice: Only bump Rx tail and
> release buffers once per napi_poll
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we bump the Rx tail and release/give buffers to hardware every
> 16 descriptors. This causes us to bump Rx tail up to 4 times per napi_poll call.
> Also we are always bumping tail on an odd index and this is a problem
> because hardware ignores the lower 3 bits in the QRX_TAIL register. This is
> making it so hardware sees tail bumps only every 8 descriptors. Instead lets
> only bump Rx tail once per napi_poll if the value aligns with hardwares
> expectations of the lower 3 bits being cleared. Also only release/give Rx
> buffers once per napi_poll call.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 41 +++++++++++++++--------
>  1 file changed, 27 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


