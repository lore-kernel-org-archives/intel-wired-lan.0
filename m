From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 May 2018 22:52:37 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix MAC address changes
 through ixgbevf_set_mac()
In-Reply-To: <20180514181616.26797.73490.stgit@localhost6.localdomain6>
References: <20180514181449.26797.30080.stgit@localhost6.localdomain6>
 <20180514181616.26797.73490.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B77151C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix MAC address changes
> through ixgbevf_set_mac()
> 
> Set hw->mac.perm_addr in ixgbevf_set_mac() in order to avoid losing the
> custom MAC on reset. This can happen in the following case:
> 
> >ip link set $vf address $mac
> >ethtool -r $vf
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


