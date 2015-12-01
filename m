From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 1 Dec 2015 22:52:53 +0000
Subject: [Intel-wired-lan] [next PATCH] igb: add 88E1543 initialization
	code
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E22C87@ORSMSX101.amr.corp.intel.com>
References: <309B89C4C689E141A5FF6A0C5FB2118B81E22C87@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E244BD@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Initialize the 88E1543 PHY.
>
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
> drivers/net/ethernet/intel/igb/e1000_82575.c   |    7 ++
> drivers/net/ethernet/intel/igb/e1000_defines.h |    1
> drivers/net/ethernet/intel/igb/e1000_phy.c     |   94 ++++++++++++++++++++++++
> drivers/net/ethernet/intel/igb/e1000_phy.h     |    1
> 4 files changed, 103 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
