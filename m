From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 22:32:21 +0000
Subject: [Intel-wired-lan] [PATCH S11 01/16] ice: Mark extack argument
 as __always_unused
In-Reply-To: <20190208205043.11975-2-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3661CD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 01/16] ice: Mark extack argument as
> __always_unused
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Commit 87b0984ebfab ("net: Add extack argument to ndo_fdb_add()") in
> net-next added an extended parameter to the .ndo_fdb_add op and
> changed
> ice_fdb_add() accordingly. Update the function header and add the
> __always_unused attribute to the new parameter to avoid -Wunused-
> parameter warnings.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


