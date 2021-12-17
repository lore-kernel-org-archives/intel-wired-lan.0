From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Fri, 17 Dec 2021 15:23:55 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 4/6] ice: xsk: do not
 clear status_error0 for ntu + nb_buffs descriptor
In-Reply-To: <20211213153111.110877-5-maciej.fijalkowski@intel.com>
References: <20211213153111.110877-1-maciej.fijalkowski@intel.com>
 <20211213153111.110877-5-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB3292039CD30AE96145240042F1789@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Monday, December 13, 2021 9:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mathew, Elza <elza.mathew@intel.com>; netdev at vger.kernel.org;
> kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 4/6] ice: xsk: do not clear
> status_error0 for ntu + nb_buffs descriptor
> 
> The descriptor that ntu is pointing at when we exit
> ice_alloc_rx_bufs_zc() should not have its corresponding DD bit cleared as
> descriptor is not allocated in there and it is not valid for HW usage.
> 
> The allocation routine at the entry will fill the descriptor that ntu points to
> after it was set to ntu + nb_buffs on previous call.
> 
> Even the spec says:
> "The tail pointer should be set to one descriptor beyond the last empty
> descriptor in host descriptor ring."
> 
> Therefore, step away from clearing the status_error0 on ntu + nb_buffs
> descriptor.
> 
> Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
> Reported-by: Elza Mathew <elza.mathew@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
