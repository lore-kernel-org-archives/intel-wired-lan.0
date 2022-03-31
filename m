From: Nagaraju, Shwetha <shwetha.nagaraju@intel.com>
Date: Thu, 31 Mar 2022 10:21:57 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: xsk: check if Rx ring
 was filled up to the end
In-Reply-To: <20220317175727.340251-1-maciej.fijalkowski@intel.com>
References: <20220317175727.340251-1-maciej.fijalkowski@intel.com>
Message-ID: <MW4PR11MB582268F689B8EC10514112B090E19@MW4PR11MB5822.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, March 17, 2022 11:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-next] ice: xsk: check if Rx ring was
> filled up to the end
> 
> __ice_alloc_rx_bufs_zc() checks if a number of the descriptors to be
> allocated would cause the ring wrap. In that case, driver will issue two calls to
> xsk_buff_alloc_batch() - one that will fill the ring up to the end and the
> second one that will start with filling descriptors from the beginning of the
> ring.
> 
> ice_fill_rx_descs() is a wrapper for taking care of what
> xsk_buff_alloc_batch() gave back to the driver. It works in a best effort
> approach, so for example when driver asks for 64 buffers,
> ice_fill_rx_descs() could assign only 32. Such case needs to be checked when
> ring is being filled up to the end, because in that situation ntu might not
> reached the end of the ring.
> 
> Fix the ring wrap by checking if nb_buffs_extra has the expected value.
> If not, bump ntu and go directly to tail update.
> 
> Fixes: 3876ff525de7 ("ice: xsk: Handle SW XDP ring wrap and bump tail more
> often")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
Tested-by: Shwetha Nagaraju <Shwetha.nagaraju@intel.com>
