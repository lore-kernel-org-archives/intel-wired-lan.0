From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Wed, 6 Oct 2021 15:20:53 +0300
Subject: [Intel-wired-lan] [PATCH v1 2/2] e1000e: Fixing packet loss
 issues on new platforms
In-Reply-To: <20210922065542.3780389-1-sasha.neftin@intel.com>
References: <20210922065542.3780389-1-sasha.neftin@intel.com>
Message-ID: <99d87768-acf3-b549-d3e9-ad9ae3c81a32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/22/2021 09:55, Sasha Neftin wrote:
> Update the HW MAC initialization flow. Do not gate DMA clock from
> the modPHY block. Keeping this clock will prevent drop packets sent
> in burst mode on the Kumeran interface.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213651
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213377
> Fixes: bc7f75fa9788 ("New pci-express e1000 driver");
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++++++++++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

