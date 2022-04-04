From: Nagaraju, Shwetha <shwetha.nagaraju@intel.com>
Date: Mon, 4 Apr 2022 04:34:21 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 3/3] ice: clear
 cmd_type_offset_bsz for TX rings
In-Reply-To: <20220317183629.340350-4-maciej.fijalkowski@intel.com>
References: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
 <20220317183629.340350-4-maciej.fijalkowski@intel.com>
Message-ID: <MW4PR11MB582222B135FDD63795ED3C8E90E59@MW4PR11MB5822.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Friday, March 18, 2022 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net 3/3] ice: clear
> cmd_type_offset_bsz for TX rings
> 
> Currently when XDP rings are created, each descriptor gets its DD bit set,
> which turns out to be the wrong approach as it can lead to a situation where
> more descriptors get cleaned than it was supposed to, e.g. when AF_XDP
> busy poll is run with a large batch size. In this situation, the driver would
> request for more buffers than it is able to handle.
> 
> Fix this by not setting the DD bits in ice_xdp_alloc_setup_rings(). They should
> be initialized to zero instead.
> 
> Fixes: 9610bd988df9 ("ice: optimize XDP_TX workloads")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Shwetha Nagaraju <Shwetha.nagaraju@intel.com>

