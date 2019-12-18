From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:32:55 +0000
Subject: [Intel-wired-lan] [PATCH S35 13/15] ice: add extra check for
 null rx descriptor
In-Reply-To: <20191212111307.33566-13-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-13-anthony.l.nguyen@intel.com>
Message-ID: <6e71d54ba14d4f7898136b3346119b51@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S35 13/15] ice: add extra check for null rx
> descriptor
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In the case where the hardware gives us a null rx descriptor, it is theoretically
> possible that we could call one of our skb-construction functions with no data
> pointer, which would cause a panic.
> 
> In real life, this will never happen - we only get null RX descriptors as the final
> descriptor in a chain of otherwise-valid descriptors. When this happens, the
> skb will be extant and we'll just call ice_add_rx_frag(), which can deal with
> empty data buffers.
> 
> Unfortunately, Coverity does not have intimate knowledge of our hardware,
> so we must add a check here.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


