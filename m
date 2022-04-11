From: naamax.meir <naamax.meir@linux.intel.com>
Date: Mon, 11 Apr 2022 14:11:45 +0300
Subject: [Intel-wired-lan] [PATCH net-queue v1] igc: Fix suspending when
 PTM is active
In-Reply-To: <20220405205437.29829-1-vinicius.gomes@intel.com>
References: <20220405205437.29829-1-vinicius.gomes@intel.com>
Message-ID: <116e8d8a-a63f-c894-eb3b-84d57bcace6b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/5/2022 23:54, Vinicius Costa Gomes wrote:
> Some mainboard/CPU combinations have shown problems with
> suspend/resume when PCIe PTM is enabled and active.
> 
> The best we can do is to stop PTM dialogs from the downstream/device
> side before the interface is brought down. PCIe PTM will be
> re-enabled when the interface is being brought up.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> Stefan,
> 
> I believe that this should be a more general solution to the problem you reported in
> https://lore.kernel.org/all/924175a188159f4e03bd69908a91e606b574139b.camel at gmx.de/
> 
> Would it be possible for you revert commit 1e81dcc1ab7d ("igc: Do not
> enable crosstimestamping for i225-V models") and apply this one, and
> see if it works for you? I don't have your exact setup.
> 
> Cheers,
> 
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)Tested-by: Naama Meir <naamax.meir@linux.intel.com>
