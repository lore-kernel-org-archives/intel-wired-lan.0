From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 17 Nov 2021 20:26:17 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/6] devlink: Remove misleading
 internal_flags from health reporter dump
In-Reply-To: <cover.1637173517.git.leonro@nvidia.com>
References: <cover.1637173517.git.leonro@nvidia.com>
Message-ID: <cbca8d8874fe2dc9d7b13975705916907df90899.1637173517.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET command doesn't have .doit callback
and has no use in internal_flags at all. Remove this misleading assignment.

Fixes: e44ef4e4516c ("devlink: Hang reporter's dump method on a dumpit cb")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/core/devlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 5ba4f9434acd..1cb2e0ae9173 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -8838,8 +8838,6 @@ static const struct genl_small_ops devlink_nl_ops[] = {
 			    GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit = devlink_nl_cmd_health_reporter_dump_get_dumpit,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT |
-				  DEVLINK_NL_FLAG_NO_LOCK,
 	},
 	{
 		.cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR,
-- 
2.33.1

