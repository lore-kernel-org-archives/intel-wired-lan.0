From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 9 Jun 2016 20:45:44 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix spoofed packets with
 macvlans
In-Reply-To: <20160602015944.28731.47045.stgit@localhost6.localdomain6>
References: <20160602015944.28731.47045.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E497E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, June 01, 2016 7:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix spoofed packets with macvlans
> 
> When setting spoofing both vlan and mac need to be set together.
> This change resolves an issue where mac-vlans on the VF fail to pass traffic
> due to spoofed packets.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
macvlan traffic passes normally
