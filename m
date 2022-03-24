From: naamax.meir <naamax.meir@linux.intel.com>
Date: Thu, 24 Mar 2022 12:23:06 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix BUG: scheduling while
 atomic: kworker/u64:0/9/0x00000002
In-Reply-To: <20220308092422.2971655-1-sasha.neftin@intel.com>
References: <20220308092422.2971655-1-sasha.neftin@intel.com>
Message-ID: <66d6caf7-3524-690f-e0af-d2642517bee1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/8/2022 11:24, Sasha Neftin wrote:
> Replace usleep_range() method with udelay() method to allow atomic contects
> in low-level MDIO access functions.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2014971
> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
> Reported-by: Corinna Vinschen <vinschen@redhat.com>
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_phy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
