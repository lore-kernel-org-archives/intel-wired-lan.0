From: Mauro Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2018 22:50:07 -0300
Subject: [Intel-wired-lan] [next PATCH S95 06/12] i40e: fix condition of
 WARN_ONCE for stat strings
In-Reply-To: <20180820151233.14629-6-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-6-alice.michael@intel.com>
Message-ID: <20180824015006.GA10433@korriban>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 20, 2018 at 08:12:27AM -0700, Alice Michael wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit 9b10df596bd4 ("i40e: use WARN_ONCE to replace the commented
> BUG_ON size check") introduced a warning check to make sure
> that the size of the stat strings was always the expected value. This
> code accidentally inverted the check of the data pointer. Fix this so
> that we accurately count the size of the stats we copied in.
> 
> This fixes an erroneous WARN kernel splat that occurs when requesting
> ethtool statistics.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

