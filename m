From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:51:56 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 17/17] ice: Enable link events
 over the ARQ
In-Reply-To: <20190227003523.28733-18-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-18-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368F84@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S13 v2 17/17] ice: Enable link events over
> the ARQ
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The hardware now supports link events over the admin receive queue
> (ARQ), so enable HW link events over the ARQ and remove code for link
> event polling.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 28 +++++++++++-
> drivers/net/ethernet/intel/ice/ice_common.h |  6 +++
>  drivers/net/ethernet/intel/ice/ice_main.c   | 68
> +++++++++++++++++++++++++++--
>  3 files changed, 98 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


