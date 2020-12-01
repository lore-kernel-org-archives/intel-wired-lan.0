From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 1 Dec 2020 14:48:52 +0000
Subject: [Intel-wired-lan] [net 5/6] ice: use correct xdp_ring with
 XDP_TX action
In-Reply-To: <20201121003835.48424-5-anthony.l.nguyen@intel.com>
References: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
 <20201121003835.48424-5-anthony.l.nguyen@intel.com>
Message-ID: <SN6PR11MB30085372A7EE4A42BE081F54E2F40@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Saturday, November 21, 2020 6:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net 5/6] ice: use correct xdp_ring with XDP_TX action
> 
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> XDP queue number for XDP_TX action is used inconsistently and may result with
> no packets transmitted. Fix queue number used by the driver when doing
> XDP_TX, i.e. use receive queue number as in ice_finalize_xdp_rx.
> 
> Also, using smp_processor_id() is wrong here and won't work with less queues.
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>

