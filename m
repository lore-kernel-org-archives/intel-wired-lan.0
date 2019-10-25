From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Oct 2019 23:38:12 +0000
Subject: [Intel-wired-lan] [PATCH S30 v3 8/9] ice: add build_skb()
 support
In-Reply-To: <20191024081125.6711-8-anthony.l.nguyen@intel.com>
References: <20191024081125.6711-1-anthony.l.nguyen@intel.com>
 <20191024081125.6711-8-anthony.l.nguyen@intel.com>
Message-ID: <fe492953ec8f4f98808c04999872e5ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 24, 2019 1:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 v3 8/9] ice: add build_skb() support
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


