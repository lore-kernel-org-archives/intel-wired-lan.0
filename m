From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Sep 2016 17:01:05 +0000
Subject: [Intel-wired-lan] [next PATCH] ixgbe: reset before SRIOV init
 to	avoid mailbox issues
In-Reply-To: <20160909195910.32272.11650.stgit@localhost6.localdomain6>
References: <20160909195910.32272.11650.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCD34@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, September 09, 2016 12:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH] ixgbe: reset before SRIOV init to
> avoid mailbox issues
> 
> Enabling SRIOV while the ixgbevf driver is loaded will result in all mailbox
> requests from ixgbevf_open() being rejected by ixgbe because
> adapter->clear_to_send is set to false on reset.
> 
> Call ixgbe_sriov_reinit() before pci_enable_sriov() to make sure that mailbox
> requests are handled from the time ixgbevf is loaded.
> 
> Reported-by: Andrew Bowers <andrewx.bowers@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Issue is no longer present

