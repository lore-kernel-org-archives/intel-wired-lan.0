From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 9 Jun 2016 21:58:07 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use software values when
 checking for Tx hangs in hot path
In-Reply-To: <20160609215605.19957-1-jacob.e.keller@intel.com>
References: <20160609215605.19957-1-jacob.e.keller@intel.com>
Message-ID: <1465509487.11216.15.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-06-09 at 14:56 -0700, Jacob Keller wrote:
> A previous patch added support to check for hardware tx pending in
> the
> fm10k_down routine. This support was intended to ensure that we
> accurately check what the hardware state is. However, checking for Tx
> hangs in this manor during the hotpath results in a large performance
> hit. Avoid this by making the hotpath check use the SW counters
> instead.
> 
> Fixes: a0f53cf49cb0 ("fm10k: use actual hardware registers when
> checking for pending Tx", 2016-06-08)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k.h??????|??2 +-
> ?drivers/net/ethernet/intel/fm10k/fm10k_main.c | 19 +++++++++++++++
> ----
> ?drivers/net/ethernet/intel/fm10k/fm10k_pci.c??|??2 +-
> ?3 files changed, 17 insertions(+), 6 deletions(-)

Changes in v2:
* add the file I missed before

This worked locally because I forgot a git-add on the fm10k.h file OOPS

Thanks,
Jake
