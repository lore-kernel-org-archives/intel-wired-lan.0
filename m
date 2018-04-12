From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Apr 2018 11:15:58 -0700
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: warn if the stat size is
 unknown
In-Reply-To: <20180412181559.4343-1-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
Message-ID: <20180412181559.4343-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change-Id: I80172c86be68bdd1e1df00b650877b686c718b0f
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Title: warn if the stat size is unknown
Change-type: DefectResolution
Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198024
Tested-by: nosbuild <nosbuild@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index e7e0e3c82fb2..e5a1da7ac711 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -265,6 +265,8 @@ static void __fm10k_add_ethtool_stats(u64 **data, void *pointer,
 			*((*data)++) = *(u8 *)p;
 			break;
 		default:
+			WARN_ONCE(1, "unexpected stat size for %s",
+				  stats[i].stat_string);
 			*((*data)++) = 0;
 		}
 	}
-- 
2.15.1.478.ga1e07cd25f8b

