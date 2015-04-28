From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Apr 2015 03:22:17 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next 3/3] igb: add PHY support
	for Broadcom 54616
In-Reply-To: <1428707018-6405-3-git-send-email-jtoppins@cumulusnetworks.com>
References: <1428707018-6405-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1428707018-6405-3-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBB085@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jonathan Toppins
> Sent: Friday, April 10, 2015 4:04 PM
> To: Kirsher, Jeffrey T
> Cc: Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
> C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; gospo at cumulusnetworks.com;
> shm at cumulusnetworks.com; Alan Liebthal
> Subject: [PATCH v1 net-next 3/3] igb: add PHY support for Broadcom 54616
> 
> From: Alan Liebthal <alanl@cumulusnetworks.com>
> 
> The Celestica Redstone-XP Ethernet management port uses a Broadcom 54616
> chip for the PHY layer. This adds support for this PHY to the Intel igb
> e1000 driver.
> 
> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c   |    5 +++++
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    1 +
>  drivers/net/ethernet/intel/igb/e1000_hw.h      |    1 +
>  3 files changed, 7 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Again, just regression, I do not have this phy.
