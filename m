From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 17 Nov 2015 01:34:33 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use ether_addr_equal
 instead of	memcmp
In-Reply-To: <1447716814-4908-1-git-send-email-jacob.e.keller@intel.com>
References: <1447716814-4908-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847ECAAECD@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, November 16, 2015 3:34 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [PATCH v2] fm10k: use ether_addr_equal instead
> of memcmp
> 
> When comparing MAC addresses, use ether_addr_equal instead of
> memcmp to
> ETH_ALEN length. Found and replaced using the following sed:
> 
>  sed -e 's/memcmp\x28\(.*\),
> ETH_ALEN\x29/!ether_addr_equal\x28\1\x29/'
> 
> Reported-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> Notes:
> 
>     This replaces the version on the queue inline and corrects issues
>     with all 4 tests that were replaced. It should fix the mailbox
>     ethtool test among other possible issues.
> 
>     - v2
>     * correct sed expression and fix mis-use of ether_addr_equal
> 
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c  | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.c | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
