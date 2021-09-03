From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 3 Sep 2021 06:40:42 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 5/9] ice: do not create
 xdp_frame on XDP_TX
In-Reply-To: <20210819120004.34392-6-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-6-maciej.fijalkowski@intel.com>
Message-ID: <PH0PR11MB5144474F59154C5DC3CAC56AE2CF9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej
> Fijalkowski
> Sent: Thursday, August 19, 2021 5:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 5/9] ice: do not create xdp_frame on
> XDP_TX
> 
> xdp_frame is not needed for XDP_TX data path in ice driver case.
> For this data path cleaning of sent descriptor will not happen anywhere outside of
> the driver, which means that carrying the information about the underlying memory
> model via xdp_frame will not be used. Therefore, this conversion can be simply
> dropped, which would relieve CPU a bit.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
