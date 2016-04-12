From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 22:04:05 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix default
 mac->ops.setup_link	for X550EM
In-Reply-To: <20160324165840.23586.31133.stgit@localhost6.localdomain6>
References: <20160324165840.23586.31133.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF4C3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, March 24, 2016 9:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix default mac->ops.setup_link for
> X550EM
> 
> X550EM_a/x did not have a default value for mac->ops.setup_link which was
> causing link issues for backplane devices.
> 
> This patch sets mac->ops.setup_link to ixgbe_setup_mac_link_X540 for
> X550EM_a/x which is also default for X550. This will result in
> mac->ops.setup_link calling the link setup function for the respective
> PHY type in case we do not need a special function to deal with it.
> 
> Reported-by: Ken Cox <jkc@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Link detected as expected
