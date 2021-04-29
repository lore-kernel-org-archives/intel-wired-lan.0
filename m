From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 29 Apr 2021 13:02:15 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Update driver to use
 ethtool_sprintf
In-Reply-To: <20210412144107.3659411-1-sasha.neftin@intel.com>
References: <20210412144107.3659411-1-sasha.neftin@intel.com>
Message-ID: <1140c282-5c57-5df8-70c5-ed03edb03fac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/04/2021 17:41, Sasha Neftin wrote:
> Complete to commit c8d4725e985d ("intel: Update drivers to use
> ethtool_sprintf")
> Update the igc driver to make use of ethtool_sprintf. The general idea
> is to reduce code size and overhead by replacing the repeated pattern of
> string printf statements and ETH_STRING_LEN counter increments.
> 
> Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 40 +++++++-------------
>   1 file changed, 14 insertions(+), 26 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
