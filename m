From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:40:16 +0000
Subject: [Intel-wired-lan] [PATCH S10 11/15] ice: Implement getting and
 setting ethtool coalesce
In-Reply-To: <20181219180334.1104-12-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A79@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 11/15] ice: Implement getting and
> setting ethtool coalesce
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> This patch includes the following ethtool operations:
> 
> 1. get_coalesce
> 2. set_coalesce
> 3. get_per_q_coalesce
> 4. set_per_q_coalesce
> 
> Each itr value (current_itr/target_itr) are stored on a per ice_ring_container
> basis. This is because each valid ice_ring_container can have 1 or more rings
> that are tied to the same q_vector ITR index.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   3 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 256
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |   2 +
>  3 files changed, 261 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


