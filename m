From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Wed, 27 May 2020 22:29:35 +0000
Subject: [Intel-wired-lan] Is it just me? next-queue_dev-queue Compile
 problems with ice as a module.
In-Reply-To: <BYAPR11MB2888ACE728EDA5B9B758F5E8BCB10@BYAPR11MB2888.namprd11.prod.outlook.com>
References: <BYAPR11MB2888ACE728EDA5B9B758F5E8BCB10@BYAPR11MB2888.namprd11.prod.outlook.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986DBDD0@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Nope it is not just you.  I have been working on fixing it since last night.  The XDP changes from Bjorn is what caused all these issues.  I just have it all fixed up here in the next hour.

> -----Original Message-----
> From: Brown, Aaron F <aaron.f.brown@intel.com>
> Sent: Wednesday, May 27, 2020 15:07
> To: intel-wired-lan at osuosl.org
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Subject: Is it just me? next-queue_dev-queue Compile problems with ice as a
> module.
> 
> Hi all,
> 
> I'm getting a compile failure on a fresh pull of next-queue_dev-queue if I try to
> build a kernel with the ice driver included as a module.  It builds fine when I
> checkout master branch and build or if I de-select CONFIG_ICE in the .config.
> The failure I get is as follows:
> -----------------------------------------------
>   AR      net/core/built-in.a
>   AR      net/built-in.a
> u1519:[2]/usr/src/kernels/next-queue> cat err_make.log
> drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_vsi_cfg_rxq':
> drivers/net/ethernet/intel/ice/ice_base.c:410:37: error: 'struct xdp_umem' has
> no member named 'chunk_size_nohr'
>     ring->rx_buf_len = ring->xsk_umem->chunk_size_nohr -
>                                      ^
> drivers/net/ethernet/intel/ice/ice_base.c:412:8: error: 'struct ice_ring' has no
> member named 'zca'
>     ring->zca.free = ice_zca_free;
>         ^
> drivers/net/ethernet/intel/ice/ice_base.c:412:21: error: 'ice_zca_free' undeclared
> (first use in this function)
>     ring->zca.free = ice_zca_free;
>                      ^
> drivers/net/ethernet/intel/ice/ice_base.c:412:21: note: each undeclared identifier
> is reported only once for each function it appears in
> drivers/net/ethernet/intel/ice/ice_base.c:414:9: error: 'MEM_TYPE_ZERO_COPY'
> undeclared (first use in this function)
>          MEM_TYPE_ZERO_COPY,
>          ^
> drivers/net/ethernet/intel/ice/ice_base.c:415:14: error: 'struct ice_ring' has no
> member named 'zca'
>          &ring->zca);
>               ^
> drivers/net/ethernet/intel/ice/ice_base.c:422:8: error: 'struct ice_ring' has no
> member named 'zca'
>     ring->zca.free = NULL;
>         ^
> drivers/net/ethernet/intel/ice/ice_base.c:445:3: error: implicit declaration of
> function 'xsk_umem_has_addrs_rq' [-Werror=implicit-function-declaration]
>    if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
>    ^
> cc1: some warnings being treated as errors
> make[6]: *** [drivers/net/ethernet/intel/ice/ice_base.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> make[5]: *** [drivers/net/ethernet/intel/ice] Error 2
> make[4]: *** [drivers/net/ethernet/intel] Error 2
> make[3]: *** [drivers/net/ethernet] Error 2
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> u1519:[2]/usr/src/kernels/next-queue>
> -----------------------------------------------
> I bisected it down to this patch or one on either side:
> 714c21f ice: Check UMEM FQ size when allocating bufs I am not exactly sure as
> I had 0 steps left when I got here, but received a different message on compile
> instead:
> u1519:[2]/usr/src/kernels/next-queue> cat err_make.log
> drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_setup_rx_ctx':
> drivers/net/ethernet/intel/ice/ice_base.c:432:3: error: implicit declaration of
> function 'xsk_umem_has_addrs_rq' [-Werror=implicit-function-declaration]
>    if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
>    ^
> cc1: some warnings being treated as errors
> make[6]: *** [drivers/net/ethernet/intel/ice/ice_base.o] Error 1
> make[5]: *** [drivers/net/ethernet/intel/ice] Error 2
> make[4]: *** [drivers/net/ethernet/intel] Error 2
> make[3]: *** [drivers/net/ethernet] Error 2
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [sub-make] Error 2
> u1519:[2]/usr/src/kernels/next-queue>
> 
> I'm using a relatively minimal kernel so could easily be missing something that
> gets defined elsewhere.
> 

