From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:20:14 +0000
Subject: [Intel-wired-lan] [PATCH S9 04/15] ice: Destroy scheduler tree
 in reset path
In-Reply-To: <20181026184447.13547-5-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328DC9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 04/15] ice: Destroy scheduler tree in
> reset path
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The scheduler tree is is always rebuilt during reset. The existing code adds
> new scheduler nodes for queues but may not clean up earlier nodes.
> This patch removed the old scheduler tree during reset before it is rebuilt.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


