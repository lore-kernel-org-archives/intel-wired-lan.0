From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 20 Jun 2015 03:10:19 +0000
Subject: [Intel-wired-lan] [PATCH v2] igb: report unsupported
	ethtool	settings in set_coalesce
In-Reply-To: <20150604212640.7229.93966.stgit@htfujina-fc.jf.intel.com>
References: <20150604212640.7229.93966.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DF8635@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Thursday, June 04, 2015 2:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igb: report unsupported ethtool
> settings in set_coalesce
> 
> There are many settings possible using ethtool -C/--coalesce, but not
> all of them are supported in igb. Report failure when an unsupported
> option is set.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
