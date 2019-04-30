From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:54:12 +0000
Subject: [Intel-wired-lan] [PATCH S21 07/14] ice: Change minimum
 descriptor count value for Tx/Rx rings
In-Reply-To: <20190416173503.29847-8-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AFAD@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 07/14] ice: Change minimum descriptor
> count value for Tx/Rx rings
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Change minimum number of descriptor count from 32 to 64. This is to have a
> feature parity with previous Intel NIC drivers.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


