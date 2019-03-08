From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:51:19 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 10/17] ice: Do not set LB_EN
 for prune switch rules
In-Reply-To: <20190227003523.28733-11-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 10/17] ice: Do not set LB_EN for
> prune switch rules
> 
> From: Christopher N Bednarz <christopher.n.bednarz@intel.com>
> 
> LB_EN for prune switch rules was causing all TX traffic to loopback to the
> internal switch and dropped.  When running bi-directional stress workloads
> with RDMA the RDPU would hang blocking tx and rx traffic.
> 
> Signed-off-by: Christopher N Bednarz <christopher.n.bednarz@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


