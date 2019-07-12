From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 18:03:25 +0000
Subject: [Intel-wired-lan] [PATCH 09/19] fm10k: reduce the scope of the
 local msg variable
In-Reply-To: <20190708231236.20516-10-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
 <20190708231236.20516-10-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AC0F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, July 8, 2019 4:12 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 09/19] fm10k: reduce the scope of the local
> msg variable
> 
> The msg variable in the fm10k_mbx_validate_msg_size and
> fm10k_sm_mbx_transmit functions is only used within the do {} loop scope.
> Reduce its scope only to where it is used.
> 
> This was detected by cppcheck, and resolves the following warnings
> produced by that tool:
> 
> [fm10k_mbx.c:299]: (style) The scope of the variable 'msg' can be reduced.
> [fm10k_mbx.c:2004]: (style) The scope of the variable 'msg' can be reduced.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


