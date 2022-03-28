From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 28 Mar 2022 16:58:27 +0200
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: link representors to
 PCI device
In-Reply-To: <20220328145828.10097-1-marcin.szycik@linux.intel.com>
References: <20220328145828.10097-1-marcin.szycik@linux.intel.com>
Message-ID: <20220328145828.10097-2-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Link port representors to parent PCI device to benefit from
systemd defined naming scheme.

Example from ip tool:
 - without linking:
  eth0 ...
 - with linking:
  eth0 ...
  altname enp24s0f0npf0vf0

The port representor name is being shown in altname, because the name is
longer than IFNAMSIZ (16) limit. Altname can be used in ip tool.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 848f2adea563..78ee82511329 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -333,6 +333,7 @@ static int ice_repr_add(struct ice_vf *vf)
 	repr->netdev->min_mtu = ETH_MIN_MTU;
 	repr->netdev->max_mtu = ICE_MAX_MTU;
 
+	SET_NETDEV_DEV(repr->netdev, ice_pf_to_dev(vf->pf));
 	err = ice_repr_reg_netdev(repr->netdev);
 	if (err)
 		goto err_netdev;
-- 
2.35.1

