From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 18 Aug 2015 02:57:14 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: add support for 1512 PHY
In-Reply-To: <20150729143119.19466.3645.stgit@htfujina-fc.jf.intel.com>
References: <20150729143119.19466.3645.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE8768@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Wednesday, July 29, 2015 7:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igb: add support for 1512 PHY
> 
> This patch adds support for Marvell PHY 1512 (required for I354).
> 
> Submitted by: Maciej Szwed <maciej.szwed@intel.com>
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c   |   20 ++++-
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    5 +
>  drivers/net/ethernet/intel/igb/e1000_phy.c     |   93
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/igb/e1000_phy.h     |    1
>  4 files changed, 114 insertions(+), 5 deletions(-)

I do not have access to a system with the 1512 PHY, but am told that the PHY functionality has been tested.  Regression testing against the set of systems I do have did not uncover any problems introduced, so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
