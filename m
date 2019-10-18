From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 18 Oct 2019 00:18:33 +0000
Subject: [Intel-wired-lan] [PATCH S30 v2 8/9] ice: add build_skb()
 support
In-Reply-To: <20191016150201.41597-8-anthony.l.nguyen@intel.com>
References: <20191016150201.41597-1-anthony.l.nguyen@intel.com>
 <20191016150201.41597-8-anthony.l.nguyen@intel.com>
Message-ID: <20f540280ee944ecad0f9ddf379ff26b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 16, 2019 8:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 v2 8/9] ice: add build_skb() support
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Driver is now prepared for building the skb around the existing Rx buffer, so
> introduce the ice_build_skb responsible for it. Make use of XDP's data_meta
> as well.
> 
> I've observed around 30% less CPU consumption with build_skb Rx path, in
> comparison to legacy Rx. What stands behind such result is the avoidance of
> flow_dissector (which we were diving into via eth_get_headlen) and no
> memcpy calls.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 60 ++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

