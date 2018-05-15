From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 May 2018 22:52:08 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: force VF to grab new MAC
 on driver reload
In-Reply-To: <20180514181611.26797.30030.stgit@localhost6.localdomain6>
References: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
 <20180514181611.26797.30030.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B77150C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, May 14, 2018 11:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: force VF to grab new MAC on
> driver reload
> 
> Do not validate the MAC address during a reset, unless the MAC was set on
> the host. This way the VF will get a new MAC address every time it reloads.
> 
> Remove the "no MAC address assigned" message since it will get spammed
> on reset and it doesn't help much as the MAC on the VF is randomly
> generated.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


