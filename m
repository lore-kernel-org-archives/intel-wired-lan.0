From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:50:04 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 08/17] ice: Add support for
 PF/VF promiscuous mode
In-Reply-To: <20190227003523.28733-9-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F5C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S13 v2 08/17] ice: Add support for PF/VF
> promiscuous mode
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Implement support for VF promiscuous mode, MAC/VLAN/MAC_VLAN and
> PF multicast MAC/VLAN/MAC_VLAN promiscuous mode.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  18 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c         |   9 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h         |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c        |  91 ++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c      | 291
> ++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.h      |  22 ++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 125 ++++++++--
>  7 files changed, 527 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


